-- DATA VALIDATION 

--1. Validating Album ReleaseDate
SELECT * FROM Albums WHERE ReleaseDate >DATE("now");


-- Add New Column
ALTER TABLE Albums ADD COLUMN ReleaseDateFormatted DATE;

-- Update the New Column
UPDATE Albums SET ReleaseDateFormatted =
CASE
    -- Handle dates with two-digit year (00–99)
    WHEN LENGTH(SUBSTR(ReleaseDate, -2)) = 2 THEN
        CASE
            -- Convert years 00–23 to 2000–2023
            WHEN CAST(SUBSTR(ReleaseDate, -2) AS INTEGER) < 24 THEN
                '20' || SUBSTR(ReleaseDate, -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(ReleaseDate, 1, INSTR(ReleaseDate, '/') - 1), '/', ''), -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(ReleaseDate, INSTR(ReleaseDate, '/') + 1, INSTR(SUBSTR(ReleaseDate, INSTR(ReleaseDate, '/') + 1), '/') - 1), '/', ''), -2)
            -- Convert years 24–99 to 1924–1999
            ELSE
                '19' || SUBSTR(ReleaseDate, -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(ReleaseDate, 1, INSTR(ReleaseDate, '/') - 1), '/', ''), -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(ReleaseDate, INSTR(ReleaseDate, '/') + 1, INSTR(SUBSTR(ReleaseDate, INSTR(ReleaseDate, '/') + 1), '/') - 1), '/', ''), -2)
        END
    ELSE
        NULL
END
WHERE ReleaseDate IS NOT NULL;

-- update null dates to a default value
UPDATE Albums SET ReleaseDateFormatted  = "1999-2-31" WHERE ReleaseDateFormatted IS NULL;

--Verify updated dates
SELECT ReleaseDate, ReleaseDateFormatted FROM Albums WHERE ReleaseDateFormatted IS NULL;
	
--Manually fixing date errors remaining
UPDATE Albums SET ReleaseDateFormatted = 'YYYY-MM-DD' WHERE ReleaseDate = 'MM/DD/YYYY';


-- Create a new version of the Albums table
CREATE TABLE Albums_New (
    AlbumID INTEGER PRIMARY KEY, -- Primary key constraint
    Title TEXT NOT NULL,         -- Column-level NOT NULL constraint
    ReleaseDate DATE,            -- No specific constraint needed
    ArtistID INTEGER,            -- Foreign key column
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID), -- Foreign key constraint
    CHECK (Title IS NOT NULL)    -- Table-level CHECK constraint to ensure Title is not NULL (somewhat redundant)
);

-- Copy data into the new table (use the cleaned ReleaseDateFormatted)
INSERT INTO Albums_New (AlbumID, Title, ArtistID, ReleaseDate)
SELECT DISTINCT AlbumID, Title, ArtistID, ReleaseDateFormatted
FROM Albums;

-- Temporarily disable foreign key checks to allow table replacement
PRAGMA foreign_keys = OFF;
DROP TABLE Albums;
PRAGMA foreign_keys = ON;

-- Rename the new table to the original name
ALTER TABLE Albums_New RENAME TO Albums;

-- Create index on Albums title
CREATE INDEX idx_album_title ON Albums(Title);

-- Run the verification query again
SELECT * FROM Albums WHERE ReleaseDate > DATE('now');

-- update null dates to a default value
UPDATE Albums SET ReleaseDate  = "9999-2-31" WHERE ReleaseDate =  "1999-2-31";

-- 2. Validating foreign key references
SELECT * 
FROM Albums 
WHERE ArtistID NOT IN (SELECT ArtistID FROM Artists);

-- 1. Validating Artist BirthDate
SELECT * FROM Artists WHERE BirthDate > DATE('now');

-- Add New Column
ALTER TABLE Artists ADD COLUMN BirthDateFormatted DATE;

-- Update the New Column
UPDATE Artists SET BirthDateFormatted =
CASE
    -- Handle dates with two-digit year (00–99)
    WHEN LENGTH(SUBSTR(BirthDate, -2)) = 2 THEN
        CASE
            -- Convert years 00–23 to 2000–2023
            WHEN CAST(SUBSTR(BirthDate, -2) AS INTEGER) < 24 THEN
                '20' || SUBSTR(BirthDate, -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(BirthDate, 1, INSTR(BirthDate, '/') - 1), '/', ''), -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(BirthDate, INSTR(BirthDate, '/') + 1, INSTR(SUBSTR(BirthDate, INSTR(BirthDate, '/') + 1), '/') - 1), '/', ''), -2)
            -- Convert years 24–99 to 1924–1999
            ELSE
                '19' || SUBSTR(BirthDate, -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(BirthDate, 1, INSTR(BirthDate, '/') - 1), '/', ''), -2) || '-' ||
                SUBSTR('0' || REPLACE(SUBSTR(BirthDate, INSTR(BirthDate, '/') + 1, INSTR(SUBSTR(BirthDate, INSTR(BirthDate, '/') + 1), '/') - 1), '/', ''), -2)
        END
    ELSE
        NULL
END
WHERE BirthDate IS NOT NULL;

-- Update null dates to a default value
UPDATE Artists SET BirthDateFormatted = '9999-12-31' WHERE BirthDateFormatted IS NULL;

-- Verify updated dates
SELECT BirthDate, BirthDateFormatted FROM Artists WHERE BirthDateFormatted IS NULL;

-- Manually fixing date errors remaining
UPDATE Artists SET BirthDateFormatted = 'YYYY-MM-DD' WHERE BirthDate = 'MM/DD/YYYY';

-- Create a new version of the Artists table
CREATE TABLE Artists_New (
    ArtistID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    BirthDate DATE,
    GenreID INTEGER,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    CHECK (Name IS NOT NULL)
);

INSERT INTO Artists_New (ArtistID, Name, GenreID, BirthDate)
SELECT DISTINCT ArtistID, Name, GenreID, BirthDateFormatted
FROM Artists
WHERE GenreID IN (SELECT GenreID FROM Genres)
   OR GenreID IS NULL;


-- Temporarily disable foreign key checks to allow table replacement
PRAGMA foreign_keys = OFF;
DROP TABLE Artists;
PRAGMA foreign_keys = ON;

-- Rename the new table to the original name
ALTER TABLE Artists_New RENAME TO Artists;

-- Create index on Artist Name
CREATE INDEX idx_artist_name ON Artists(Name);

-- Run the verification query again
SELECT * FROM Artists WHERE BirthDate > DATE('now');
