-- 00_setup_notes.sql
-- Notes on the setup and data normalization steps performed before analysis

-- 1) Confirm date ranges
SELECT MIN('date') AS min_date, MAX('date') AS max_date FROM coviddeaths;
SELECT MIN('date') AS min_date, MAX('date') AS max_date FROM covidvaccinations;

-- 2) Date normalization example (if date was stored as M/D/YY text originally)
-- UPDATE coviddeaths
-- SET 'date' = DATE_FORMAT(STR_TO_DATE('date', '%m/%d/%y'), '%Y-%m-%d')
-- WHERE 'date' IS NOT NULL AND 'date' <> '';
-- ALTER TABLE coviddeaths MODIFY 'date' DATE NULL;

-- UPDATE covidvaccinations
-- SET 'date' = DATE_FORMAT(STR_TO_DATE('date', '%m/%d/%y'), '%Y-%m-%d')
-- WHERE 'date' IS NOT NULL AND 'date' <> '';
-- ALTER TABLE covidvaccinations MODIFY 'date' DATE NULL;

-- 3) Confirm schema
DESCRIBE coviddeaths;
DESCRIBE covidvaccinations;

