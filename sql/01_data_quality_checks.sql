-- 01_data_quality_checks.sql
-- Basic sanity checks that make your project look professional

-- Row counts
SELECT 'coviddeaths' AS table_name, COUNT(*) AS row_count FROM coviddeaths
UNION ALL
SELECT 'covidvaccinations', COUNT(*) FROM covidvaccinations;

-- Date ranges
SELECT 'coviddeaths' AS table_name, MIN(date) AS min_date, MAX(date) AS max_date FROM coviddeaths
UNION ALL
SELECT 'covidvaccinations', MIN(date), MAX(date) FROM covidvaccinations;

-- Distinct geographies
SELECT COUNT(DISTINCT location) AS distinct_locations_deaths FROM coviddeaths;
SELECT COUNT(DISTINCT location) AS distinct_locations_vax FROM covidvaccinations;

-- Null checks for key fields (deaths)
SELECT
  SUM(date IS NULL) AS null_date,
  SUM(location IS NULL OR location = '') AS null_location,
  SUM(population IS NULL) AS null_population,
  SUM(total_cases IS NULL) AS null_total_cases,
  SUM(total_deaths IS NULL) AS null_total_deaths
FROM coviddeaths;

-- Null checks for key fields (vaccinations/testing)
SELECT
  SUM(date IS NULL) AS null_date,
  SUM(location IS NULL OR location = '') AS null_location,
  SUM(total_vaccinations IS NULL) AS null_total_vaccinations,
  SUM(people_vaccinated IS NULL) AS null_people_vaccinated,
  SUM(people_fully_vaccinated IS NULL) AS null_people_fully_vaccinated
FROM covidvaccinations;

-- Check for duplicate (location, date) rows (should be 0 ideally)
SELECT location, date, COUNT(*) AS cnt
FROM coviddeaths
GROUP BY location, date
HAVING COUNT(*) > 1
ORDER BY cnt DESC
LIMIT 50;

SELECT location, date, COUNT(*) AS cnt
FROM covidvaccinations
GROUP BY location, date
HAVING COUNT(*) > 1
ORDER BY cnt DESC
LIMIT 50;

-- Quick peek at column distributions
SELECT continent, COUNT(*) AS rows_per_continent
FROM coviddeaths
GROUP BY continent
ORDER BY rows_per_continent DESC;

-- Validate population consistency per location (should be mostly stable)
SELECT location,
       MIN(population) AS min_pop,
       MAX(population) AS max_pop
FROM coviddeaths
GROUP BY location
HAVING MIN(population) <> MAX(population)
ORDER BY (MAX(population) - MIN(population)) DESC
LIMIT 50;


