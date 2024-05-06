DROP DATABASE IF EXISTS final_exam;
CREATE DATABASE final_exam;

USE final_exam;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS departments;

CREATE TABLE IF NOT EXISTS departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(45),
    manager_id INT
);

CREATE TABLE IF NOT EXISTS jobs (
    id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(45),
    min_salary DECIMAL(6),
    max_salary DECIMAL(6)
);

CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    hire_date DATE,
    job_id VARCHAR(45),
    salary DECIMAL(8,2),
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (manager_id) REFERENCES employees(id),
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);

INSERT INTO jobs (id, job_title, min_salary, max_salary) VALUES
('AD_PRES', 'President', '20080', '40000'),
('FI_ACCOUNT', 'Accountant', '4200', '9000'),
('HR_REP', 'Human Resources Representative', '4000', '9000'),
('IT_PROG', 'Programmer', '4000', '10000'),
('MK_MAN', 'Marketing Manager', '9000', '15000');

INSERT INTO departments (id, department_name, manager_id) VALUES
('60', 'IT', '103'),
('70', 'Public Relations', NULL),
('80', 'Sales', NULL),
('90', 'Executive', '100'),
('100', 'Finance', '108'),
('110', 'Accounting', NULL);

INSERT INTO employees (id, first_name, last_name, hire_date, job_id, salary, department_id, manager_id) VALUES
('100', 'Steven', 'King', '2013-06-17', 'AD_PRES', '24000.00', '90', NULL),
('101', 'Neena', 'Yang', '2015-09-21', 'AD_PRES', '17000.00', '90', '100'),
('102', 'Lex', 'Garcia', '2011-01-13', 'AD_PRES', '17000.00', '90', '100'),
('103', 'Alexander', 'James', '2016-01-03', 'IT_PROG', '9000.00', '60', '102'),
('104', 'Bruce', 'Miller', '2017-05-21', 'IT_PROG', '6000.00', '60', '103'),
('105', 'David', 'Williams', '2016-06-25', 'IT_PROG', '4800.00', '60', '103'),
('106', 'Valli', 'Jackson', '2016-02-05', 'IT_PROG', '4800.00', '60', '103'),
('107', 'Diana', 'Nguyen', '2017-02-07', 'IT_PROG', '4200.00', '60', '103'),
('108', 'Nancy', 'Gruenberg', '2012-08-17', 'FI_ACCOUNT', '12008.00', '100', NULL),
('109', 'Daniel', 'Faviet', '2012-08-16', 'FI_ACCOUNT', '9000.00', '100', '108'),
('110', 'John', 'Chen', '2015-09-28', 'FI_ACCOUNT', '8200.00', '100', '108'),
('111', 'Ismael', 'Sciarra', '2015-09-30', 'FI_ACCOUNT', '7700.00', '100', '108'),
('112', 'Jose Manuel', 'Urman', '2016-03-07', 'FI_ACCOUNT', '7800.00', '100', '108'),
('113', 'Luis', 'Popp', '2017-12-07', 'FI_ACCOUNT', '6900.00', '100', '108');

	INSERT INTO employees VALUES ( 145, 'John', 'Singh', '2014-10-01', 'MK_MAN', 14000, 80, 100);
    INSERT INTO employees VALUES ( 200, 'Jennifer', 'Whalen', '2013-09-17', 'AD_PRES', 4400, 110, 101);
	INSERT INTO employees VALUES ( 201, 'Michael', 'Martinez', '2014-02-17', 'MK_MAN', 13000, 110, 100);
	INSERT INTO employees VALUES ( 202, 'Pat', 'Davis', '2015-08-17', 'MK_MAN', 6000, 110, 201);
	INSERT INTO employees VALUES ( 203, 'Susan', 'Jacobs', '2012-06-07', 'HR_REP', 6500, 110, 101);
	INSERT INTO employees VALUES ( 204, 'Hermann', 'Brown', '2012-06-07', 'HR_REP', 10000, 80, 101);
	INSERT INTO employees VALUES ( 205, 'Shelley', 'Higgins', '2012-06-07', 'AD_PRES', 12008, 110, 101);
	INSERT INTO employees VALUES ( 206, 'William', 'Gietz', '2012-06-07', 'AD_PRES', 8300, 110, 205);   
    
# 1.	Таблица Employees. Получить список всех сотрудников из 60го отдела (department_id) с зарплатой(salary), большей 4000

select *
from employees
where department_id = 60 and salary>4000;

#2.	Таблица Employees. Получить список всех сотрудников, у которых в имени содержатся минимум 2 буквы 'n'

select*
from Employees
where first_name like ('%n%n%');

#3.	Таблица Employees. Получить список всех ID менеджеров

select manager_id
from employees;

#4 	Таблица Employees. Получить список работников с их позициями в формате: Donald(sh_clerk) 

#5.	Таблица Departments. Получить первое слово из имени департамента для тех у кого в названии больше одного слова

#6.	Таблица Employees. Получить список всех сотрудников, которые работают в компании больше 10 лет
select id, first_name, last_name, hire_date
from employees
where  hire_date < '2014-05-06';

#7 7.	Таблица Employees. Получить список всех сотрудников, которые пришли на работу в августе 2012го года. 
select id, first_name, last_name, hire_date
from employees
where  hire_date between '2011-12-31' and '2013-01-01';

#8.	Таблица Employees. Сколько сотрудников имена которых начинается с одной и той же буквы? Сортировать по количеству. Показывать только те где количество больше 1

# 9.	Таблица Employees. Сколько сотрудников которые работают в одном и тоже отделе и получают одинаковую зарплату? 

select department_id, salary, count(*) as emp_count
from employees
group by department_id, salary
having count(*) > 1;

# 10.	Таблица Employees, Departaments. Получить список department_id, department_name и округленную среднюю зарплату работников в каждом департаменте. 
select d.id as department_id, d. department_name, round(avg(e.salary)) as averange_salary
from departments as d join employees as e on d.id = e.department_id
group by d.id, d.department_name;

#11.	Таблица Employees, Departaments. Показать все департаменты, в которых нет ни одного сотрудника
select d.id as department_id, d.department_name
from departments as d left join employees as e 
on d.id = e.department_id
where e.id is null;

#14.	Таблица Employees. Получить список сотрудников, у которых менеджер получает зарплату больше 15000.
select *
from employees as e join jobs as j
on e. manager_id = manager_id
where j.max_salary > 15000; 