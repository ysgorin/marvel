-- Create the Superhero Movie Table Schema
CREATE TABLE Movies (
    "Film ID" INT,
    Title VARCHAR NOT NULL,
    Year INT NOT NULL,
    "Runtime (min)" INT NOT NULL,
    "Rotten Tomatoes Rating (%)" INT NOT NULL,
    "Box Office ($)" INT NOT NULL,
    Franchise VARCHAR(4),
    PRIMARY KEY ("Film ID")
);