-- *******************************************************
-- Database: ExampleDB
-- Description: This is a collection of common SQL commands
-- for MySQL with explanations.
-- *******************************************************

-- *******************************************************
-- CREATE DATABASE
-- *******************************************************
-- Creating a new database named "ExampleDB"
CREATE DATABASE ExampleDB;

-- Use the database to work on it
USE ExampleDB;

-- *******************************************************
-- CREATE TABLE
-- *******************************************************
-- Creating a table named "users" with basic columns
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-incrementing ID for each user
    name VARCHAR(100),                  -- Name of the user
    email VARCHAR(100),                 -- Email address of the user
    age INT,                            -- Age of the user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Automatically set the creation date
);

-- *******************************************************
-- INSERT INTO Table
-- *******************************************************
-- Inserting a new row into the "users" table
INSERT INTO users (name, email, age)
VALUES ('John Doe', 'john@example.com', 30);

-- Inserting multiple rows
INSERT INTO users (name, email, age)
VALUES 
    ('Alice Smith', 'alice@example.com', 25),
    ('Bob Johnson', 'bob@example.com', 35);

-- *******************************************************
-- SELECT Statement
-- *******************************************************
-- Retrieving all data from the "users" table
SELECT * FROM users;

-- Retrieving specific columns from the "users" table
SELECT name, email FROM users;

-- Using WHERE clause to filter results
SELECT * FROM users WHERE age > 30;

-- *******************************************************
-- UPDATE Statement
-- *******************************************************
-- Updating data in the "users" table
UPDATE users
SET age = 31
WHERE name = 'John Doe';

-- *******************************************************
-- DELETE Statement
-- *******************************************************
-- Deleting a user with a specific condition
DELETE FROM users WHERE name = 'Alice Smith';

-- *******************************************************
-- ALTER TABLE
-- *******************************************************
-- Adding a new column to the "users" table
ALTER TABLE users ADD COLUMN address VARCHAR(255);

-- Modifying an existing column in the "users" table
ALTER TABLE users MODIFY COLUMN age TINYINT;

-- Dropping a column from the "users" table
ALTER TABLE users DROP COLUMN address;

-- *******************************************************
-- CREATE INDEX
-- *******************************************************
-- Creating an index on the "email" column to improve search speed
CREATE INDEX idx_email ON users(email);

-- *******************************************************
-- JOIN Operation
-- *******************************************************
-- Example 1: INNER JOIN between "users" and "orders" tables
-- (assuming an "orders" table exists with a "user_id" foreign key)
SELECT users.name, orders.order_id
FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- Example 2: LEFT JOIN - Get all users and their orders (even if some users have no orders)
SELECT users.name, orders.order_id
FROM users
LEFT JOIN orders ON users.id = orders.user_id;

-- *******************************************************
-- GROUP BY & HAVING
-- *******************************************************
-- Example 1: GROUP BY with aggregate function COUNT
-- Counting how many orders each user has placed
SELECT users.name, COUNT(orders.order_id) AS order_count
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.id;

-- Example 2: HAVING to filter groups based on aggregate functions
-- Display users with more than 1 order
SELECT users.name, COUNT(orders.order_id) AS order_count
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.id
HAVING order_count > 1;

-- *******************************************************
-- LIKE Operator (String Matching)
-- *******************************************************
-- Searching for users whose names start with 'J'
SELECT * FROM users WHERE name LIKE 'J%';

-- Searching for users with 'example' in their email
SELECT * FROM users WHERE email LIKE '%example%';

-- *******************************************************
-- DISTINCT Keyword
-- *******************************************************
-- Retrieve unique ages from the "users" table
SELECT DISTINCT age FROM users;

-- *******************************************************
-- ORDER BY Clause
-- *******************************************************
-- Sorting the users table by age in ascending order
SELECT * FROM users ORDER BY age ASC;

-- Sorting the users table by age in descending order
SELECT * FROM users ORDER BY age DESC;

-- *******************************************************
-- LIMIT Clause
-- *******************************************************
-- Retrieve only the first 5 users
SELECT * FROM users LIMIT 5;

-- Retrieve 5 users starting from the 6th
SELECT * FROM users LIMIT 5 OFFSET 5;

-- *******************************************************
-- Using Subqueries
-- *******************************************************
-- Example 1: Simple subquery to find users older than the average age
SELECT * FROM users
WHERE age > (SELECT AVG(age) FROM users);

-- Example 2: Subquery to find users who have placed orders
SELECT * FROM users
WHERE id IN (SELECT user_id FROM orders);

-- *******************************************************
-- Transactions
-- *******************************************************
-- Start a new transaction
START TRANSACTION;

-- Insert a new user
INSERT INTO users (name, email, age)
VALUES ('Charlie Brown', 'charlie@example.com', 28);

-- If everything is correct, commit the transaction
COMMIT;

-- If something goes wrong, rollback to the previous state
ROLLBACK;

-- *******************************************************
-- CREATE VIEW
-- *******************************************************
-- Creating a view to simplify complex queries
CREATE VIEW user_orders AS
SELECT users.name, COUNT(orders.order_id) AS order_count
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.id;

-- Now, you can simply query the view like a table
SELECT * FROM user_orders;

-- *******************************************************
-- Using Functions (e.g., CONCAT, NOW)
-- *******************************************************
-- Example 1: CONCAT function to combine first and last names
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM users;

-- Example 2: Using NOW() to get the current date and time
SELECT name, NOW() AS current_time FROM users;

-- *******************************************************
-- DROP TABLE
-- *******************************************************
-- Dropping a table completely (be careful with this operation)
DROP TABLE users;

-- *******************************************************
-- DROP DATABASE
-- *******************************************************
-- Dropping a database completely (be careful with this operation)
DROP DATABASE ExampleDB;

