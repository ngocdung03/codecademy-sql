##### What is SQL
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