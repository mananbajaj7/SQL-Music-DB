--Refined Normalized Schema

--Step 1: Create a New Artists table without the Genre Column
CREATE TABLE Artists_New(
	ArtistID INTEGER PRIMARY KEY,
	Name TEXT NOT NULL,
	BirthDate DATE NOT NULL,
	GenreID INTEGER,
	FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
	);
	
-- Step 2: Drop original table
DROP TABLE  Artists;
	
-- Step 3 Rename table
ALTER TABLE Artists_New RENAME TO Artists;


-- Step 1 Create new ALBUM TABLE:
CREATE TABLE Albums_New(
	AlbumID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	ReleaseDate DATE,
	ArtistID INTEGER,
	FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),
	CHECK (Title IS NOT NULL)
	);
	
-- Step 2: Drop original table
DROP TABLE  Albums;
	
-- Step 3 Rename table
ALTER TABLE Albums_New RENAME TO Albums;



--Step 1: Create new Tracks TABLE

CREATE TABLE Tracks_New(
	TrackID INTEGER PRIMARY KEY,
	Title  TEXT NOT NULL,
	Duration INTEGER CHECK (Duration > 0),
	AlbumID INTEGER,
	FOREIGN KEY (AlbumID) REFERENCES Albums (AlbumID),
	CHECK (Title IS NOT NULL)
	);
	
-- Step 2: Drop original table
DROP TABLE  Tracks;
	
-- Step 3 Rename table
ALTER TABLE Tracks_New RENAME TO Tracks;




-- Create Indexes 
CREATE INDEX idx_artist_name ON Artists(Name);
CREATE INDEX idx_album_title ON Albums(Title);
CREATE INDEX idx_track_title ON Tracks(Title);
CREATE INDEX idx_genre_name ON Genres(Name);
