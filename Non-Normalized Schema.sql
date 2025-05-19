-- Non-Normalized Schema
Create ARTIST TABLE:

DROP TABLE IF EXISTS Artists;
CREATE TABLE Artists(
	ArtistID INTEGER PRIMARY KEY,
	Name TEXT NOT NULL,
	BirthDate DATE,
	GENRE TEXT --Redunant data 
	);
	
	
	--Create ALBUM TABLE:
DROP TABLE IF EXISTS Albums;
CREATE TABLE Albums(
	AlbumID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	ReleaseDate DATE,
	ArtistID INTEGER,
	Genre TEXT, --Redunnt data 
	FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
	);
	
	
	--Create Tracks TABLE:
DROP TABLE IF EXISTS Tracks;
CREATE TABLE Tracks(
	TrackID INTEGER PRIMARY KEY,
	Title  TEXT NOT NULL,
	Duration INTEGER,
	AlbumID INTEGER,
	ArtistGenre TEXT, --Transient dependency
	FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
	);
	
	
	
	--Create Genre TABLE:
DROP TABLE IF EXISTS Genres;
CREATE TABLE Genres(
	GenreID INTEGER PRIMARY KEY,
	Name TEXT NOT NULL
	);
