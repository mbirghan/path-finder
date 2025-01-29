create table "public"."files" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "owner_id" uuid default auth.uid(),
    "file_name" text not null,
    "storage_url" text not null
);


alter table "public"."files" enable row level security;

-- Policy to control SELECT operations
CREATE POLICY "Users can view their own files" ON "public"."files"
FOR SELECT
USING (auth.uid() = owner_id);

-- Policy to control INSERT operations
CREATE POLICY "Users can insert their own files" ON "public"."files"
FOR INSERT
WITH CHECK (auth.uid() = owner_id);

-- Policy to control UPDATE operations
CREATE POLICY "Users can update their own files" ON "public"."files"
FOR UPDATE
USING (auth.uid() = owner_id)
WITH CHECK (auth.uid() = owner_id);

-- Policy to control DELETE operations
CREATE POLICY "Users can delete their own files" ON "public"."files"
FOR DELETE
USING (auth.uid() = owner_id);

CREATE UNIQUE INDEX files_pkey ON public.files USING btree (id);

alter table "public"."files" add constraint "files_pkey" PRIMARY KEY using index "files_pkey";

alter table "public"."files" add constraint "files_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES accounts(user_id) ON DELETE SET NULL not valid;

alter table "public"."files" validate constraint "files_owner_id_fkey";

grant delete on table "public"."files" to "anon";

grant insert on table "public"."files" to "anon";

grant references on table "public"."files" to "anon";

grant select on table "public"."files" to "anon";

grant trigger on table "public"."files" to "anon";

grant truncate on table "public"."files" to "anon";

grant update on table "public"."files" to "anon";

grant delete on table "public"."files" to "authenticated";

grant insert on table "public"."files" to "authenticated";

grant references on table "public"."files" to "authenticated";

grant select on table "public"."files" to "authenticated";

grant trigger on table "public"."files" to "authenticated";

grant truncate on table "public"."files" to "authenticated";

grant update on table "public"."files" to "authenticated";

grant delete on table "public"."files" to "service_role";

grant insert on table "public"."files" to "service_role";

grant references on table "public"."files" to "service_role";

grant select on table "public"."files" to "service_role";

grant trigger on table "public"."files" to "service_role";

grant truncate on table "public"."files" to "service_role";

grant update on table "public"."files" to "service_role";
