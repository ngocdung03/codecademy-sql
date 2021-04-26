##### SQL Manipulation
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

##### Queries
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
