-- Create organizations table
create table public.organizations (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    slug text unique not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create type organization_role as enum ('owner', 'admin', 'member');

create table public.accounts (
    user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
    organization_id uuid references public.organizations(id) on delete cascade null,
    role organization_role null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- Create RLS policies
alter table organizations enable row level security;
alter table accounts enable row level security;

-- Organizations policies
create policy "Users can view organizations they are members of"
    on public.organizations
    for select
    to authenticated
    using (
        exists (
            select 1 from public.accounts
            where public.accounts.organization_id = public.organizations.id
            and public.accounts.user_id = auth.uid()
        )
    );

create policy "Organization owners and admins can update their organizations"
    on public.organizations
    for update
    to authenticated
    using (
        exists (
            select 1 from public.accounts
            where public.accounts.organization_id = public.organizations.id
            and public.accounts.user_id = auth.uid()
            and public.accounts.role in ('owner', 'admin')
        )
    );

-- Organization members policies
create policy "Users can view members in their organizations" on public.accounts
    for select to authenticated using (
        organization_id in (
            select organization_id from public.accounts
            where user_id = auth.uid()
        )
    );

create policy "Organization owners can manage members" on public.accounts
    for all to authenticated using (
        exists (
            select 1 from public.accounts a
            where a.organization_id = public.accounts.organization_id
            and a.user_id = auth.uid()
            and a.role = 'owner'
        )
    );

-- Create triggers to handle updated_at
create or replace function update_updated_at_column()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;

create trigger update_organizations_updated_at
    before update on public.organizations
    for each row
    execute function update_updated_at_column();

create trigger update_accounts_updated_at
    before update on public.accounts
    for each row
    execute function update_updated_at_column();

create or replace function public.custom_access_token_hook(event jsonb)
returns jsonb
language plpgsql
stable
as $$
declare
  claims         jsonb;
  user_tenant_id uuid;
begin
  select organization_id
    into user_tenant_id
    from public.accounts
   where user_id = (event->>'user_id')::uuid
   limit 1;

  claims := event->'claims';

  if user_tenant_id is not null then
    claims := jsonb_set(claims, '{tenant_id}', to_jsonb(user_tenant_id));
  else
    claims := jsonb_set(claims, '{tenant_id}', 'null');
  end if;

  event := jsonb_set(event, '{claims}', claims);

  return event;
end;
$$;