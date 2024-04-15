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

DROP TABLE IF EXISTS contract_types;
CREATE TABLE IF NOT EXISTS contract_types (
    contract_type_id INT PRIMARY KEY AUTO_INCREMENT,
    contract_type_name VARCHAR(200) NOT NULL
);

INSERT INTO contract_types (contract_type_name)
VALUES
    ('Кредитный'),
    ('Депозитный'),
    ('Сберегательный'),
    ('Текущий');

DROP TABLE IF EXISTS accounts;
CREATE TABLE IF NOT EXISTS accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    account_type_id INT,
    currency VARCHAR(200) NOT NULL,
    client_id INT,
    CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES clients(client_id),
    CONSTRAINT fk_account_type_id FOREIGN KEY (account_type_id) REFERENCES contract_types(contract_type_id)
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

INSERT INTO accounts (account_type_id, currency, client_id)
VALUES
    (1, 'RUB', 1),
    (4, 'USD', 2),
    (1, 'EUR', 3),
    (1, 'RUB', 4),
    (3, 'USD', 5),
    (4, 'EUR', 6),
    (1, 'RUB', 7),
    (3, 'USD', 8),
    (4, 'EUR', 9),
    (1, 'RUB', 10);

UPDATE clients
SET phone_number = '1111222233' 
WHERE client_id = 1;

UPDATE accounts
SET account_type_id = (SELECT contract_type_id FROM contract_types WHERE contract_type_name = 'Депозитный')
WHERE account_type_id = (SELECT contract_type_id FROM contract_types WHERE contract_type_name = 'Кредитный');

INSERT INTO clients (name, last_name, patronymic, phone_number, email, birthday, residential_address)
SELECT 'Иван', 'Иванов', 'Сергеевич', '1234563890', 'vano@example.com', '1991-01-01', 'ул. Ленина, д. 1'
FROM contract_types
WHERE contract_type_name = 'Кредитный';


select *,
(select contract_type_name from contract_types where account_type_id = contract_type_id) as dop_info
from accounts
where account_type_id <> any(select account_number from accounts);

DELETE FROM accounts
WHERE client_id = (SELECT client_id FROM clients WHERE name = 'Елена');

select *
from accounts
where exists 
	(select * from accounts where client_id = client_id);