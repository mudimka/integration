-- Таблица исторических данных о запчастях.
-- Создаётся автоматически при первом запуске workflow (узел "Create Table")
-- и при старте контейнера Postgres через docker-compose.

CREATE TABLE IF NOT EXISTS spares (
  spare_code        text PRIMARY KEY,           -- естественный ключ из CMS
  spare_name        text,
  spare_description text,
  spare_type        text,
  spare_status      text,
  price             text,                       -- хранится как пришло из CMS (без преобразований)
  quantity          integer,
  updated_at        text,                       -- хранится как пришло из CMS
  first_seen_at     timestamptz DEFAULT now(),  -- когда деталь впервые попала в нашу БД
  last_seen_at      timestamptz,                -- когда деталь последний раз была в выгрузке CMS
  is_active         boolean DEFAULT true        -- false: детали больше нет в CMS
);

CREATE INDEX IF NOT EXISTS idx_spares_is_active ON spares (is_active);
