-- DB azienda giocattoli TOYSGROUP 

create schema toysgroup;

-- CREAZIONE TABELLE

CREATE TABLE product (
    ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(30),
    name_product VARCHAR(30),
    price FLOAT(5 , 2),
    created_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
drop table product;

CREATE TABLE sales (
    ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    date_transaction DATE,
    id_product INT NOT NULL,
    id_region INT,
    qty int,
    prezzo_finale float (5, 2),
    created_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_product)
        REFERENCES product (id),
    FOREIGN KEY (id_region)
        REFERENCES region (id)
);
drop table sales;
alter table sales add prezzo_finale float (5, 2);


CREATE TABLE region (
    ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name_region VARCHAR(30) NOT NULL UNIQUE,
    created_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
drop table region;

-- POPOLAMENTO TABELLE

insert into region (name_region) values 
	('Italy'), 
	('Germany'), 
	('Spain'), 
	('China'), 
	('United States'), 
	('India'), 
	('UK'), 
	('Irland'), 
	('Egypt'), 
	('Portugal');
    
-- OPERAZIONI OPZIONALI PROVA
UPDATE region 
SET 
    name_region = 'Morocco'
WHERE
    ID = 7;

insert into product (category, name_product, price) values 
	('Puzzle', 'Puzzle Colosseo', 14.99), 
	('Puzzle', 'Puzzle Ferrari', 19.90), 
	('Puzzle', 'Puzzle art', 11.90), 
	('Peluche', 'Peluche Super Mario', 24.90), 
	('Peluche', 'Peluche Sonic', 21.90), 
	('Peluche', 'Peluche labrador', 19.90), 	
	('Construction', 'LEGO airplane', 29.90), 
	('Construction', 'LEGO Tour Eiffel', 34.90), 
	('Construction', 'LEGO Star Wars', 39.90),
	('Board games', 'Monopoly', 14.99), 
	('Board games', 'Risiko', 29.99);

-- OPERAZIONI OPZIONALI PROVA
UPDATE product 
SET 
    category = 'Board games',
    name_product = 'Cluedo',
    price = 24.90
WHERE
    ID = 11;
    
insert into sales (date_transaction, id_product, id_region, qty) values 
	('2022-09-28', 1, 1, 2),
    ('2019-10-28', 10, 1, 3),
    ('2019-10-28', 10, 1, 1),
    ('2023-10-28', 4, 1, 4),
    ('2020-10-28', 8, 4, 4),
    ('2023-10-28', 2, 3, 7),
    ('2023-10-28', 6, 2, 4),
    ('2024-01-04', 7, 8, 4),
    ('2022-10-28', 5, 5, 3),
    ('2022-10-29', 5, 5, 4),
    ('2022-10-29', 9, 7, 1);
    
UPDATE sales
        JOIN
    product ON sales.id_product = product.ID 
SET 
    prezzo_finale = qty * product.price
    where sales.id >0;
    
-- OPERAZIONI OPZIONALI PROVA
UPDATE sales 
SET 
    id_product = 10,
    id_region = 6
WHERE
    id = 4;
    
UPDATE sales 
SET 
    id_product = 10,
    id_region = 6
WHERE
    id = 1;

DELETE FROM sales 
WHERE
    id = 2;
    
-- QUERY n.1

show columns from sales;
show columns from region;
show columns from product;

-- QUERY n.2

SELECT 
    product.ID AS 'ID',
    name_product AS 'PRODUCT',
    YEAR(date_transaction) AS 'ANNO',
    SUM(price) AS 'FATTURATO'
FROM
    product
        INNER JOIN
    sales ON sales.id_product = product.ID
GROUP BY ID , PRODUCT , ANNO;

-- QUERY n.3

SELECT 
	region.name_region AS 'REGION',
    YEAR(date_transaction) AS 'ANNO',
    SUM(price) AS 'FATTURATO'
FROM
    sales
        INNER JOIN
    product ON sales.id_product = product.ID
    inner join
    region on sales.id_region = region.ID
	GROUP BY  REGION, ANNO
    ORDER BY ANNO DESC, FATTURATO DESC;
    
-- QUERY 4

SELECT 
    category AS 'CATEGORY', 
    COUNT(sales.ID) AS 'VENDUTI'
FROM
    product
        RIGHT JOIN
    sales ON sales.id_product = product.ID
GROUP BY CATEGORY
ORDER BY VENDUTI DESC;

-- QUERY 5

SELECT 
    category AS 'CATEGORIA', 
    name_product AS 'INVENDUTI'
FROM
    product
WHERE
    ID NOT IN (SELECT 
            id_product
        FROM
            sales);
            
SELECT 
    category AS 'CATEGORY', name_product AS 'INVENDUTI'
FROM
    product
        LEFT JOIN
    sales ON sales.id_product = product.ID
WHERE
    id_product IS NULL;
    
-- QUERY 6

SELECT 
    name_product AS 'PRODUCT',
    MAX(date_transaction) AS 'LAST_TRANSACTION'
FROM
    product
        JOIN
    sales ON sales.id_product = product.id
GROUP BY PRODUCT
ORDER BY LAST_TRANSACTION DESC;







