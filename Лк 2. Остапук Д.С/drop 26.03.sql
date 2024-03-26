DROP DATABASE IF EXISTS online_banking;

CREATE DATABASE online_banking;

USE online_banking;
ALTER TABLE accounts
DROP FOREIGN KEY fk_client_id;

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
    client_id INT
);

ALTER TABLE clients
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE accounts
ADD CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES clients(client_id);

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