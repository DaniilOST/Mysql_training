DROP DATABASE IF EXISTS pract1;
CREATE DATABASE pract1;
USE pract1;

DROP TABLE IF EXISTS Assessments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS teachers;

CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    last_name VARCHAR(200) NOT NULL,
    patronymic VARCHAR(200) NOT NULL,
    department VARCHAR(600) NOT NULL
);

CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,    
    name VARCHAR(200) NOT NULL,
    last_name VARCHAR(200) NOT NULL,
    patronymic VARCHAR(200) NOT NULL,
    student_group VARCHAR(300) NOT NULL,
    teacher_id INT,
    CONSTRAINT fk_teacher_id1 FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE IF NOT EXISTS Assessments (
    Assessments_id INT PRIMARY KEY,
    teacher_id INT,
    student_id INT,
    date DATE NOT NULL,
    Assessment INT,
    CONSTRAINT fk_teacher_id2 FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name, last_name, patronymic, student_group)
VALUES
    (1, 'Иван', 'Иванов', 'Иванович', '10503321'),
    (2, 'Петр', 'Петров', 'Петрович', '10503322'),
    (3, 'Мария', 'Сидорова', 'Ивановна', '10503323'),
    (4, 'Алексей', 'Алексеев', 'Алексеевич', '10503324'),
    (5, 'Елена', 'Еленова', 'Еленовна', '10503325');

INSERT INTO teachers (teacher_id, name, last_name, patronymic, department)
VALUES
    (1, 'Иван', 'Иванов', 'Иванович', 'Бизнес-администрирование'),
    (2, 'Петр', 'Петров', 'Петрович', 'Маркетинг'),
    (3, 'Мария', 'Сидорова', 'Ивановна', 'Межкультурная профессиональная коммуникация'),
    (4, 'Алексей', 'Алексеев', 'Алексеевич', 'Торговое и рекламное оборудование'),
    (5, 'Елена', 'Еленова', 'Еленовна', 'Экономика и управление инновационными проектами в промышленности');

INSERT INTO Assessments (Assessments_id, teacher_id, student_id, date, Assessment)
VALUES
    (1, 1, 1, '2024-01-16', 1),
    (2, 2, 2, '2024-01-12', 2),
    (3, 3, 3, '2024-01-13', 3),
    (4, 4, 4, '2024-01-17', 4),
    (5, 5, 5, '2024-01-24', 5);

SELECT *
FROM Assessments
WHERE Assessment > 0
AND date BETWEEN '2024-01-15' AND '2024-01-20';

SELECT *
FROM Assessments
WHERE Assessment > 0
AND student_id IN (1, 2);

SELECT *
FROM students
WHERE student_group NOT IN ('Г-1', 'Г-2');

