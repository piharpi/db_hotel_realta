-- insert dummy data HR
SET IDENTITY_INSERT hr.job_role ON;
Insert into hr.job_role (joro_id,joro_name, joro_modified_date) values 
('1', 'Cleaning Service' ,'1995-01-14'),
('2', 'Manager' ,'1995-01-14'),
('3', 'Acounting' ,'1995-01-14'),
('4', 'Staff' ,'1995-01-14'),
('5', 'IT Support' ,'1995-01-14'),
('6', 'IT Developer' ,'1995-01-14'),
('7', 'Direktur' ,'1995-01-14'),
('8', 'Leader' ,'1995-01-14'),
('9', 'Product Manager' ,'1995-01-14'),
('10', 'Anality Quality' ,'1995-01-14');
SET IDENTITY_INSERT hr.job_role OFF;

SET IDENTITY_INSERT hr.department ON;
Insert into hr.department (dept_id,dept_name, dept_modified_date) values 
('1', 'Departement 1' ,'1995-01-14'),
('2', 'Departement 2' ,'1995-01-14'),
('3', 'Departement 3' ,'1995-01-14'),
('4', 'Departement 4' ,'1995-01-14'),
('5', 'Departement 5' ,'1995-01-14'),
('6', 'Departement 6' ,'1995-01-14'),
('7', 'Departement 7' ,'1995-01-14'),
('8', 'Departement 8' ,'1995-01-14'),
('9', 'Departement 9' ,'1995-01-14'),
('10', 'Departement 10' ,'1995-01-14');
SET IDENTITY_INSERT hr.department OFF;

SET IDENTITY_INSERT hr.employee ON;
Insert into hr.employee (emp_id,emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date, emp_salaried_flag, emp_emp_id, emp_modified_date, emp_joro_id) values 
('1', '1234111' ,'1995-01-14', 'M', 'M', '2000-02-10', '0', '3', '2000-01-14', '2'),
('2', '1234111' ,'1995-02-15', 'S', 'M', '2000-03-11', '1', '1', '2000-01-14', '1'),
('3', '1234111' ,'1995-03-16', 'S', 'F', '2000-04-12', '0', '1', '2000-01-14', '3'),
('4', '1234111' ,'1995-04-17', 'S', 'F', '2000-05-13', '0', '1', '2000-01-14', '2'),
('5', '1234111' ,'1995-05-18', 'M', 'F', '2000-06-14', '1', '1', '2000-01-14', '5'),
('6', '1234111' ,'1995-06-19', 'S', 'M', '2000-07-15', '0', '1', '2000-01-14', '6'),
('7', '1234111' ,'1995-07-20', 'M', 'M', '2000-08-16', '1', '1', '2000-01-14', '4'),
('8', '1234111' ,'1995-08-21', 'M', 'F', '2000-09-17', '1', '1', '2000-01-14', '6'),
('9', '1234111' ,'1995-09-22', 'M', 'F', '2000-10-18', '1', '1', '2000-01-14', '2'),
('10', '1234111' ,'1995-11-23', 'M', 'M', '2000-11-19', '0', '1', '2000-01-14', '1');
SET IDENTITY_INSERT hr.employee OFF;

Insert into hr.employee_pay_history (ephi_emp_id,ephi_rate_change_date, ephi_rate_salary, ephi_pay_frequence, ephi_modified_date) values 
('1', '1995-01-14' , '4000000' , '1200' , '1995-01-14'),
('2', '1995-01-14' , '4500000' , '1300' , '1995-01-14'),
('3', '1995-01-14' , '5000000' , '1400' , '1995-01-14'),
('4', '1995-01-14' , '6000000' , '1500' , '1995-01-14'),
('5', '1995-01-14' , '7000000' , '1600' , '1995-01-14'),
('6', '1995-01-14' , '8000000' , '1700' , '1995-01-14'),
('7', '1995-01-14' , '9000000' , '1800' , '1995-01-14'),
('8', '1995-01-14' , '2000000' , '1900' , '1995-01-14'),
('9', '1995-01-14' , '3000000' , '1100' , '1995-01-14'),
('10', '1995-01-14' , '10000000' , '100' , '1995-01-14');

