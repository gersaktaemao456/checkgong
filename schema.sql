-- Run in Supabase SQL editor. All tables deny client access until explicit policies are added.
create table if not exists public.profiles (id uuid primary key references auth.users(id) on delete cascade, display_name text, created_at timestamptz not null default now());
create table if not exists public.websites (id uuid primary key default gen_random_uuid(), domain text not null unique, created_at timestamptz not null default now());
create table if not exists public.reports (id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id), website_id uuid not null references public.websites(id), description text not null, status text not null default 'pending' check(status in ('pending','reviewing','verified','rejected','resolved')), created_at timestamptz not null default now());
create table if not exists public.evidence (id uuid primary key default gen_random_uuid(), report_id uuid not null references public.reports(id), storage_path text not null, created_at timestamptz not null default now());
create table if not exists public.audit_logs (id bigint generated always as identity primary key, actor_id uuid references auth.users(id), action text not null, target_id uuid, created_at timestamptz not null default now());
alter table public.profiles enable row level security;
alter table public.websites enable row level security;
alter table public.reports enable row level security;
alter table public.evidence enable row level security;
alter table public.audit_logs enable row level security;
revoke all on public.profiles,public.websites,public.reports,public.evidence,public.audit_logs from anon,authenticated;
grant select,update on public.profiles to authenticated;
create policy "Read own profile" on public.profiles for select to authenticated using ((select auth.uid())=id);
create policy "Update own profile" on public.profiles for update to authenticated using ((select auth.uid())=id) with check ((select auth.uid())=id);
-- Admin actions and report submission should be implemented via validated server routes.
