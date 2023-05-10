-- The Rotten Tomatoes scores for Civil War (90%),
-- Ant Man 3 (47%), Zack Snyder's Cut (71%), and The
-- Suicide Squad (90%) are missing from the API and
-- instead the MetaCritic score was retrieved. I
-- collected the scores manually in May 2023 from
-- https://www.rottentomatoes.com/.

-- Civil War RT Rating
UPDATE mcu 
SET "Rotten Tomatoes Rating" = '90%'
WHERE Title = 'Captain America: Civil War';

-- Ant Man 3 RT Rating
UPDATE mcu
SET "Rotten Tomatoes Rating" = '47%'
WHERE Title = 'Ant-Man and the Wasp: Quantumania';

-- Zack Snyder's Cut RT Rating
-- The single quote string delimiter conflicts with the
-- apostrophe in "Zack Snyder's", so an extra single
-- quote is used to escape the apostrophe acting as the
-- delimiter (this is the case for pgAdmin4).
UPDATE dceu
SET "Rotten Tomatoes Rating" = '71%'
WHERE Title = 'Zack Snyder''s Justice League';

-- The Suicide Squad RT Rating
UPDATE dceu
SET "Rotten Tomatoes Rating" = '90%'
WHERE Title = 'The Suicide Squad';

-- Zack Snyder's was released directly to HBO Max.
-- change the Box Office value from 'N/A' to '0'.
UPDATE dceu
SET "Box Office" = '0'
WHERE Title = 'Zack Snyder''s Justice League';

-- Add a 'Franchise' column to each table to identify
-- each movie's franchise.
ALTER TABLE mcu
ADD COLUMN Franchise VARCHAR(4);

UPDATE mcu
SET Franchise = 'MCU';

ALTER TABLE dceu
ADD COLUMN Franchise VARCHAR(4);

UPDATE dceu
SET Franchise = 'DCEU';

-- Combine the two tables into a new combined table.
-- First create a new "Movies" table
CREATE TABLE Movies(
    "Title" VARCHAR NOT NULL,
    "Year" VARCHAR NOT NULL,
    "Runtime" VARCHAR NOT NULL,
    "Rotten Tomatoes Rating" VARCHAR NOT NULL,
    "Box Office" VARCHAR NOT NULL,
    "Franchise" VARCHAR NOT NULL
);

-- Add the row from both tables into the newly created 
-- table
INSERT INTO Movies
SELECT *
FROM mcu
UNION ALL
SELECT *
FROM dceu;

-- Year
-- Change 'Year' from VARCHAR to YEAR
ALTER TABLE Movies
ALTER COLUMN "Year" TYPE DATE
USING to_date("Year", 'YYYY');

-- Runtime
-- Remove " min" from each value
-- Change Runtime from VARCHAR to INT
-- Add unit of measure to column header
UPDATE Movies 
SET "Runtime" = REPLACE("Runtime", ' min', '');

ALTER TABLE Movies
ALTER COLUMN "Runtime" TYPE INT
USING "Runtime"::integer;

ALTER TABLE Movies
RENAME COLUMN "Runtime" TO "Runtime (min)";

-- Rotten Tomatoes Rating
-- Remove % sign from each value for data type conversion
-- Change "Rotten Tomatoes Rating" from VARCHAR to INT
-- Add % sign to column header

UPDATE Movies
SET "Rotten Tomatoes Rating" = REPLACE("Rotten Tomatoes Rating", '%', '');

ALTER TABLE Movies
ALTER COLUMN "Rotten Tomatoes Rating" TYPE INT
USING "Rotten Tomatoes Rating"::integer;

ALTER TABLE Movies
RENAME COLUMN "Rotten Tomatoes Rating" to "Rotten Tomatoes Rating (%)";

-- Box Office
-- Remove $ sign and commas for data type conversion
-- Change "Box Office" from VARCHAR to INT
-- Add $ sign to column header
UPDATE Movies
SET "Box Office" = REPLACE(REPLACE("Box Office", '$', ''), ',', '');

ALTER TABLE Movies
ALTER COLUMN "Box Office" TYPE INT
USING "Box Office"::integer;

ALTER TABLE Movies
RENAME COLUMN "Box Office" to "Box Office ($)";

-- View the cleaned final product table.
SELECT *
FROM Movies
ORDER BY "Title" ASC;