SET IDENTITY_INSERT hr.shift ON;
Insert into hr.shift (shift_id,shift_name, shift_start_time, shift_end_time) values 
('1', 'shift 1' ,'1995-01-14', '1995-03-14'),
('2', 'shift 2' ,'1995-01-14', '1995-03-14'),
('3', 'shift 3' ,'1995-01-14', '1995-03-14'),
('4', 'shift 4' ,'1995-01-14', '1995-03-14'),
('5', 'shift 5' ,'1995-01-14', '1995-03-14'),
('6', 'shift 6' ,'1995-01-14', '1995-03-14'),
('7', 'shift 7' ,'1995-01-14', '1995-03-14'),
('8', 'shift 8' ,'1995-01-14', '1995-03-14'),
('9', 'shift 9' ,'1995-01-14', '1995-03-14'),
('10', 'shift 10' ,'1995-01-14', '1995-03-14');
SET IDENTITY_INSERT hr.shift OFF;

SET IDENTITY_INSERT hr.employee_department_history ON;
Insert into hr.employee_department_history (edhi_id,edhi_emp_id, edhi_start_date, edhi_end_date, edhi_modified_date, edhi_dept_id, edhi_shift_id) values 
('1', '1', '1995-01-14', '1995-03-14', '1999-03-14', '1', '1' ),
('2', '2', '1995-01-14', '1995-03-14', '1999-03-14', '1', '2' ),
('3', '1', '1995-01-14', '1995-03-14', '1999-03-14', '1', '1' ),
('4', '3', '1995-01-14', '1995-03-14', '1999-03-14', '5', '3' ),
('5', '4', '1995-01-14', '1995-03-14', '1999-03-14', '3', '4' ),
('6', '5', '1995-01-14', '1995-03-14', '1999-03-14', '2', '5' ),
('7', '6', '1995-01-14', '1995-03-14', '1999-03-14', '7', '6' ),
('8', '6', '1995-01-14', '1995-03-14', '1999-03-14', '4', '6' ),
('9', '5', '1995-01-14', '1995-03-14', '1999-03-14', '10', '5' ),
('10', '4','1995-01-14', '1995-03-14', '1999-03-14', '8', '4' );
SET IDENTITY_INSERT hr.employee_department_history OFF;

SET IDENTITY_INSERT HR.work_orders ON;
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('1','1995-01-14', 'OPEN' ,'2');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('2','1995-02-09', 'CLOSED' ,'2');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('3','1995-03-17', 'CANCELLED' ,'2');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('4','1995-04-03', 'CLOSED' ,'3');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('5','1995-07-12', 'OPEN' ,'2');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('6','1995-08-19', 'CANCELLED' ,'5');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('7','1995-09-17', 'CLOSED' ,'4');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('8','1995-11-20', 'OPEN' ,'5');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('9','1995-12-23', 'CANCELLED' ,'5');
Insert into HR.work_orders (woro_id,woro_date, woro_status, woro_user_id) values ('10','1995-12-27','CLOSED' , '4');
SET IDENTITY_INSERT HR.work_orders OFF;

SET IDENTITY_INSERT HR.work_order_detail ON;
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('1', 'work detail 1', 'INPROGRESS', '1995-01-14', '1995-03-14', 'Masih Bekerja', '2', '2', '1');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('2', 'work detail 2', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '3', '1', '2');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('3', 'work detail 3', 'CANCELLED', '1995-01-14', '1995-03-14', 'Ada Kenadala', '4', '1', '5');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('4', 'work detail 4', 'INPROGRESS', '1995-01-14', '1995-03-14', 'Masih Bekerja', '6', '7', '10');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('5', 'work detail 5', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '5', '8', '8');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('6', 'work detail 6', 'CANCELLED', '1995-01-14', '1995-03-14', 'Ada Kenadala', '5', '6', '7');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('7', 'work detail 7', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '10', '4', '1');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('8', 'work detail 8', 'CANCELLED', '1995-01-14', '1995-03-14', 'Ada Kenadala', '10', '1', '2');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('9', 'work detail 9', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '4', '3', '2');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('10', 'work detail 10', 'INPROGRESS', '1995-01-14', '1995-03-14', 'Masih Bekerja', '4', '5', '6');
SET IDENTITY_INSERT HR.work_order_detail OFF;