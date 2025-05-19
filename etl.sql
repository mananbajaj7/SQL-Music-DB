-- importing and extracting of data done on commandline 
-- .mode csv
-- .import "/Users/mananbajaj/Desktop/Projects/Tutorial Projects/Ex_Files_Advanced_SQL_Project/Exercise Files/Artists_Raw.csv" Artists
--.import "/Users/mananbajaj/Desktop/Projects/Tutorial Projects/Ex_Files_Advanced_SQL_Project/Exercise Files/Albums_Raw.csv" Albums
-- sqlite> .import "/Users/mananbajaj/Desktop/Projects/Tutorial Projects/Ex_Files_Advanced_SQL_Project/Exercise Files/Tracks_Raw.csv" Tracks
-- sqlite> .import "/Users/mananbajaj/Desktop/Projects/Tutorial Projects/Ex_Files_Advanced_SQL_Project/Exercise Files/Genres_Raw.csv" Genre

--Validate and Cleaning temporary tables
-- Ensure GenreID in Artists_Temp is valid
DELETE FROM Artists_Temp WHERE GenreID NOT IN (SELECT GenreID FROM Genres_Temp);

-- Ensure ArtistID in Albums_Temp is valid
DELETE FROM Albums_Temp WHERE ArtistID NOT IN (SELECT ArtistID FROM Artists_Temp);


-- Ensure albumID in Tracks_Temp_temp is valid
DELETE FROM Tracks_Temp WHERE AlbumID NOT IN (SELECT AlbumID FROM Albums_Temp);




-- Data Transform 
-- Artist TABLE
CREATE TABLE Artists_Cleaned AS SELECT *  FROM Artists_Temp;
DELETE FROM Artists_Cleaned WHERE Name IS NULL OR Name = '';
DELETE FROM Artists_Cleaned WHERE rowid NOT IN (SELECT  MIN (rowid) FROM Artists_Cleaned GROUP BY ArtistID);
UPDATE Artists_Cleaned SET Name = TRIM(Name);

-- Ensuring ArtistsID in Albums_Temp is valid
DELETE FROM Albums_Temp WHERE ArtistID NOT IN (SELECT ArtistID FROM Artists_Temp);

-- Albums TABLE
CREATE TABLE Albums_Cleaned AS SELECT *  FROM Albums_Temp;
DELETE FROM Albums_Cleaned WHERE Title IS NULL OR Title = '';
DELETE FROM Albums_Cleaned WHERE rowid NOT IN (SELECT  MIN (rowid) FROM Albums_Cleaned GROUP BY AlbumID);
UPDATE Albums_Cleaned SET Title = TRIM(Title);

-- Ensuring ArtistsID in Albums_Cleaned is valid
DELETE FROM Albums_Cleaned WHERE ArtistID NOT IN (SELECT ArtistID FROM Artists_Cleaned);



-- Tracks Table
CREATE TABLE Tracks_Cleaned AS SELECT *  FROM Tracks_Temp;
DELETE FROM Tracks_Cleaned WHERE Title IS NULL OR Title = '';
UPDATE Tracks_Cleaned SET Duration = Duration*60;-- assumin duration was minutes converted to seconds
DELETE FROM Tracks_Cleaned WHERE Duration <= 0; -- duration must be greater then 0 seconds


-- Ensure albumID in Tracks_Cleaned is valid
DELETE FROM Tracks_Cleaned WHERE AlbumID NOT IN (SELECT AlbumID FROM Albums_Cleaned);


--Genres TABLE
CREATE TABLE Genres_Cleaned AS SELECT *  FROM Genres_Temp;
DELETE FROM Genres_Cleaned WHERE Name IS NULL OR Name = '';


-- Load Data
-- helps with clean insert into our tables
PRAGMA foreign_keys = OFF;

INSERT INTO Genres (GenreID, Name)
SELECT GenreID, Name FROM Genres_Cleaned;

INSERT INTO Artists (ArtistID, Name, BirthDate, GenreID)
SELECT ArtistID, Name, BirthDate, GenreID FROM Artists_Cleaned;

INSERT INTO Albums (AlbumID, Title, ReleaseDate, ArtistID)
SELECT AlbumID, Title, ReleaseDate, ArtistID FROM Albums_Cleaned;

INSERT INTO Tracks (TrackID, Title, Duration, AlbumID)
SELECT TrackID, Title, Duration, AlbumID FROM Tracks_Cleaned
WHERE Duration >0;

PRAGMA foreign_keys = ON;


-- Clean Up
DROP TABLE IF EXISTS Artists_Temp;
DROP TABLE IF EXISTS Albums_Temp;
DROP TABLE IF EXISTS Tracks_Temp;
DROP TABLE IF EXISTS Genres_Temp;

DROP TABLE IF EXISTS Artists_Cleaned;
DROP TABLE IF EXISTS Albums_Cleaned;
DROP TABLE IF EXISTS Tracks_Cleaned;
DROP TABLE IF EXISTS Genres_Cleaned;
