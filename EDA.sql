-- Data Analysis Queries

-- selecting all Artists
 SELECT * FROM Artists
 
 -- specific columns
 SELECT Name, GenreID
FROM	Artists;

-- FILTERING DATABASE
SELECT * FROM Artists WHERE GenreID=2;

-- sorting results
SELECT * FROM Artists ORDER BY Name ASC;

/* Aggregating Results */
-- number of Artists
SELECT COUNT(*) FROM Artists;

-- GROUPING DATA
SELECT GenreID, COUNT(*)FROM Artists GROUP BY GenreID;

-- FILTERING GROUPED DATA
SELECT GenreID, COUNT(*) FROM Artists GROUP BY GenreID HAVING COUNT (*) >5;

/* Joining Tables */

SELECT Artists.Name, Albums.Title
FROM Artists
INNER JOIN Albums 
ON Artists.ArtistID = Albums.ArtistID;

-- LEFT JOIN
SELECT Artists.Name, Albums.Title
FROM Artists
LEFT JOIN Albums 
ON Artists.ArtistID = Albums.ArtistID;

SELECT * FROM  Tracks t
LEFT JOIN Albums a on t.AlbumID=a.AlbumID;

/* Data Analysis */

-- finding top artists by number of Albums

SELECT Artists.Name, COUNT(Albums.AlbumID) AS AlbumCount
FROM Artists 
INNER JOIN Albums
ON Artists.ArtistID = Albums.ArtistID
GROUP BY Artists.Name
ORDER BY AlbumCount DESC ;

--Identifying popular Genres
Select Genres.Name,
COUNT (*) AS ArtistCount
FROM Artists 
INNER JOIN Genres ON Artists.GenreID = Genres.GenreID
GROUP BY Artists.GenreID
ORDER BY ArtistCount DESC ;

-- Most Played tracks

SELECT Tracks.Title, SUM(Duration) as TotalPlays
FROM Tracks
GROUP BY Tracks.Title
ORDER BY TotalPlays DESC;
