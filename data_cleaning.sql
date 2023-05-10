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