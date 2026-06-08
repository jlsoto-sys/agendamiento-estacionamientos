-- Ejecuta este script en el SQL Editor de tu proyecto Supabase
-- (Dashboard → SQL Editor → New query → pega esto → Run)

create table if not exists reservations (
  id        uuid primary key default gen_random_uuid(),
  nombre    text not null,
  email     text not null,
  spot      text not null,
  fecha     date not null,
  inicio    time not null,
  fin       time not null,
  status    text not null default 'active',  -- 'active' | 'cancelled'
  created_at timestamptz default now()
);

-- Índices para búsquedas frecuentes
create index if not exists idx_reservations_spot_fecha on reservations(spot, fecha);
create index if not exists idx_reservations_email      on reservations(email);
create index if not exists idx_reservations_status     on reservations(status);

-- Política de acceso público (Row Level Security)
-- Permite leer y escribir sin autenticación (acceso público)
alter table reservations enable row level security;

create policy "allow_public_read"
  on reservations for select
  using (true);

create policy "allow_public_insert"
  on reservations for insert
  with check (true);

create policy "allow_public_update"
  on reservations for update
  using (true);
