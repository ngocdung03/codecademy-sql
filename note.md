##### 1.SQL Manipulation
- SQL (pronounced “S-Q-L” or “sequel”) allows you to write queries which define the subset of data you are seeking. 
- multi-step process where some users leave at each step is called a funnel.
- A churn rate is the percent of subscribers to a monthly service who have canceled. 
    - [example of churn rate.jpg]
- Tables are sometimes referred to as relations
- A statement is text that the database recognizes as a valid command, always end in a semicolon ;.
    - CREATE TABLE is a clause. Clauses perform specific tasks in SQL. By convention, clauses are written in capital letters. Clauses can also be referred to as commands.
    - table_name refers to the name of the table that the command is applied to.
    - (column_1 data_type, column_2 data_type, column_3 data_type) is a parameter. A parameter is a list of columns, data types, or values that are passed to a clause as an argument. Here, the parameter is a list of column names and the associated data type.
```sql
CREATE TABLE table_name (
   column_1 data_type, 
   column_2 data_type, 
   column_3 data_type
);
```
- Insert:
```sql
INSERT INTO celebs (id, name, age) 
VALUES (1, 'Justin Bieber', 22);
```
- Select statements always return a new table called the result set.
```sql
SELECT name FROM celebs; #can be *
```
- ALTER TABLE statement adds a new column to a table
```sql
ALTER TABLE celebs 
ADD COLUMN twitter_handle TEXT;
```
- The UPDATE statement edits a row in a table
```sql
UPDATE celebs 
SET twitter_handle = '@taylorswift13' 
WHERE id = 4; 
```
- The DELETE FROM statement deletes one or more rows from a table.
```sql
DELETE FROM celebs 
WHERE twitter_handle IS NULL;
```
- Constraints that add information about how a column can be used are invoked after specifying the data type for a column. They can be used to tell the database to reject inserted data that does not adhere to a certain restriction. 
    - 1. PRIMARY KEY columns can be used to uniquely identify the row. Attempts to insert a row with an identical value to a row already in the table will result in a constraint violation which will not allow you to insert the new row.
    - 2. UNIQUE columns have a different value for every row. This is similar to PRIMARY KEY except a table can have many different UNIQUE columns.
    - 3. NOT NULL columns must have a value. Attempts to insert a row without a value for a NOT NULL column will result in a constraint violation and the new row will not be inserted.
    - 4. DEFAULT columns take an additional argument that will be the assumed value for an inserted row if the new row does not specify a value for that column.
```sql
CREATE TABLE celebs (
   id INTEGER PRIMARY KEY, 
   name TEXT UNIQUE,
   date_of_birth TEXT NOT NULL,
   date_of_death TEXT DEFAULT 'Not Applicable'
);
```
- Create index
    - Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). So, only create indexes on columns that will be frequently searched against.
```sql
CREATE INDEX customers_by_phone
ON customers (phone_number)
```

