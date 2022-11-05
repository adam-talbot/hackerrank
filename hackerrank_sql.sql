/* We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers. */

select months * salary as earnings, count(*)
from Employee
group by earnings
order by earnings desc
limit 1;

/* Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places. */

select round(sum(lat_n), 2), round(sum(long_w), 2)
from STATION;

-- Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . Truncate your answer to  decimal places.

select truncate(sum(lat_n), 4)
from STATION
where lat_n between 38.7880 and 137.2345;

-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
-- Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

select(ceil((avg(Salary)) - (avg(replace(Salary, "0", "")))))
from employees;

-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to  decimal places.
select truncate(max(lat_n), 4)
from station
where lat_n < 137.2345;

-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.
select round(long_w, 4)
from station
where lat_n < 137.2345
order by lat_n desc
limit 1;

-- Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.
select round(lat_n, 4)
from station
where lat_n > 38.7780
order by lat_n
limit 1;

-- (Medium) Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation.
-- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
-- Note: Print NULL when there are no more names corresponding to an occupation.)

-- with if
select -- have to use max even though there will only be one value per row since group by expects aggregation
    max(if(occupation = 'Doctor', name, null)) as Doctor,
    max(if(occupation = 'Professor', name, null)) as Professor,
    max(if(occupation = 'Singer', name, null)) as Singer,
    max(if(occupation = 'Actor', name, null)) as Actor
from
    (select 
     occupation, name, ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY name) AS rn
     from occupations) as t1 -- need to partition by occupation first and get row number after alphebetizing
group by rn; -- when you group by row number you get value for that row, if present

-- with case statement
select 
    max(case when occupation = 'Doctor' then name else null end) as Doctor,
    max(case when occupation = 'Professor' then name else null end) as Professor,
    max(case when occupation = 'Singer' then name else null end) as Singer,
    max(case when occupation = 'Actor' then name else null end) as Actor
from
    (select 
     occupation, name, ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY name) AS rn
     from occupations) as t1
group by rn;

-- did some more station problems similar to those above

-- Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key

select sum(city.population)
from city
join country on city.countrycode = country.code
where continent = 'Asia';

-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select city.name
from city
join country on city.countrycode = country.code
where continent = 'Africa';

-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

select continent, floor(avg(city.population))
from city
join country on city.countrycode = country.code
group by continent;

-- Draw the Triangle 1
-- P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

-- * * * * * 
-- * * * * 
-- * * * 
-- * * 
-- *

-- Write a query to print the pattern P(20).

-- declare the number of lines as a variable
SET @no_of_lines := 21; 
-- use select statment to loop until 0
SELECT REPEAT('* ', @no_of_lines := @no_of_lines - 1) 
-- The INFORMATION_SCHEMA.TABLES view allows you to get information about all tables and views within a database. The actual values of INFORMATION_SCHEMA.TABLES is not required but we need a from statement to run the sql query.
FROM INFORMATION_SCHEMA.TABLES;

-- Draw the Triangle 2
-- P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

-- * 
-- * * 
-- * * * 
-- * * * * 
-- * * * * *

-- Write a query to print the pattern P(20).

SET @x:=0; 
SELECT REPEAT('* ', @x:= @x + 1) 
FROM INFORMATION_SCHEMA.TABLES
WHERE @x < 20;

-- Weather Observation Station 18
-- Consider  and  to be two points on a 2D plane.
--  happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
--  happens to equal the minimum value in Western Longitude (LONG_W in STATION).
--  happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
--  happens to equal the maximum value in Western Longitude (LONG_W in STATION).
-- Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.

-- |x1 - x2| + |y1 - y2|
select round((abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w))), 4)
from station;

-- Weather Observation Station 19
-- Consider  and  to be two points on a 2D plane where  are the respective minimum and maximum values of Northern Latitude (LAT_N) and  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
-- Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.

select round(SQRT((power(min(lat_n) - max(lat_n), 2) + power(min(long_w) - max(long_w), 2))), 4)
from station;

-- The Report
-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
-- The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, 
-- order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
-- If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order. Write a query to help Eve.
SELECT 
    CASE WHEN g.grade > 7 THEN s.name ELSE NULL end AS name,
    g.grade,
    s.marks
FROM students as s
JOIN grades as g
ON s.marks BETWEEN g.min_mark AND g.max_mark -- joins the corresponding row when marks is between these values
ORDER BY g.grade DESC,
    name ASC,
    s.marks ASC;

-- need to do more research about how this join is happening with the between in the join condition
-- will only join the record if the S.mark is between the G.min_mark and G.max_mark

SELECT IF(GRADES.GRADE>=8, STUDENTS.NAME, NULL),GRADES.GRADE, STUDENTS.MARKS
FROM GRADES, STUDENTS
WHERE STUDENTS.MARKS BETWEEN GRADES.MIN_MARK AND GRADES.MAX_MARK
ORDER BY GRADES.GRADE DESC, STUDENTS.NAME;

-- join using where clause, research pros and cons to this syntax

-- Top Competitors
-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers 
-- who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
-- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

select hacker_id, name from
(select s.hacker_id, h.name, count(s.hacker_id) as count
from submissions as s
join challenges as c using(challenge_id) -- to get difficulty level
join difficulty as d on c.difficulty_level = d.difficulty_level and d.score = s.score-- to get max score and filter for full marks
join hackers as h on s.hacker_id = h.hacker_id -- to get name
group by s.hacker_id, h.name
having count > 1
order by count desc, s.hacker_id) as t1;

-- could also potentially use case statement to get full marks column and filter on that instead of using and condition in join statement but gets more complicated since select is performed after where