/* Showing all data */
SELECT * FROM athletedb.athletes;

/* The total number of competitions all athletes in the database have participated in. */

SELECT COUNT(DISTINCT ID) AS Total_Competitions
FROM athletedb.athletes;


/*Ranking the number of medal-winning athletes in all sports. */

SELECT Sport,COUNT(DISTINCT Name) AS Medalists_Count
FROM athletedb.athletes
WHERE Medal IS NOT NULL
GROUP BY Sport
ORDER BY Medalists_Count DESC;


/* A table for which countries have gold medals in how many different sports. */

SELECT Team, COUNT(DISTINCT Sport) AS Gold_Medal_Sports_Count
FROM athletedb.athletes
WHERE Medal = "Gold"
GROUP BY Team
ORDER BY Gold_Medal_Sports_Count DESC;


/* A table for the countries that won at least one medal 
in the 2002 Winter Olympics along with their total number of medals won.
 */
 
SELECT Team, COUNT(*) AS Medal_Count
FROM athletedb.athletes
WHERE Year = 2002 AND Season = "Winter" AND Medal IS NOT NULL
GROUP BY Team
ORDER BY Medal_Count DESC;


/* Sports which had at least one female athlete compete. */

SELECT Sport, COUNT(DISTINCT Name) AS Female_Participants
FROM athletedb.athletes
WHERE Sex = 'F'
GROUP BY Sport
ORDER BY Female_Participants DESC;


/* A table for the names of the female athletes who won medals in athletics in the year 2000, 
their teams, the name of the Olympic Games, and the type of medal they received. 
*/

SELECT Name, Team, Games, Medal
FROM athletedb.athletes
WHERE Year = 2000 AND Sport = "Athletics" AND Medal IS NOT NULL AND Sex = "F";


/* The number of gold medals won by the United States in the 1984 Summer Olympics. */ 

SELECT COUNT(*)
FROM athletedb.athletes
WHERE Year = 1984 AND Season = "Summer" AND Team = "United States" AND Medal = "Gold";


/* The list of the top 10 countries with the most gold medals won. */

SELECT Team, COUNT(*) AS Gold_Medal_Count
FROM athletedb.athletes
WHERE Medal = "Gold"
GROUP BY Team
ORDER BY Gold_Medal_Count DESC
LIMIT 10;


/* A table the names of athletes who won medals, 
their teams, and the type of medal they received in the 1988 Summer Olympics. 
Athletes with the same name should only appear once on the table.  */

SELECT Name, COUNT(Medal) AS Total_Medals, 
       COUNT(CASE WHEN Medal = "Gold" THEN 1 END) AS "Gold", 
       COUNT(CASE WHEN Medal = "Silver" THEN 1 END) AS "Silver", 
       COUNT(CASE WHEN Medal = "Bronze" THEN 1 END) AS "Bronze"
FROM athletedb.athletes
WHERE Medal IS NOT null
GROUP BY Name
ORDER BY Total_Medals DESC;


/* Which athlete has the most gold medals? */

SELECT Name
FROM athletedb.athletes
WHERE Medal = "Gold"
GROUP BY Name
ORDER BY COUNT(*) DESC
LIMIT 1;


/* The list of athletes who have won at least 2 gold medals. */

SELECT Name, COUNT(*) AS Gold_Medals
FROM athletedb.athletes
WHERE Medal = "Gold"
GROUP BY Name
HAVING COUNT(*) >= 2
ORDER BY Gold_Medals DESC;


/* The top 10 sports with the highest average height. */

SELECT Sport
FROM athletedb.athletes
GROUP BY Sport
ORDER BY AVG(Height) DESC
LIMIT 10;


/* The oldest male athletes.*/

SELECT Name, Age, Height
FROM athletedb.athletes
WHERE Sex = "M" AND Age = (SELECT MAX(Age) FROM athletedb.athletes WHERE Sex = "M")
ORDER BY Height DESC;



/*A list for the most popular sports (with the highest number of total athletes). */

SELECT Sport, COUNT(*) AS Participant_Count
FROM athletedb.athletes
GROUP BY Sport
ORDER BY Participant_Count DESC;



/* The total number of medals won by each of the top medal-winning countries for each type of medal. */

SELECT NOC, Medal, COUNT(*) AS Medal_Count
FROM athletedb.athletes
WHERE Medal IS NOT null
GROUP BY NOC, Medal
ORDER BY Medal_Count DESC;


/* For Athletics, Basketball, and Football disciplines, 
a list for the athletes who have won the most medals in each Olympic games. */

SELECT Name, COUNT(*) AS Medal_Count
FROM athletedb.athletes
WHERE Sport IN ('Athletics', 'Basketball', 'Football') AND Medal IS NOT null
GROUP BY Name
ORDER BY Medal_Count DESC
LIMIT 10;


/* The calculation the average age, minimum age, maximum age
and standard deviation of all athletes in the database. */

SELECT 
  AVG(Age) AS Average_Age,
  MIN(Age) AS Minimum_Age,
  MAX(Age) AS Maximum_Age,
  ROUND(ABS(AVG(Age*Age) - AVG(Age)*AVG(Age)), 2) AS Standard_Deviation
FROM athletedb.athletes;


/* A query that finds the most frequently repeated names in the database 
and displays how many times they are repeated. */

SELECT Name, COUNT(*) AS frequency
FROM athletedb.athletes
GROUP BY Name
HAVING frequency > 1
ORDER BY frequency DESC;


/* Olympic career of Naim Suleymanoglu */

SELECT Name, YEAR,
       COUNT(CASE WHEN Medal = "Gold" THEN 1 END) AS "Gold", 
       COUNT(CASE WHEN Medal = "Silver" THEN 1 END) AS "Silver", 
       COUNT(CASE WHEN Medal = "Bronze" THEN 1 END) AS "Bronze"
FROM athletedb.athletes
WHERE Name="Naim Sleymanolu"
GROUP BY Name,Year;


/*The sport in which each country is most successful in the Olympics.*/

SELECT Team, Sport, MAX(Total_Medals) AS Max_Medals
FROM (
  SELECT athletes.Team AS Team, athletes.Sport, COUNT(*) AS Total_Medals
  FROM athletedb.athletes
  WHERE Medal IS NOT NULL
  GROUP BY athletes.Team, athletes.Sport
) AS T
GROUP BY T.Team, T.Sport
ORDER BY Max_Medals DESC;


/* The age ranges of all sports */

SELECT 
	Sport, 
	MIN(Age) AS Min_Age, 
	MAX(Age) AS Max_Age, 
    MAX(Age)-MIN(Age) as Age_Range
FROM athletedb.athletes
GROUP BY Sport
ORDER BY Age_Range DESC;

