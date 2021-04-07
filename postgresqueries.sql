CREATE TABLE links (
	id SERIAL PRIMARY KEY,
	url VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	description VARCHAR (255),
    last_update DATE
);

INSERT INTO links (url, name)
VALUES('https://www.postgresqltutorial.com','PostgreSQL Tutorial');

SELECT * FROM links;

INSERT INTO links (url, name, last_update)
VALUES('https://www.example.com','Example', '07-04-2021');

INSERT INTO links (url, name, last_update)
VALUES('https://www.example.com','Example', '07-04-2021')
RETURNING id;

DELETE FROM links
WHERE id = 3;

INSERT INTO links 
VALUES 
   ('1', 'https://www.postgresqltutorial.com', 'PostgreSQL Tutorial', 'Learn PostgreSQL fast and easy', '2013-06-02'),
   ('2', 'http://www.oreilly.com', 'O''Reilly Media', 'O''Reilly Media', '2013-06-02'),
   ('3', 'http://www.google.com', 'Google', 'Google', '2013-06-02'),
   ('4', 'http://www.yahoo.com', 'Yahoo', 'Yahoo', '2013-06-02'),
   ('5', 'http://www.bing.com', 'Bing', 'Bing', '2013-06-02'),
   ('6', 'http://www.facebook.com', 'Facebook', 'Facebook', '2013-06-01'),
   ('7', 'https://www.tumblr.com/', 'Tumblr', 'Tumblr', '2013-06-02'),
   ('8', 'http://www.postgresql.org', 'PostgreSQL', 'PostgreSQL', '2013-06-02');


CREATE TABLE customer (
	customer_id SERIAL PRIMARY KEY,
    store_id INTEGER,
    first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) ,
	email VARCHAR (255),
    address_id INTEGER,
    activebool BOOLEAN,
    create_date DATE,
    last_update DATE,
    active BOOLEAN
);

INSERT INTO customer (
	customer_id, store_id, first_name, last_name,
	email,address_id,activebool,create_date,
    last_update,active )
VALUES
('1','20','jhunu','z','shubhra@gmail.com','768027','y','01-04-2021','07-04-2021','n'),
('2','30','zeeny','p','zdas@gmail.com','910826','y','30-03-2021','07-04-2021','y'),
('3','22','reenu','S','reenu@gmail.com','768277','n','03-04-2021','07-04-2021','n')


SELECT * FROM customer;

SELECT DISTINCT email FROM customer;

SELECT DISTINCT email,activebool FROM customer;

SELECT first_name,last_name
FROM customer
ORDER BY first_name;

SELECT first_name,last_name
FROM customer
ORDER BY first_name ASC;

SELECT first_name,last_name
FROM customer
ORDER BY first_name DESC;

SELECT first_name,last_name
FROM customer
ORDER BY first_name ASC,last_name DESC;

SELECT first_name,LENGTH(first_name) len
FROM customer
ORDER BY len DESC;

SELECT  last_name,first_name
FROM customer
WHERE first_name = 'jhunu';

SELECT  last_name,first_name
FROM customer
WHERE first_name = 'jhunu';
AND last_name = 'z';

SELECT  last_name,first_name
FROM customer
WHERE first_name IN ('zeeny','reenu');

SELECT first_name,last_name
FROM customer
WHERE first_name LIKE '%en%';

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '%ny';


SELECT first_name,last_name
FROM customer
WHERE first_name LIKE 're%';

SELECT first_name, LENGTH(first_name) name_length
FROM customer
WHERE first_name LIKE '%en%' AND
LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY name_length;

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'j%' AND 
	last_name <> 'Motley';
	
SELECT first_name, LENGTH(first_name) name_length
FROM customer
WHERE first_name LIKE '%en%' AND LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY name_length
LIMIT 1;                                   -- LIMIT is used to select the number of rows to be fetched --

SELECT email, LENGTH(email) email_length
FROM customer
ORDER BY email_length
LIMIT 2  OFFSET 2;

