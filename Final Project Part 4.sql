-- This is a test change YEET!
-- Select the machines that have a price higher than 10,000 make the list ascending.
USE mydb;
SELECT brand, price
FROM machines
WHERE price > 10000
ORDER BY price;

-- Select the machines that have a price lower than 10,000 make the list descending.
SELECT brand, price
FROM machines
WHERE price < 10000
ORDER BY price DESC;

-- Select all of the gear that would fit someone a size Large.
SELECT brand, name, size
FROM gear
WHERE size = 'L';

-- You are wanting to buy a new machine for the upcoming winter. 
-- Use a join to select all of the machines in the Snowmobile and Timbersled category.
SELECT brand, year, model, price, category
FROM machines m
JOIN machine_category mc
ON m.machine_category_id = mc.id
WHERE category = 'Snowmobiles' OR category = 'Timbersleds';

-- Select all of the customers who live in Bonneville county.
SELECT first_name, last_name
FROM customers c
JOIN addresses a
ON c.id = a.customers_id
WHERE county = 'Bonneville';

-- Tiffany Thompson got married to John Smith and needs to change her last name.
-- Update the customers table to give tiffany the last name of 'Smith'.
UPDATE customers SET last_name = 'Smith'
WHERE first_name = 'Tiffany' AND last_name = 'Thompson';
SELECT * FROM customers;

-- Tiffany Smith now wants to change her email. Update her email to 'tiffany.smith123@gmail.com'
UPDATE customers SET email = 'tiffany.smith123@gmail.com'
WHERE first_name = 'Tiffany' AND last_name = 'Smith';
SELECT * FROM customers;

-- Our motorsports company no longet offers Oil Changes. Delete Oil Changes option from the services menu.
DELETE FROM services 
WHERE type = 'Oil Change';
SELECT * FROM services;