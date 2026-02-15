-- 08_views.sql
-- Reusable views for cleaner querying

-- Global daily totals
CREATE OR REPLACE VIEW vw_global_daily_totals AS
SELECT
  date,
  SUM(new_cases) AS global_new_cases,
  SUM(new_deaths) AS global_new_deaths
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date;

-- Latest per-country snapshot (cases/deaths)
CREATE OR REPLACE VIEW vw_country_latest_snapshot AS
SELECT
  d.location,
  MAX(d.date) AS latest_date,
  MAX(d.population) AS population,
  MAX(d.total_cases) AS total_cases,
  MAX(d.total_deaths) AS total_deaths,
  MAX(d.total_deaths_per_million) AS deaths_per_million,
  ROUND(MAX(d.total_deaths) / NULLIF(MAX(d.total_cases), 0) * 100, 2) AS cfr_pct
FROM coviddeaths d
WHERE d.continent IS NOT NULL
GROUP BY d.location;

-- Latest vaccination snapshot per country
CREATE OR REPLACE VIEW vw_vax_latest_snapshot AS
SELECT
  location,
  MAX(date) AS latest_date,
  MAX(people_vaccinated_per_hundred) AS vaccinated_per_100,
  MAX(people_fully_vaccinated_per_hundred) AS fully_vax_per_100,
  MAX(total_vaccinations_per_hundred) AS total_doses_per_100
FROM covidvaccinations
WHERE continent IS NOT NULL
GROUP BY location;


