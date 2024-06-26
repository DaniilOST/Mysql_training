DROP DATABASE IF EXISTS online_banking;
CREATE DATABASE online_banking;

USE online_banking;

DROP TABLE IF EXISTS clients;
CREATE TABLE IF NOT EXISTS clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    last_name VARCHAR(200) NOT NULL,
    patronymic VARCHAR(200) NOT NULL,
    phone_number VARCHAR(10) NOT NULL, 
    email VARCHAR(200) NOT NULL, 
    birthday DATE NOT NULL,
    residential_address VARCHAR(200) NOT NULL
);


DROP TABLE IF EXISTS accounts;
CREATE TABLE IF NOT EXISTS accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    account_type VARCHAR(200) NOT NULL,
    currency VARCHAR(200) NOT NULL,
    client_id INT,
    CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

ALTER TABLE clients
ADD CONSTRAINT unique_email UNIQUE (email);

INSERT INTO clients (name, last_name, patronymic, phone_number, email, birthday, residential_address)
VALUES
    ('Иван', 'Иванов', 'Иванович', '1234567890', 'ivan@example.com', '1990-01-01', 'ул. Ленина, д. 1'),
    ('Петр', 'Петров', 'Петрович', '9876543210', 'petr@example.com', '1985-05-05', 'ул. Пушкина, д. 10'),
    ('Мария', 'Сидорова', 'Ивановна', '5555555555', 'maria@example.com', '1995-10-10', 'ул. Гагарина, д. 5'),
    ('Алексей', 'Алексеев', 'Алексеевич', '1111111111', 'alex@example.com', '1988-08-08', 'ул. Кирова, д. 8'),
    ('Елена', 'Еленова', 'Еленовна', '2222222222', 'elena@example.com', '1992-02-02', 'ул. Сталина, д. 20'),
    ('Дмитрий', 'Дмитриев', 'Дмитриевич', '3333333333', 'dmitriy@example.com', '1980-12-12', 'ул. Лермонтова, д. 12'),
    ('Ольга', 'Ольгова', 'Ольговна', '4444444444', 'olga@example.com', '1983-03-03', 'ул. Ленина, д. 30'),
    ('Николай', 'Николаев', 'Николаевич', '6666666666', 'nikolay@example.com', '1975-07-07', 'ул. Гоголя, д. 7'),
    ('Анна', 'Иванова', 'Петровна', '7777777777', 'anna@example.com', '1987-04-15', 'ул. Кирова, д. 15'),
    ('Сергей', 'Сергеев', 'Сергеевич', '8888888888', 'sergey@example.com', '1978-11-25', 'ул. Пушкина, д. 5');

INSERT INTO accounts (account_type, currency, client_id)
VALUES
    ('Сберегательный', 'RUB', 1),
    ('Текущий', 'USD', 2),
    ('Кредитный', 'EUR', 3),
    ('Кредитный', 'RUB', 4),
    ('Сберегательный', 'USD', 5),
    ('Текущий', 'EUR', 6),
    ('Кредитный', 'RUB', 7),
    ('Сберегательный', 'USD', 8),
    ('Текущий', 'EUR', 9),
    ('Кредитный', 'RUB', 10);


UPDATE clients
SET phone_number = '1111222233' 
WHERE client_id = 1;


UPDATE accounts
SET account_type = 'Депозитный'
WHERE account_number = 1;

SELECT *
FROM clients;

SELECT name, last_name, patronymic 
FROM clients;

SELECT currency
FROM accounts
WHERE currency IN ('USD');

SELECT currency
FROM accounts
WHERE currency IN ('RUB')
AND client_id > 6;

SELECT currency
FROM accounts
WHERE currency IN ('EUR')
OR client_id > 6;

SELECT name, last_name, patronymic
FROM clients
ORDER BY last_name, name, patronymic;

SELECT name, last_name, patronymic
FROM clients
ORDER BY last_name, name, patronymic
LIMIT 5;

SELECT name, last_name, birthday
FROM clients
WHERE MONTH(birthday) = MONTH(CURRENT_DATE());

SELECT *
FROM clients
where phone_number > 1111111111
order by name;

SELECT *
FROM clients
where phone_number > 1111111111
and phone_number < 6666666666
order by name;

SELECT account_type, count(client_id)
FROM accounts 
GROUP BY account_type;

SELECT account_type, count(client_id)
FROM accounts 
GROUP BY account_type
HAVING count(client_id) > 2;

SELECT *
FROM clients 
WHERE last_name like 'и%';

SELECT 
    account_type AS act,
    currency AS cur, 
    client_id AS cid,
    CASE
        WHEN client_id > 5 THEN 'New client'
        ELSE 'Old customers'
    END AS client_status
FROM accounts;

SELECT birthday 
FROM clients 
WHERE birthday > '1990-01-01';
   
SELECT *
FROM clients
WHERE 
    CASE 
        WHEN name IS NULL THEN 1
        WHEN last_name IS NULL THEN 1
        WHEN patronymic IS NULL THEN 1
        WHEN phone_number IS NULL THEN 1
        WHEN email IS NULL THEN 1
        WHEN residential_address IS NULL THEN 1
        ELSE 0
    END = 1;
    
SELECT 
    account_type AS account_type,
    CASE
        WHEN client_id > 5 THEN 'New client'
        ELSE 'Old client'
    END AS client_status,
    COUNT(client_id) AS the_number_of_clients
FROM accounts
GROUP BY account_type, 
         CASE
            WHEN client_id > 5 THEN 'New client'
            ELSE 'Old client'
         END;

SELECT *
FROM accounts AS a 
CROSS JOIN clients AS c;


SELECT *
FROM accounts as a 
INNER JOIN clients as c
ON a.client_id = c.client_id;

SELECT *
FROM accounts as a 
LEFT OUTER JOIN clients as c
ON a.client_id = c.client_id;

SELECT *
FROM accounts as a 
LEFT OUTER JOIN clients as c
ON a.client_id = c.client_id

UNION ALL

SELECT *
FROM accounts AS a
RIGHT JOIN clients AS c 
ON a.client_id = c.client_id;

SELECT *
FROM accounts AS a, clients AS c
WHERE a.client_id = c.client_id;

SELECT c.name, c.last_name, a.currency, SUM(a.account_number) AS total_balance  
FROM clients AS c, accounts AS a  
WHERE c.client_id = a.client_id  
GROUP BY c.name, c.last_name, a.currency  
HAVING SUM(a.account_number) > 0;

SELECT YEAR(c.birthday) AS birth_year, AVG(a.account_number) AS avg_account_number
FROM clients AS c, accounts AS a 
WHERE c.client_id = a.client_id 
GROUP BY YEAR(c.birthday) 
HAVING AVG(a.account_number) > 0;

SELECT *
FROM accounts AS a
LEFT JOIN clients AS c ON a.client_id = c.client_id
WHERE c.client_id IS NULL;

SELECT name, last_name, CONCAT(name, ' ', last_name) AS fullname
FROM clients;

SELECT ROUND(birthday, -3)
FROM clients
ORDER BY birthday DESC;

SELECT UTC_TIME() as time_now;

SELECT client_id, account_type,
       IF(client_id > 5, 'новые счета', 'старые счета') AS account_status
FROM accounts;

SELECT name, last_name,
IFNULL(phone_number, '-') AS phone,
IFNULL(email, '-') AS email
FROM clients;















