-- Trends in Startups
-- SELECT * 
-- FROM startups;

-- SELECT COUNT(*)
-- FROM startups;

--  total value of all companies in this table.
-- SELECT SUM(valuation)
-- FROM startups;

-- highest amount raised by a startup during 'Seed' stage
-- SELECT MAX(raised)
-- FROM startups
-- WHERE stage = 'Seed';

-- In what year was the oldest company on the list founded?
-- SELECT MIN(founded)
-- FROM startups;

-- Return the average valuation, in each category. Round the averages to two decimal places. Lastly, order the list from highest averages to lowest.
-- SELECT category, ROUND(AVG(valuation),2)
-- FROM startups
-- GROUP BY category
-- ORDER BY 2 DESC;

-- What are the most competitive markets?
-- SELECT category, COUNT(*) as 'count'
-- FROM startups
-- GROUP BY category
-- HAVING count > 3
-- ORDER BY 2 DESC;

-- Let's see if there's a difference in startups sizes among different locations:
SELECT location, AVG(employees) as 'avg_size'
FROM startups
GROUP BY location
HAVING avg_size > 500
ORDER BY 2 DESC;