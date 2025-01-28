SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '8dee7c20-e611-48ba-9a4b-bf508bf652eb', 'authenticated', 'authenticated', 'mb@mbirghan.com', '$2a$10$2W76VFE7fmcBQJhzWVkmXOMwzLIGXcagUhbaPn0.OU8S/FXqrSC0m', '2025-01-28 18:12:32.852019+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-01-28 18:12:32.847077+00', '2025-01-28 18:12:32.852596+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'f1f6d447-20c0-474d-8a3a-cf521103f553', 'authenticated', 'authenticated', 'test@impozter.com', '$2a$10$61agQOCYwdhB3cCeIN.pU.SjeaQG45WoD2jhH3bfWMcPy308bOxt2', '2025-01-28 18:14:44.380231+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-01-28 18:14:44.378149+00', '2025-01-28 18:14:44.380845+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."organizations" ("id", "name", "slug", "created_at", "updated_at") VALUES
	('adc1b07d-b679-4b17-8f61-b6c76c934f2c', 'Impozter', 'imp', '2025-01-28 18:16:26.327838+00', '2025-01-28 18:16:52.229913+00'),
	('df385475-0e89-44c2-a930-d990128ee605', 'mbirghan', 'mbirghan', '2025-01-28 18:15:55.157703+00', '2025-01-28 18:16:56.744315+00');


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."accounts" ("user_id", "organization_id", "role", "created_at", "updated_at") VALUES
	('8dee7c20-e611-48ba-9a4b-bf508bf652eb', 'df385475-0e89-44c2-a930-d990128ee605', 'owner', '2025-01-28 18:18:45.241217+00', '2025-01-28 18:18:45.241217+00'),
	('f1f6d447-20c0-474d-8a3a-cf521103f553', 'adc1b07d-b679-4b17-8f61-b6c76c934f2c', 'member', '2025-01-28 18:19:00.420779+00', '2025-01-28 18:19:00.420779+00');


RESET ALL;
