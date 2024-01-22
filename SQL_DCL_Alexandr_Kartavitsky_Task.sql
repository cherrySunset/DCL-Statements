--1
CREATE USER rentaluser WITH PASSWORD 'rentalpassword';
GRANT CONNECT ON DATABASE dvdrental TO rentaluser;


--2
GRANT SELECT ON TABLE customer TO rentaluser;
SELECT * FROM customer;


--3
CREATE GROUP rental;
GRANT rental TO rentaluser;


--4
GRANT INSERT, UPDATE ON TABLE rental TO rental;
GRANT USAGE ON SEQUENCE rental_rental_id_seq TO rental;
SET ROLE rental; 
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (CURRENT_DATE, 1, 1, NULL, 1, CURRENT_TIMESTAMP);
RESET ROLE;

GRANT UPDATE ON TABLE rental TO rental;
SET ROLE rental;
UPDATE rental SET return_date = CURRENT_DATE WHERE rental_id = 1;
RESET ROLE;

--5
REVOKE INSERT ON TABLE rental FROM rental;

--6
CREATE ROLE client_first_name_last_name;

GRANT USAGE ON SCHEMA public TO client_first_name_last_name;
GRANT SELECT ON TABLE payment TO client_first_name_last_name;
GRANT SELECT ON TABLE rental TO client_first_name_last_name;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
   GRANT SELECT ON TABLES TO client_first_name_last_name;
   
SET ROLE client_first_name_last_name;


SELECT * 
FROM payment WHERE customer_id = 1;
SELECT * 
FROM rental WHERE customer_id = 1;

RESET ROLE;  
