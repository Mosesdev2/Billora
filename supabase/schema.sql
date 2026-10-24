-- Billora database schema
-- Run this in Supabase SQL Editor after creating your project.

create extension if not exists pgcrypto;

create table if not exists public.businesses (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  email text default '',
  phone text default '',
  address text default '',
  tax_pin text default '',
  currency text not null default 'KES',
  logo_url text default '',
  created_at timestamptz not null default now()
);

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.businesses(id) on delete cascade,
  name text not null,
  email text default '',
  phone text default '',
  address text default '',
  created_at timestamptz not null default now()
);

create table if not exists public.documents (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.businesses(id) on delete cascade,
  customer_id uuid references public.customers(id) on delete set null,
  doc_type text not null check (doc_type in ('invoice', 'quotation')),
  doc_number text not null,
  status text not null default 'unpaid',
  issue_date date not null default current_date,
  due_date date,
  customer_name text not null,
  customer_email text default '',
  customer_phone text default '',
  currency text not null default 'KES',
  subtotal numeric(14,2) not null default 0,
  tax numeric(14,2) not null default 0,
  discount numeric(14,2) not null default 0,
  total numeric(14,2) not null default 0,
  amount_paid numeric(14,2) not null default 0,
  notes text default '',
  items jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  unique (business_id, doc_number)
);

create table if not exists public.payments (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.businesses(id) on delete cascade,
  document_id uuid not null references public.documents(id) on delete cascade,
  amount numeric(14,2) not null check (amount > 0),
  method text not null check (
    method in ('M-Pesa', 'Cash', 'Bank transfer', 'Card', 'Other')
  ),
  reference text default '',
  paid_at timestamptz not null default now(),
  receipt_number text not null,
  created_at timestamptz not null default now()
);

create index if not exists businesses_owner_idx
  on public.businesses(owner_id);

create index if not exists customers_owner_idx
  on public.customers(owner_id);

create index if not exists documents_owner_idx
  on public.documents(owner_id);

create index if not exists payments_owner_idx
  on public.payments(owner_id);

alter table public.businesses enable row level security;
alter table public.customers enable row level security;
alter table public.documents enable row level security;
alter table public.payments enable row level security;

create policy "own businesses"
  on public.businesses for all
  using (auth.uid() = owner_id)
  with check (auth.uid() = owner_id);

create policy "own customers"
  on public.customers for all
  using (auth.uid() = owner_id)
  with check (auth.uid() = owner_id);

create policy "own documents"
  on public.documents for all
  using (auth.uid() = owner_id)
  with check (auth.uid() = owner_id);

create policy "own payments"
  on public.payments for all
  using (auth.uid() = owner_id)
  with check (auth.uid() = owner_id);

-- Never expose the Supabase service_role key in frontend code.

