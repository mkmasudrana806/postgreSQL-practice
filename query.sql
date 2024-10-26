-- --------------- create database "university_db" ------------------
create database university_db;

use university_db;

-- ------------- table creation -------------------
-- create "students" table
create table students (
    student_id serial primary key,
    student_name varchar(100),
    age integer,
    email varchar(255),
    frontend_mark integer,
    backend_mark integer,
    status varchar(50)
);

-- create "courses" table
create table courses (
    course_id serial primary key,
    course_name varchar(100),
    credits integer
);

-- create "enrollment" table
create table enrollment (
    enrollment_id serial primary key,
    student_id integer references students(student_id),
    course_id integer references courses(course_id)
);

-- -------------- data insertion -------------
-- insert sample data into "students" table
insert into students (student_id, student_name, age, email, frontend_mark, backend_mark, status)
values
    (1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    (2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    (3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    (4, 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    (5, 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    (6, 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- insert sample data into "courses" table
insert into courses (course_id, course_name, credits)
values
    (1, 'Next.js', 3),
    (2, 'React.js', 4),
    (3, 'Databases', 3),
    (4, 'Prisma', 3);

-- insert sample data into "enrollment" table
insert into enrollment (enrollment_id, student_id, course_id)
values
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 2);

-- ---------------- queries ----------------
-- query 1: insert a new student record
insert into students (student_name, age, email, frontend_mark, backend_mark, status)
values ('Md Masud Rana', 23, 'mkmasudrana806@gmail.com', 90, 90, NULL);

-- query 2: retrieve the names of all students enrolled in the course titled 'Next.js'
select s.student_name
from students s
join enrollment e on s.student_id = e.student_id
join courses c on e.course_id = c.course_id
where c.course_name = 'Next.js';

-- query 3: update the status of the student with the highest total marks
update students
set status = 'Awarded'
where student_id = (
    select student_id
    from students
    order by (frontend_mark + backend_mark) desc
    limit 1
);
 


-- query 4: delete all courses with no students enrolled
delete from courses
where course_id not in (select course_id from enrollment);

-- query 5: retrieve names of students with a limit of 2, starting from the 3rd student
select student_name
from students
order by student_id
limit 2 offset 2;

-- query 6: retrieve course names and number of students enrolled in each course
select c.course_name, count(e.student_id) as students_enrolled
from courses c
left join enrollment e on c.course_id = e.course_id
group by c.course_name;

-- query 7: calculate and display the average age of all students
select avg(age) as average_age
from students;

-- query 8: retrieve names of students whose email addresses contain 'example.com'
select student_name
from students
where email like '%example.com%';