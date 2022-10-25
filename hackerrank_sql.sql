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