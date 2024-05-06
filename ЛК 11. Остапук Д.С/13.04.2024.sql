-- Удаляем существующую базу данных online_banking, если таковая существует
DROP DATABASE IF EXISTS online_banking;

-- Создаем новую базу данных online_banking
CREATE DATABASE online_banking;

-- Используем созданную базу данных
USE online_banking;

-- Удаляем таблицу clients, если она существует
DROP TABLE IF EXISTS clients;

-- Создаем таблицу clients для хранения информации о клиентах
CREATE TABLE IF NOT EXISTS clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор клиента
    name VARCHAR(200) NOT NULL, -- Имя клиента
    last_name VARCHAR(200) NOT NULL, -- Фамилия клиента
    patronymic VARCHAR(200) NOT NULL, -- Отчество клиента
    phone_number VARCHAR(10) NOT NULL, -- Номер телефона клиента
    email VARCHAR(200) NOT NULL, -- Email клиента
    birthday DATE NOT NULL, -- День рождения клиента
    residential_address VARCHAR(200) NOT NULL -- Адрес проживания клиента
);

-- Удаляем таблицу contract_types, если она существует
DROP TABLE IF EXISTS contract_types;

-- Создаем таблицу contract_types для хранения типов контрактов
CREATE TABLE IF NOT EXISTS contract_types (
    contract_type_id INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор типа контракта
    contract_type_name VARCHAR(200) NOT NULL -- Название типа контракта
);

-- Вставляем значения типов контрактов в таблицу contract_types
INSERT INTO contract_types (contract_type_name)
VALUES
    ('Кредитный'),
    ('Депозитный'),
    ('Сберегательный'),
    ('Текущий');

Drop table if exists log_table;

create table if not exists log_table (
	id int auto_increment primary key,
    log_date datetime default current_timestamp,
    log_type set("delete", "update","insert"),
    table_name varchar(50),
    client_id int not null
);

-- Удаляем таблицу accounts, если она существует
DROP TABLE IF EXISTS accounts;

-- Создаем таблицу accounts для хранения информации о счетах клиентов
CREATE TABLE IF NOT EXISTS accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный номер счета
    account_type_id INT, -- Идентификатор типа счета
    currency VARCHAR(200) NOT NULL, -- Валюта счета
    client_id INT, -- Идентификатор клиента
    CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES clients(client_id), -- Внешний ключ на таблицу clients
    CONSTRAINT fk_account_type_id FOREIGN KEY (account_type_id) REFERENCES contract_types(contract_type_id) -- Внешний ключ на таблицу contract_types
);

-- Добавляем ограничение UNIQUE на поле email в таблице clients
ALTER TABLE clients
ADD CONSTRAINT unique_email UNIQUE (email);

-- Вставляем данные о клиентах в таблицу clients
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

-- Вставляем данные о счетах клиентов в таблицу accounts
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

create view account_currency as select a.client_id a_client_id, c.contract_type_id c_contract_id, c.contract_type_name c_contract_type_name
from accounts as a
join contract_types as c 
on a.client_id = c.contract_type_id
order by a.client_id desc;

select * 
from account_currency;