SELECT email,LENGTH(email) email_length
FROM customer
ORDER BY email_length
FETCH FIRST ROW ONLY;

SELECT * 
FROM customer INNER JOIN links
ON customer_id = id;

SELECT * 
FROM customer LEFT JOIN links
ON customer_id = id;

SELECT * 
FROM customer RIGHT JOIN links
ON customer_id = id;

SELECT * 
FROM customer FULL OUTER JOIN links
ON customer_id = id;

SELECT * 
FROM customer FULL OUTER JOIN links
ON customer_id = id
WHERE customer_id IS NOT NULL;

SELECT * 
FROM customer CROSS JOIN links;

SELECT first_name
FROM customer 
GROUP BY customer_id;

SELECT SUM(customer_id)
FROM customer ;

CREATE table tableA(
	CUST_ID_A INT PRIMARY KEY,
	CUST_NAME_A VARCHAR(50),
	ADDRESS_A VARCHAR(60)
);

CREATE table tableB(
	CUST_ID_B INT PRIMARY KEY,
	CUST_NAME_B VARCHAR(50),
	ADDRESS_B VARCHAR(60)
);


INSERT INTO tableA(CUST_ID_A, CUST_NAME_A, ADDRESS_A)
VALUES (101, 'nameA1', 'addressA1'),
(102, 'nameA2', 'addressA2'),
(103, 'nameA3', 'addressA3'),
(104, 'nameA4', 'addressA4'),
(105, 'nameA5', 'addressA4'),
(106, 'nameA1', 'addressA6');


INSERT INTO tableB(CUST_ID_B, CUST_NAME_B, ADDRESS_B)
VALUES (101, 'nameB1', 'addressB1'),
(102, 'nameB2', 'addressB2'),
(103, 'nameB3', 'addressB3'),
(104, 'nameB4', 'addressB4'),
(105, 'nameB5', 'addressB4'),
(106, 'nameB1', 'addressB6');

SELECT * FROM tableA
UNION
SELECT * FROM tableB;

SELECT * FROM tableA
UNION ALL
SELECT * FROM tableB;

SELECT * FROM tableA
EXCEPT 
SELECT * FROM tableB;

SELECT * FROM tableA
EXCEPT 
SELECT * FROM tableB
ORDER BY CUST_ID_A;

SELECT * FROM tableA
GROUP BY CUST_ID_A;

SELECT * FROM tableA
GROUP BY CUST_ID_A
HAVING CUST_ID_A = 101;

SELECT * FROM tableA
GROUP BY CUST_ID_A
HAVING CUST_ID_A >= 104;

SELECT CUST_ID_A,CUST_NAME_A
FROM tableA
GROUP BY CUBE (CUST_ID_A,CUST_NAME_A);    ---- CUBE is used to generate multiple grouping set---- 

SELECT CUST_ID_A,CUST_NAME_A
FROM tableA
GROUP BY ROLLUP (CUST_ID_A,CUST_NAME_A);
--Different from the CUBE subclause, ROLLUP does not generate all possible 
--grouping sets based on the specified columns. It just makes a subset of those

SELECT CUST_ID_A,CUST_NAME_A
FROM tableA
WHERE CUST_ID_A > (
SELECT AVG(CUST_ID_A) FROM tableA
);

SELECT CUST_ID_A,CUST_NAME_A
FROM tableA
WHERE CUST_ID_A > ANY(
SELECT CUST_ID_A FROM tableA
	WHERE CUST_ID_A>104
);


SELECT CUST_ID_A,CUST_NAME_A
FROM tableA
WHERE CUST_ID_A > ALL(
SELECT AVG(CUST_ID_A) FROM tableA
);

SELECT *
FROM tableA
WHERE EXISTS( 
SELECT 1
FROM tableB 
WHERE CUST_ID_B= tableA.CUST_ID_A);


SELECT CUST_ID_A,CUST_NAME_A
FROM tableA
WHERE EXISTS( SELECT NULL );