##### 2.Queries
- AS is a keyword in SQL that allows you to rename a column or table using an alias
```sql
SELECT name AS 'Titles'
FROM movies;
```
- DISTINCT is used to return unique values in the output. 
```sql
SELECT DISTINCT tools 
FROM inventory;
```
- restrict our query results using the WHERE clause in order to obtain only the information we want.
```sql
SELECT *
FROM movies
WHERE imdb_rating > 8;
```
- LIKE can be a useful operator when you want to compare similar values. LIKE is not case sensitive.'_' - individual character, '%' - zero or more. 
```sql
-- select all movies that start with ‘Se’ and end with ‘en’ and have exactly one character in the middle
SELECT * 
FROM movies
WHERE name LIKE 'Se_en';

-- Filters the result set to only include movies with names that begin with the letter ‘A’
SELECT * 
FROM movies
WHERE name LIKE 'A%';
```
- IS NULL vs IS NOT NULL
- The BETWEEN operator is used in a WHERE clause to filter the result set within a certain range
```sql
SELECT *
FROM movies
WHERE year BETWEEN 1990 AND 1999;   -- 1999 inclusive

-- result set to only include movies with names that begin with the letter ‘A’ up to, but not including ones that begin with ‘J’.
SELECT *
FROM movies
WHERE name BETWEEN 'A' AND 'J';  -- 'J' only will be included
```
- AND operator:
```sql
SELECT * 
FROM movies
WHERE year BETWEEN 1990 AND 1999
   AND genre = 'romance';
```
- Similar to OR operator
- Sort the results using ORDER BY, either alphabetically or numerically. The column that we ORDER BY doesn’t even have to be one of the columns that we’re displaying. Note: ORDER BY always goes after WHERE (if WHERE is present).
```sql
SELECT *
FROM movies
WHERE imdb_rating > 8
ORDER BY year DESC;      --ASC is default
```
- LIMIT is a clause that lets you specify the maximum number of rows the result set will have.
```sql
SELECT *
FROM movies
LIMIT 10;
```
- A CASE statement allows us to create different outputs (usually in the SELECT statement). It is SQL’s way of handling if-then logic.
```sql
SELECT name,
 CASE
  WHEN imdb_rating > 8 THEN 'Fantastic'
  WHEN imdb_rating > 6 THEN 'Poorly Received'
  ELSE 'Avoid at All Costs'
 END AS 'Review' --To shorten the very long columnn name, we can rename the it to ‘Review’
FROM movies;
```
##### 3.Aggregrate
- COUNT(): count the number of rows
```sql
SELECT COUNT(*)
FROM table_name;
```
- SUM(): the sum of the values in a column
```sql
SELECT SUM(downloads)
FROM fake_apps;
```
- MAX()/MIN(): the largest/smallest value
- AVG(): the average of the values in a column
- ROUND(): round the values in the column to the number of decimal places specified by the integer.
```sql
SELECT ROUND(price, 0)
FROM fake_apps;
```
- GROUP BY
```sql
SELECT year,
   AVG(imdb_rating)
FROM movies
GROUP BY year
ORDER BY year;
-- The GROUP BY statement comes after any WHERE statements, but before ORDER BY or LIMIT
```
- SQL lets us use column reference(s) in our GROUP BY that will make our lives easier: 1 is the first column selected, 2 is the second column selected, ...
```sql
SELECT ROUND(imdb_rating),
   COUNT(name)
FROM movies
GROUP BY 1
ORDER BY 1;
```
- Filter groups using HAVING. In fact, all types of WHERE clauses you learned about thus far can be used with HAVING.
```sql
SELECT year,
   genre,
   COUNT(name)
FROM movies
GROUP BY 1, 2
HAVING COUNT(name) > 10;
-- HAVING statement always comes after GROUP BY, but before ORDER BY and LIMIT.
```
- Code challenge 2: What are the most popular first names on Codeflix?
```sql
SELECT first_name, COUNT(*)
FROM users
GROUP BY first_name
ORDER BY 2 DESC;
```
- Code challenge 5: Generate a table of user ids and total watch duration for users who watched more than 400 minutes of content.
```sql
SELECT user_id, SUM(watch_duration_in_minutes) AS 'total_watch_duration'
FROM watch_history
GROUP BY 1
HAVING total_watch_duration > 400;   -- error if using '2'
```
##### 4.Multiple table
- Imagine that we’re running a magazine company where users can have different types of subscriptions to different products. A lot of this information would be repeated. If the same customer has multiple subscriptions, that customer’s name and address will be reported multiple times. If the same subscription type is ordered by multiple customers, then the subscription price and subscription description will be repeated. This will make our table big and unmanageable.
- JOIN tables (inner join)
```sql
SELECT *  -- If we only want to select certain columns, we can specify
FROM orders  -- first table 
JOIN customers
  ON orders.customer_id = customers.customer_id;  -- match orders table’s customer_id column with customers table’s customer_id column.
-- use the syntax table_name.column_name to be sure that our requests for columns are unambiguous. 
```
- LEFT JOIN will keep all rows from the first table, regardless of whether there is a matching row in the second table.
```sql
SELECT *
FROM table1
LEFT JOIN table2
  ON table1.c2 = table2.c2;
```
- Primary key: a column that uniquely identifies each row of that table:
   - None of the values can be NULL.
   - Each value must be unique
   - A table can not have more than one primary key column.
- When the primary key for one table appears in a different table, it is called a foreign key.
```sql
SELECT *
FROM classes
JOIN students
  ON classes.id = students.class_id;
```
- CROSS JOIN: combine all rows of one table with all rows of another table.
```sql
SELECT shirts.shirt_color,  -- select the columns shirt_color and pants_color
   pants.pants_color
FROM shirts  -- pulls data from the table shirts
CROSS JOIN pants; -- performs a CROSS JOIN with pants
```
   - A more common usage of CROSS JOIN is when we need to compare each row of a table to a list of values.
   ```sql
   SELECT month, COUNT(*)
   FROM newspaper
   CROSS JOIN months
   WHERE start_month <= month
   AND end_month >= month
   GROUP BY month;
   ```
- UNION: stack one dataset on top of the other.
```sql
SELECT *
FROM table1
UNION
SELECT *
FROM table2;
```
   - Tables must have the same number of columns.
   - The columns must have the same data types in the same order as the first table.
- WITH: combine two tables, but one of the tables is the result of another calculation.
```sql
WITH previous_results AS (
   SELECT customer_id,
   COUNT(subscription_id) AS 'subscriptions'
FROM orders
GROUP BY customer_id;
)
SELECT *
FROM previous_results
JOIN customers
  ON _____ = _____;
```
##### 4.2 Subqueries
- Same functionality as a join, but with much more readability.
- a subquery is an internal query nested inside of an external query. 
   - can be placed inside of SELECT, INSERT, UPDATE, or DELETE statements.
   - Anytime a subquery is present, it gets executed before the external statement is run.
```sql
-- Using Inner Join
SELECT id, first_name, last_name
FROM book_club
JOIN art_club
  ON book_club.id = art_club.id;

-- Using Subqueries
SELECT id, first_name, last_name
FROM book_club
WHERE id IN (
   SELECT id 
   FROM art_club); -- the subquery SELECT statement would be executed first, resulting in a list of student ids from the art_club table. Then, the outer query would run and select the student ids from book_club table which also appear in the subquery results.
```
```sql
-- Write a DELETE query that will remove 9th grade students enrolled in both band and drama from the drama_students table.
DELETE FROM drama_students
WHERE id in (
  SELECT id 
  FROM band_students
  WHERE grade = 9);
```

