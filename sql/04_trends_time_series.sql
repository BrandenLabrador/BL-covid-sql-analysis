-- 04_trends_time_series.sql
-- Time-series analysis

-- Monthly global totals
SELECT
  DATE_FORMAT(date, '%Y-%m') AS year_month,
  SUM(new_cases) AS cases_in_month,
  SUM(new_deaths) AS deaths_in_month
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY year_month;

-- Find peak month for deaths
SELECT
  DATE_FORMAT(date, '%Y-%m') AS year_month,
  SUM(new_deaths) AS deaths_in_month
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY deaths_in_month DESC
LIMIT 10;

-- Trend for a "country spotlight" (edit countries you care about)
SELECT
  location,
  date,
  total_cases,
  total_deaths,
  new_cases,
  new_deaths
FROM coviddeaths
WHERE location IN ('United States', 'Italy', 'Brazil')
ORDER BY location, date;

