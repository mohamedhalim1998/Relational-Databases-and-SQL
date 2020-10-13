/* ,  , Add the reviewer Roger Ebert to your database, with an rID of 209.
*/
INSERT INTO Reviewer VALUES(209 , "Roger Ebert")
/*
For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)
*/
UPDATE  Movie 
SET year = year + 25
WHERE Movie.mID in 
 (SELECT Movie.mID  FROM Movie , Rating
 WHERE Movie.mID = Rating.mID
 GROUP BY Movie.mID
 HAVING avg(stars) >= 4)

/*
For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)
*/


DELETE FROM  Rating
WHERE stars < 4 and mID in (SELECT mID FROM MOVIE WHERE Movie.year < 1970 OR Movie.year > 2000)
