1. Збереження відповіді на завдання:
CREATE OR REPLACE FUNCTION save_task_response
(
user_info_id INT, 
task_item_id INT, 
user_response TEXT, 
responded_on DATE
) 
RETURNS VOID AS $$
BEGIN
INSERT INTO UsersTasksResponses (user_info_id, task_item_id, user_response, responded_on) 
VALUES (user_info_id, task_item_id, user_response, responded_on);
END;
$$LANGUAGE plpgsql;

SELECT save_task_response(1, 1, 'Рішення', '2024-10-08');

2. Зміна користувацьких ролей:
CREATE OR REPLACE FUNCTION change_user_role
(
    p_user_info_id INT,
    p_new_role_id INT
) 
RETURNS VOID AS $$ 
BEGIN
    DELETE FROM UsersRolesAssignments
    WHERE user_info_id = p_user_info_id;

    INSERT INTO UsersRolesAssignments (user_info_id, role_id) 
    VALUES (p_user_info_id, p_new_role_id);
END;
$$ LANGUAGE plpgsql;

SELECT change_user_role(1, 2);

3. Вивід списку користувачів, записаних на курс:
CREATE OR REPLACE FUNCTION get_users_enrolled_in_course(course_id INT) 
RETURNS TABLE (user_info_id INT, username VARCHAR(255)) AS $$
BEGIN
RETURN QUERY 
SELECT U. Id AS user_info_id, U.username 
FROM UsersInfo U
JOIN EnrollmentsRecords E ON U.id = E.user_info_id 
WHERE E.course_details_id = course_id;
END;
$$LANGUAGE plpgsql;

SELECT * FROM get_users_enrolled_in_course(1);

4. Отримання часу останнього входу користувача:
CREATE OR REPLACE FUNCTION get_last_login(user_id INT) 
RETURNS TIMESTAMP AS $$
DECLARE
    last_login TIMESTAMP;
BEGIN
    SELECT last_login_time INTO last_login
    FROM UsersInfo
    WHERE id = user_id; 
    RETURN last_login; 
END;
$$ LANGUAGE plpgsql;

SELECT get_last_login(1);

5. Перевірка прав доступу користувача до модуля:
CREATE OR REPLACE FUNCTION check_module_access
(
    user_id INT, 
    module_id_param INT
) 
RETURNS BOOLEAN AS $$
DECLARE
    user_role_id INT; 
BEGIN
    SELECT role_id INTO user_role_id 
    FROM UsersRolesAssignments
    WHERE user_info_id = user_id;

    IF user_role_id = 1 THEN 
        RETURN TRUE;
    ELSE
        RETURN EXISTS 
        ( 
            SELECT 1
            FROM ProgressTracking 
            WHERE user_info_id = user_id  
            AND module_id = module_id_param  
        ); 
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT check_module_access(1, 10);

6. Видалення користувача і усіх його даних:
CREATE OR REPLACE FUNCTION delete_user_and_related_data(user_id INT) 
RETURNS VOID AS $$
BEGIN
    UPDATE UsersInfo 
    SET is_deleted = TRUE 
    WHERE id = user_id;

    DELETE FROM EnrollmentsRecords WHERE user_info_id = user_id;
    DELETE FROM UsersRolesAssignments WHERE user_info_id = user_id;
    DELETE FROM ProgressTracking WHERE user_info_id = user_id;
    DELETE FROM Notifications WHERE user_info_id = user_id;
    DELETE FROM UsersTasksResponses WHERE user_info_id = user_id;
END;
$$ LANGUAGE plpgsql;

SELECT delete_user_and_related_data(3);

7. Підрахунок завдань у модулі:
CREATE OR REPLACE FUNCTION count_assignments_in_module(module_id_param INT) 
RETURNS INT AS $$ 
DECLARE
    assignment_count INT; 
BEGIN
    SELECT COUNT(*) INTO assignment_count 
    FROM HomeworkAssignments
    WHERE module_id = module_id_param; 
    RETURN assignment_count; 
END; 
$$ LANGUAGE plpgsql;

SELECT count_assignments_in_module(2);

8. Отримання списку завдань до модуля:
CREATE OR REPLACE FUNCTION get_tasks_for_module(module_id_param INT) 
RETURNS TABLE (task_id INT, task_title VARCHAR(255)) AS $$
BEGIN
    RETURN QUERY 
    SELECT T.id AS task_id, T.title AS task_title
    FROM HomeworkAssignments T
    WHERE T.module_id = module_id_param;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_tasks_for_module(1);

9. Функція для отримання останніх 5 дій користувача:
CREATE OR REPLACE FUNCTION get_last_user_actions(user_id INT) 
RETURNS TABLE (action_id INT, action_description TEXT, action_time TIMESTAMP) AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        A.id AS action_id, 
        A.action_description AS action_description, 
        A.action_time AS action_time 
    FROM ActionAudit A
    WHERE A.user_info_id = user_id 
    ORDER BY A.action_time DESC 
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_last_user_actions(1);

10. Функція для отримання всіх завдань, що прострочені для користувача:
CREATE OR REPLACE FUNCTION get_overdue_tasks_for_user(user_id INT) 
RETURNS TABLE (task_id INT, task_title VARCHAR(255), due_date DATE) AS $$
BEGIN
    RETURN QUERY 
    SELECT H.id AS task_id, H.title AS task_title, H.due_on AS due_date
    FROM HomeworkAssignments H
    WHERE H.due_on < NOW()
    AND H.id IN (
        SELECT homework_assignment_id 
        FROM AssignmentSubmissions 
        WHERE user_info_id = user_id
    );
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_overdue_tasks_for_user(1);