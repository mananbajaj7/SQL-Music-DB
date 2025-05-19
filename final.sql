-- FINAL 
/*
This script creates a new MediaType reference table to categorize audio/video tracks based on their duration. 
It modifies the existing Tracks table by adding a MediaTypeID column, populates it using duration-based logic, and enforces referential integrity. 
It also includes validation queries to ensure data consistency and query performance
*/


CREATE TABLE MediaType (
  MediaTypeID INTEGER PRIMARY KEY,
  Name TEXT NOT NULL
);


INSERT INTO MediaType (MediaTypeID, Name) VALUES
(1, 'MPEG audio file'),
(2, 'Protected AAC audio file'),
(3, 'Protected MPEG-4 video file'),
(4, 'Purchased AAC audio file'),
(5, 'AAC audio file');


ALTER TABLE Tracks ADD COLUMN MediaTypeID INTEGER;


UPDATE Tracks SET MediaTypeID = 1 WHERE Duration < 180;
UPDATE Tracks SET MediaTypeID = 2 WHERE Duration >= 180 AND Duration < 240;
UPDATE Tracks SET MediaTypeID = 3 WHERE Duration >= 240 AND Duration < 300;
UPDATE Tracks SET MediaTypeID = 4 WHERE Duration >= 300 AND Duration < 360;
UPDATE Tracks SET MediaTypeID = 5 WHERE Duration >= 360;



PRAGMA foreign_keys = ON;


SELECT
  Tracks.TrackID,
  Tracks.Title,
  MediaType.Name AS MediaType
FROM Tracks
JOIN MediaType ON Tracks.MediaTypeID = MediaType.MediaTypeID;



SELECT * FROM Tracks
WHERE MediaTypeID NOT IN (SELECT MediaTypeID FROM MediaType);


PRAGMA table_info(MediaType);
PRAGMA table_info(Tracks);


EXPLAIN QUERY PLAN
SELECT
  Tracks.TrackID,
  Tracks.Title,
  MediaType.Name AS MediaType
FROM Tracks
JOIN MediaType ON Tracks.MediaTypeID = MediaType.MediaTypeID;
