--########################################################
--		BOOK: LEARNING MYSQL AND MARIADB 0'REILLY
--########################################################

--########################################################
--		CHAPTER 2: INSTALLATION
--########################################################

--mariadb -u root -p

SHOW DATABASES;
SELECT User,Host FROM mysql.user;
GRANT USAGE ON *.* TO 'econb'@'localhost' IDENTIFIED BY '123';

--########################################################
--		CHAPTER 3: THE BASICS
--########################################################

CREATE DATABASE test;
CREATE TABLE test.books (book_id INT, title TEXT, status INT);
SHOW TABLES FROM test;
USE test;
DESCRIBE books;
INSERT INTO books VALUES(100, 'Heart of Darkness', 0);
INSERT INTO books VALUES(101, 'The Catcher of the Rye', 1);
INSERT INTO books VALUES(102, 'My Antonia', 0);
SELECT * FROM books WHERE status=1;
SELECT * FROM books WHERE status = 0 \G
UPDATE books SET status = 1 WHERE book_id=102;

CREATE TABLE status_names (status_id INT, status_name CHAR(8));
INSERT INTO status_names VALUES(0, 'Inactive'), (1,'Active');
SELECT * FROM books JOIN status_names WHERE status = status_id;

--########################################################
--		CHAPTER 4: CREATING DATABASES AND TABLES
--########################################################

DROP DATABASE rookery;
CREATE DATABASE rookery
CHARACTER SET latin1
COLLATE latin1_bin;
USE rookery;

CREATE TABLE birds (
bird_id INT AUTO_INCREMENT PRIMARY KEY,
scientific_name VARCHAR(255) UNIQUE,
common_name VARCHAR(50),
family_id INT,
description TEXT);
DESCRIBE birds;
INSERT INTO birds (scientific_name, common_name)
VALUES ('Charadrius vociferus', 'Killdeer'),
('Gavia immer', 'Great Northern Loon'),
('Aix sponsa', 'Wood Duck'),
('Chordeiles minor', 'Common Nighthawk'),
('Sitta carolinensis', ' White-breasted Nuthatch'),
('Apteryx mantelli', 'North Island Brown Kiwi');
SHOW CREATE TABLE birds \G

CREATE DATABASE birdwatchers;
CREATE TABLE birdwatchers.humans
(human_id INT AUTO_INCREMENT PRIMARY KEY,
formal_title VARCHAR(25),
name_first VARCHAR(25),
name_last VARCHAR(25),
email_address VARCHAR(255));
INSERT INTO birdwatchers.humans
(formal_title, name_first, name_last, email_address)
VALUES
('Mr.', 'Russell', 'Dyer', 'russell@mysqlresources.com'),
('Mr.', 'Richard', 'Stringer', 'richard@mysqlresources.com'),
('Ms.', 'Rusty', 'Osborne', 'rusty@mysqlresources.com'),
('Ms.', 'Lexi', 'Hollar', 'alexandra@mysqlresources.com');
CREATE TABLE bird_families (
family_id INT AUTO_INCREMENT PRIMARY KEY,
scientific_name VARCHAR(255) UNIQUE,
brief_description VARCHAR(255) );
CREATE TABLE bird_orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
scientific_name VARCHAR(255) UNIQUE,
brief_description VARCHAR(255),
order_image BLOB
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--########################################################
--		CHAPTER 4: ALTERING TABLES
--########################################################

ALTER TABLE bird_families
ADD COLUMN order_id INT;
USE test;
CREATE TABLE birds_new_alternative
SELECT * FROM rookery.birds;
DROP TABLE birds_new_alternative;

ALTER TABLE birds_new
ADD COLUMN wing_id CHAR(2);
ALTER TABLE birds_new
DROP COLUMN wing_id;

ALTER TABLE birds_new
ADD COLUMN wing_id CHAR(2) AFTER family_id;
ADD COLUMN body_id CHAR(2) AFTER wing_id,
ADD COLUMN bill_id CHAR(2) AFTER body_id,
ADD COLUMN endangered BIT DEFAULT b'1' AFTER bill_id,
CHANGE COLUMN common_name common_name VARCHAR(255);

UPDATE birds_new SET endangered = 0
WHERE bird_id IN(1,2,4,5);
SELECT * FROM birds_new WHERE endangered \G

UPDATE birds_new SET endangered = 1
WHERE bird_id IN(3,6);
SELECT * FROM birds_new WHERE endangered \G

ALTER TABLE birds_new
MODIFY COLUMN endangered
ENUM('Extinct',
'Extinct in Wild',
'Threatened - Critically Endangered',
'Threatened - Endangered',
'Threatened - Vulnerable',
'Lower Risk - Conservation Dependent',
'Lower Risk - Near Threatened',
'Lower Risk - Least Concern')
AFTER family_id;

