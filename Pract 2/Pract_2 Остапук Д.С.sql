DROP DATABASE IF EXISTS pract2;
create database pract2;
use pract2;

drop table  if exists teachers;
drop table  if exists students;
drop table  if exists evaluations;

create table if not exists teachers
(
teacher_id int primary key auto_increment,
teacher_name varchar(50) not null,
teacher_last_name varchar(50) not null,
teacher_patronymic varchar(50) not null,
department varchar(100) not null
); 
 
create table if not exists students
(
student_id int primary key auto_increment,
student_name varchar(50) not null,
student_last_name varchar(50) not null,
student_patronymic varchar(50) not null,
student_group int not null,
teacher_id int,
evaluation_id int,
constraint fk_teachers_id foreign key (teacher_id) references teachers(teacher_id)
);

create table if not exists evaluations
(
evaluation_id int not null,
teacher_id int,
student_id int,
date date not null,
evaluation int not null,
constraint fk_student_id foreign key (student_id) references students(student_id),
constraint fk_teacher_id2 foreign key (teacher_id) references teachers(teacher_id)
);

INSERT INTO students (student_id, student_name, student_last_name, student_patronymic, student_group)
VALUES
    (1, 'Иван', 'Иванов', 'Иванович', '10503323'),
    (2, 'Петр', 'Петров', 'Петрович', '10503322'),
    (3, 'Мария', 'Сидорова', 'Ивановна', '10503323'),
    (4, 'Алексей', 'Алексеев', 'Алексеевич', '10503322'),
    (5, 'Елена', 'Еленова', 'Еленовна', '10503323');

INSERT INTO teachers (teacher_id, teacher_name, teacher_last_name, teacher_patronymic, department)
VALUES
    (1, 'Иван', 'Иванов', 'Иванович', 'Бизнес-администрирование'),
    (2, 'Петр', 'Петров', 'Петрович', 'Маркетинг'),
    (3, 'Мария', 'Сидорова', 'Ивановна', 'Бизнес-администрирование'),
    (4, 'Алексей', 'Алексеев', 'Алексеевич', 'Маркетинг'),
    (5, 'Елена', 'Еленова', 'Еленовна', 'Маркетинг');

INSERT INTO evaluations (evaluation_id, teacher_id, student_id, date, evaluation)
VALUES
    (1, 1, 1, '2024-01-16', 1),
    (2, 2, 2, '2024-01-12', 2),
    (3, 3, 3, '2024-01-13', 3),
    (4, 4, 4, '2024-01-17', 4),
    (5, 5, 5, '2024-01-24', 5);

#task_1
select student_id, student_last_name,
(select teacher_last_name from teachers where student_id = teacher_id) as task_1
from students;

#task_2
select s.student_last_name, s.student_group, t.teacher_last_name, e.evaluation
from students as s
inner join evaluations as e 
on s.student_id = e.student_id
inner join teachers as t
on e.teacher_id = t.teacher_id
where s.student_group = '10503322';

#task_3
select student_group,
(select teacher_last_name from teachers where student_id = teacher_id) as teacher_last_name
from students;

#task_4
select s1.student_last_name, s2.student_last_name
from students as s1
inner join students as s2
on s1.student_group = s2.student_group
and s1.student_id != s2.student_id;

#task_5 
select student_last_name,
(select evaluation from evaluations as e where s.student_id = e.evaluation_id) as task_5
from students as s;


#task_8
select s.student_last_name, e.evaluation
from students as s
inner join evaluations as e on s.student_id = e.student_id
order by s.student_id desc, e.evaluation desc;

#task_10
select
    concat(student_last_name, ' ', student_name, ' ', student_patronymic) as full_name,
    avg(evaluation) as average_score
from students
join evaluations on students.student_id = evaluations.student_id
group by students.student_id;
