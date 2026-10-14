1. CREATE TABLE UsersInfo 
(
id serial PRIMARY KEY,
username VARCHAR(255) NOT NULL, 
user_password VARCHAR(255) NOT NULL, 
reg_date DATE, 
last_login_time TIMESTAMP,
is_deleted BOOLEAN DEFAULT FALSE
);

2. CREATE TABLE CoursesDetails 
( 
id serial PRIMARY KEY,
name VARCHAR(255) NOT NULL, 
course_leader_id INT REFERENCES UsersInfo(id), 
start_on DATE,
end_on DATE
);

3. CREATE TABLE EnrollmentsRecords
( 
id serial PRIMARY KEY, 
user_info_id INT REFERENCES UsersInfo(id),
course_details_id INT REFERENCES CoursesDetails(id),
enrolled_on DATE
);

4. CREATE TABLE CoursesModules 
( 
id serial PRIMARY KEY,
name VARCHAR(255) NOT NULL, 
course_details_id INT REFERENCES CoursesDetails(id), 
created_on DATE,
update_on TIMESTAMP,
updated_by_user INT REFERENCES UsersInfo(id)
);

5. CREATE TABLE LearningLessons 
( 
id serial PRIMARY KEY,
title VARCHAR(255) NOT NULL, 
module_id INT REFERENCES CoursesModules(id), 
lesson_content TEXT,
created_on DATE, 
updated_on TIMESTAMP,
updated_by_user INT REFERENCES UsersInfo(id)
);

6. CREATE TABLE HomeworkAssignments 
( 
id serial PRIMARY KEY,
title VARCHAR(255) NOT NULL, 
module_id INT REFERENCES CoursesModules(id), 
due_on DATE,
created_on DATE, 
updated_on TIMESTAMP,
updated_by_user INT REFERENCES UsersInfo(id)
);

7. CREATE TABLE AssignmentSubmissions 
(
id serial PRIMARY KEY, 
user_info_id INT REFERENCES UsersInfo(id),
homework_assignment_id INT REFERENCES HomeworkAssignments(id), 
submitted_on DATE,
submission_content TEXT
);

8. CREATE TABLE LearningTasks 
( 
id serial PRIMARY KEY,
title VARCHAR(255) NOT NULL,
module_id INT REFERENCES CoursesModules(id), 
due_on DATE,
created_on DATE, 
updated_on TIMESTAMP,
updated_by_user INT REFERENCES UsersInfo(id)
);

9. CREATE TABLE TasksItems 
(
id serial PRIMARY KEY,
task_id INT REFERENCES LearningTasks(id), 
question TEXT NOT NULL, 
correct_response TEXT
);

10. CREATE TABLE UsersTasksResponses 
( 
id serial PRIMARY KEY,
user_info_id INT REFERENCES UsersInfo(id),
task_item_id INT REFERENCES TasksItems(id), 
user_response TEXT,
responded_on DATE
);

11. CREATE TABLE ProgressTracking 
( 
id serial PRIMARY KEY,
user_info_id INT REFERENCES UsersInfo(id), 
course_details_id INT REFERENCES CoursesDetails(id), 
module_id INT REFERENCES CoursesModules(id),
last_completed_lesson_id INT REFERENCES LearningLessons(id), 
last_completed_homework_id INT REFERENCES HomeworkAssignments(id)
);

12. CREATE TABLE Notifications 
( 
id serial PRIMARY KEY, 
user_info_id INT REFERENCES UsersInfo(id), 
message TEXT NOT NULL, 
sent_on DATE
);

13. CREATE TABLE Roles 
( 
id serial PRIMARY KEY,
name VARCHAR(255) NOT NULL
);

14. CREATE TABLE UsersRolesAssignments
(
user_info_id INT REFERENCES UsersInfo(id),
role_id INT REFERENCES Roles(id)
);

15. CREATE TABLE ActionAudit 
( 
id serial PRIMARY KEY,
user_info_id INT REFERENCES UsersInfo(id), 
action_description TEXT NOT NULL, 
action_time TIMESTAMP
);