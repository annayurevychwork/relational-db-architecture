1. UsersInfo 
INSERT INTO UsersInfo (username, user_password, reg_date, last_login_time) 
VALUES 
('john_doe', 'securePassword123', '2023-08-15', '2023-09-10 14:30:00'), 
('jane_smith', 'passWord!45', '2023-09-01', '2023-09-18 08:45:00');

2. CoursesDetails 
INSERT INTO CoursesDetails (name, course_leader_id, start_on, end_on) 
VALUES 
('Introduction to DevOps', 1, '2023-09-10', '2023-11-15'), 
('Advanced Python Programming', 2, '2023-09-15', '2023-12-20'); 

3. EnrollmentsRecords 
INSERT INTO EnrollmentsRecords (user_info_id, course_details_id, enrolled_on) 
VALUES 
(1, 1, '2023-09-12'), 
(2, 2, '2023-09-16'); 

4. CoursesModules 
INSERT INTO CoursesModules (name, course_details_id, created_on, update_on, updated_by_user) 
VALUES 
('Introduction to CI/CD', 1, '2023-09-12', '2023-09-15 10:00:00', 1), 
('Python Basics', 2, '2023-09-16', '2023-09-18 11:00:00', 2);

5. LearningLessons
INSERT INTO LearningLessons (title, module_id, lesson_content, created_on, updated_on, updated_by_user) 
VALUES 
('What is CI/CD?', 1, 'Content about CI/CD', '2023-09-13', '2023-09-15 09:00:00', 1),
('Introduction to Variables in Python', 2, 'Lesson content on variables in Python', '2023-09-18', '2023-09-20 13:00:00', 2); 

6. HomeworkAssignments 
INSERT INTO HomeworkAssignments (title, module_id, due_on, created_on, updated_on, updated_by_user) 
VALUES 
('CI/CD Pipeline Task', 1, '2023-09-20', '2023-09-13', '2023-09-15 14:00:00', 1), 
('Python Variables Assignment', 2, '2023-09-25', '2023-09-16', '2023-09-18 10:00:00', 2); 

7. AssignmentSubmissions 
INSERT INTO AssignmentSubmissions (user_info_id, homework_assignment_id, submitted_on, submission_content) 
VALUES 
(1, 1, '2023-09-18', 'Completed the CI/CD task.'), 
(2, 2, '2023-09-23', 'Python variables assignment solutions.'); 

8. LearningTasks 
INSERT INTO LearningTasks (title, module_id, due_on, created_on, updated_on, updated_by_user) 
VALUES
('Setup Jenkins Task', 1, '2023-09-22', '2023-09-13', '2023-09-15 12:00:00', 1), 
('Implement Functions in Python', 2, '2023-09-26', '2023-09-16', '2023-09-18 11:00:00', 2); 

9. TasksItems 
INSERT INTO TasksItems (task_id, question, correct_response) 
VALUES 
(1, 'What is Jenkins?', 'An automation server for CI/CD.'), 
(2, 'What is a function in Python?', 'A block of code that performs a specific task.'); 

10. UsersTasksResponses 
INSERT INTO UsersTasksResponses (user_info_id, task_item_id, user_response, responded_on) 
VALUES 
(1, 1, 'Jenkins is a tool for automating tasks in software development.', '2023-09-19'), 
(2, 2, 'A function in Python is used to define reusable blocks of code.', '2023-09-25'); 

11. ProgressTracking 
INSERT INTO ProgressTracking (user_info_id, course_details_id, module_id, last_completed_lesson_id, last_completed_homework_id) 
VALUES 
(1, 1, 1, 1, 1), 
(2, 2, 2, 2, 2); 

12. Notifications 
INSERT INTO Notifications (user_info_id, message, sent_on) 
VALUES 
(1, 'You have a new lesson available: CI/CD Pipeline.', '2023-09-14'), 
(2, 'Dont forget to submit your Python Variables assignment.', '2023-09-20'); 

13. Roles 
INSERT INTO Roles (name) 
VALUES 
('Student'), 
('Instructor'); 

14. UsersRolesAssignments 
INSERT INTO UsersRolesAssignments (user_info_id, role_id) 
VALUES 
(1, 1), 
(2, 2); 

15. ActionAudit INSERT INTO ActionAudit (user_info_id, action_description, action_time) 
VALUES 
(1, 'Logged in to the course platform.', '2023-09-18 09:00:00'), 
(2, 'Updated the lesson content.', '2023-09-20 15:30:00');