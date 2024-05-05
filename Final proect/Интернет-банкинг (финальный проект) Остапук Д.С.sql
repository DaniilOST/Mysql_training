DROP DATABASE IF EXISTS online_banking;
CREATE DATABASE online_banking;

USE online_banking;

DROP TABLE IF exists Users;
DROP TABLE IF exists Accounts;
DROP TABLE IF exists Transactions;
DROP TABLE IF exists Recipients;
DROP TABLE IF exists CreditCards;
DROP TABLE IF exists LoginHistory;
DROP TABLE IF exists Notifications;
DROP TABLE IF exists NotificationSettings;
DROP TABLE IF exists Currencies;
DROP TABLE IF exists CurrencyRates;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    password VARCHAR(100),
    email VARCHAR(255) UNIQUE
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    account_number VARCHAR(20) UNIQUE,
    balance DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_type VARCHAR(50),
    amount DECIMAL(10, 2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE Recipients (
    recipient_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    recipient_name VARCHAR(100),
    account_number VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE CreditCards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    card_number VARCHAR(16) UNIQUE,
    expiry_date DATE,
    cvv VARCHAR(3),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE LoginHistory (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    logout_time TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    notification_type VARCHAR(50),
    message TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE NotificationSettings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    email_notifications BOOLEAN,
    sms_notifications BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Currencies (
    currency_id INT PRIMARY KEY AUTO_INCREMENT,
    currency_name VARCHAR(50),
    symbol VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);

CREATE TABLE CurrencyRates (
    rate_id INT PRIMARY KEY AUTO_INCREMENT,
    currency_id_from INT,
    currency_id_to INT,
    exchange_rate DECIMAL(10, 4),
    FOREIGN KEY (currency_id_from) REFERENCES Currencies(currency_id),
    FOREIGN KEY (currency_id_to) REFERENCES Currencies(currency_id)
);

INSERT INTO Users (username, password, email) VALUES
('alice', 'password123', 'alice@example.com'),
('bob', 'securepwd', 'bob@example.com'),
('charlie', 'pass123', 'charlie@example.com'),
('dave', 'davepass', 'dave@example.com'),
('emma', 'emmapass', 'emma@example.com'),
('fred', 'fred123', 'fred@example.com'),
('grace', 'gracepass', 'grace@example.com'),
('hannah', 'hannah123', 'hannah@example.com'),
('ivan', 'ivanpass', 'ivan@example.com'),
('juliet', 'juliet123', 'juliet@example.com');

INSERT INTO Accounts (user_id, account_number, balance) VALUES
(1, '1234567890', 1500.00),
(2, '9876543210', 2000.00),
(3, '1111222233334444', 500.00),
(4, '4444333322221111', 3000.00),
(5, '5555666677778888', 1000.00),
(6, '9999888877776666', 2500.00),
(7, '7777666655554444', 800.00),
(8, '2222111133336666', 1800.00),
(9, '8888777766665555', 700.00),
(10, '3333444455556666', 1200.00);

INSERT INTO Transactions (account_id, transaction_type, amount) VALUES
(1, 'Deposit', 500.00),
(2, 'Deposit', 1000.00),
(3, 'Withdrawal', 200.00),
(4, 'Deposit', 800.00),
(5, 'Withdrawal', 500.00),
(6, 'Deposit', 1500.00),
(7, 'Withdrawal', 200.00),
(8, 'Deposit', 700.00),
(9, 'Withdrawal', 300.00),
(10, 'Deposit', 1000.00);

INSERT INTO Recipients (user_id, recipient_name, account_number) VALUES
(1, 'Alice Smith', '1111222233335555'),
(2, 'Bob Johnson', '7777666655554444'),
(3, 'Charlie Brown', '8888777766669999'),
(4, 'Dave Wilson', '3333444455556666'),
(5, 'Emma Thompson', '4444333322227777'),
(6, 'Fred Davis', '2222111133338888'),
(7, 'Grace White', '9999888877771111'),
(8, 'Hannah Taylor', '5555666677772222'),
(9, 'Ivan Martin', '8888999911113333'),
(10, 'Juliet Clark', '7777888899994444');

INSERT INTO CreditCards (user_id, card_number, expiry_date, cvv) VALUES
(1, '1111222233334444', '2025-12-31', '123'),
(2, '5555666677778888', '2024-10-31', '456'),
(3, '9999888877776666', '2023-08-31', '789'),
(4, '4444333322221111', '2026-06-30', '234'),
(5, '7777666655554444', '2025-04-30', '567'),
(6, '2222111133338888', '2027-02-28', '890'),
(7, '9999888877771111', '2026-12-31', '345'),
(8, '5555666677772222', '2025-10-31', '678'),
(9, '8888999911113333', '2024-08-31', '901'),
(10, '3333444455556666', '2023-06-30', '234');

INSERT INTO LoginHistory (user_id, login_time, logout_time) VALUES
(1, '2024-04-26 08:00:00', '2024-04-26 10:00:00'),
(2, '2024-04-26 09:30:00', '2024-04-26 11:30:00'),
(3, '2024-04-26 10:45:00', '2024-04-26 12:45:00'),
(4, '2024-04-26 12:00:00', '2024-04-26 14:00:00'),
(5, '2024-04-26 13:15:00', '2024-04-26 15:15:00'),
(6, '2024-04-26 14:30:00', '2024-04-26 16:30:00'),
(7, '2024-04-26 15:45:00', '2024-04-26 17:45:00'),
(8, '2024-04-26 17:00:00', '2024-04-26 19:00:00'),
(9, '2024-04-26 18:15:00', '2024-04-26 20:15:00'),
(10, '2024-04-26 19:30:00', '2024-04-26 21:30:00');

INSERT INTO Notifications (user_id, notification_type, message) VALUES
(1, 'Email', 'You have a new message.'),
(2, 'SMS', 'Payment received.'),
(3, 'Push', 'Account balance low.'),
(4, 'Email', 'Payment confirmation.'),
(5, 'SMS', 'New transaction.'),
(6, 'Email', 'Password reset request.'),
(7, 'Push', 'Account activity alert.'),
(8, 'SMS', 'New login from new device.'),
(9, 'Email', 'Monthly statement available.'),
(10, 'Push', 'Transaction limit exceeded.');

INSERT INTO NotificationSettings (user_id, email_notifications, sms_notifications) VALUES
(1, 1, 0),
(2, 0, 1),
(3, 1, 1),
(4, 1, 1),
(5, 0, 1),
(6, 1, 0),
(7, 0, 0),
(8, 1, 1),
(9, 1, 1),
(10, 0, 0);

INSERT INTO Currencies (currency_name, symbol) VALUES
('US Dollar', '$'),
('Euro', '€'),
('British Pound', '£'),
('Japanese Yen', '¥'),
('Canadian Dollar', 'CA$'),
('Australian Dollar', 'A$'),
('Swiss Franc', 'CHF'),
('Chinese Yuan', 'CN¥'),
('Indian Rupee', '₹'),
('Russian Ruble', '₽');

INSERT INTO CurrencyRates (currency_id_from, currency_id_to, exchange_rate) VALUES
(1, 1, 1.0),    # Обменный курс для USD к USD
(2, 1, 1.18),   # Обменный курс для EUR к USD
(3, 1, 1.35),   # Обменный курс для GBP к USD
(4, 1, 0.0091), # Обменный курс для JPY к USD
(5, 1, 0.78),   # Обменный курс для CAD к USD
(1, 2, 0.85),   # Обменный курс для USD к EUR
(2, 2, 1.0),    # Обменный курс для EUR к EUR 
(3, 2, 0.88),   # Обменный курс для GBP к EUR
(4, 2, 0.0077), # Обменный курс для JPY к EUR
(5, 2, 0.66);   # Обменный курс для CAD к EUR

# Представление для отображения информации о счетах пользователей
CREATE VIEW AccountDetails AS
SELECT A.account_id, A.account_number, A.balance, U.username
FROM Accounts AS A
JOIN Users U ON A.user_id = U.user_id;

# Триггер для автоматического обновления баланса счета
DELIMITER //
CREATE TRIGGER UpdateAccountBalance AFTER INSERT ON Transactions FOR EACH ROW
BEGIN
    DECLARE account_balance DECIMAL(10, 2);
    DECLARE transaction_amount DECIMAL(10, 2);
    SELECT balance INTO account_balance FROM Accounts WHERE account_id = NEW.account_id;
    SET transaction_amount = NEW.amount;
    IF NEW.transaction_type = 'Deposit' THEN
        SET account_balance = account_balance + transaction_amount;
    ELSEIF NEW.transaction_type = 'Withdrawal' THEN
        SET account_balance = account_balance - transaction_amount;
    END IF;
    UPDATE Accounts SET balance = account_balance WHERE account_id = NEW.account_id;
END;
//
DELIMITER ;
