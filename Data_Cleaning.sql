-- 1.date_added Column: Standardizing Date Format to MM/DD/YY

UPDATE netflix
SET date_added = TO_CHAR(TO_DATE(date_added, 'Month DD, YYYY'), 'MM/DD/YY')
WHERE date_added IS NOT NULL;

-- Verification Query:
SELECT date_added FROM netflix LIMIT 10;

-- 2.rating Column: Making 64 min, 74 min, 84 min NULL
UPDATE netflix
SET rating = NULL
WHERE rating IN ('66 min', '74 min', '84 min');

-- Verification Query
SELECT DISTINCT rating FROM netflix WHERE rating IN ('64 min', '74 min', '84 min');

-- 3.listed_in Column: Removing Commas at the End of Text
UPDATE netflix
SET listed_in = REGEXP_REPLACE(listed_in, ',$', '', 'g')
WHERE listed_in LIKE '%,';

-- Verification Query
SELECT listed_in FROM netflix WHERE listed_in LIKE '%,';

-- 4.description Column: Removing Special Characters
UPDATE netflix
SET description = REGEXP_REPLACE(description, '[√¨]', '', 'g')
WHERE description ~ '[√¨]';
UPDATE netflix
SET description = REGEXP_REPLACE(description, '[^a-zA-Z0-9\s]', '', 'g')
WHERE description ~ '[^a-zA-Z0-9\s]';

-- Verification Query
SELECT description FROM netflix WHERE description ~ '[^a-zA-Z0-9\s]';
SELECT description FROM netflix WHERE description ~ '[√¨]';

-- 5.country Column: Removing Leading Commas
UPDATE netflix
SET country = REGEXP_REPLACE(country, '^,+', '', 'g')
WHERE country LIKE ',%';

-- Verification Query
SELECT country FROM netflix WHERE country LIKE ',%';






