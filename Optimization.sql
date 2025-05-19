-- Optimizing Queries 

-- Explain QUERY
EXPLAIN QUERY PLAN SELECT * FROM Tracks WHERE Duration >1000;


-- CREATE an INDEX 
CREATE INDEX idx_duration ON Tracks (Duration);


-- Observing Performance 
EXPLAIN QUERY PLAN SELECT * FROM Tracks WHERE Duration >1000;

-- Otimization techniques

-- PARTITIONING BY YEAR
CREATE TABLE Artists_1986 AS SELECT * FROM Artists WHERE strftime('%Y', BirthDate) = '1986';
CREATE TABLE Artists_1987 AS SELECT * FROM Artists WHERE strftime('%Y', BirthDate) = '1987';


-- Creating Views
-- Creating view to simplify access
CREATE VIEW All_Artists AS
SELECT * FROM Artists_1986
UNION ALL
SELECT * FROM Artists_1987;

-- Check the View's records
SELECT * FROM All_Artists;


-- Creating a view
CREATE VIEW Popular_Artists AS
SELECT Name, COUNT(Albums.AlbumID) AS AlbumCount
FROM Artists
INNER JOIN Albums ON Artists.ArtistID = Albums.ArtistID
GROUP BY Artists.Name;

-- Using the view
SELECT * FROM Popular_Artists;


-- Batch Processing and Parallel Execution

/* Batch Processing and Parallel Execution */

-- Batch processing example
UPDATE Tracks SET Duration = Duration + 1 WHERE TrackID BETWEEN 1 AND 30;
UPDATE Tracks SET Duration = Duration + 1 WHERE TrackID BETWEEN 31 AND 60;

-- Simulating parallel execution (typically handled by application logic)
PRAGMA synchronous = OFF;  -- Example to speed up insertions
