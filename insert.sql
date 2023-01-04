-- insert dummy data HR
insert into hr.job_role values 
	('Resepsionis', GETDATE()),
	('Porter', GETDATE()),
	('Concierge', GETDATE()),
	('Room Service', GETDATE()),
	('Waiter', GETDATE()),
	('Staff Dapur', GETDATE()),
	('Housekeeper', GETDATE()),
	('Room Division Manager', GETDATE()),
	('Maintenance Staff', GETDATE()),
	('Hotel Manager', GETDATE()),
	('Purchasing', GETDATE()),
	('Sales & Marketing', GETDATE()),
	('Event Planner', GETDATE()),
	('Akuntan', GETDATE())
;

insert into hr.employee (emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date,
	emp_salaried_flag, emp_joro_id) values
	('a123123123456456456789789', '2001-01-01', 'S', 'M', GETDATE(), '1', 1),
	('b456456456123123123789789', '2002-02-01', 'M', 'F', GETDATE(), '0', 2),
	('c231231231339339339013013', '2003-03-01', 'M', 'M', GETDATE(), '1', 3),
	('d524524524621621621832832', '1999-04-01', 'S', 'F', GETDATE(), '0', 4),
	('e122122122322322322494944', '1997-05-01', 'S', 'M', GETDATE(), '1', 5),
	('f090285082940243284423853', '1999-06-01', 'M', 'F', GETDATE(), '0', 6),
	('g122932483892095343534255', '1998-07-01', 'M', 'M', GETDATE(), '1', 7),
	('h214392573294812743928523', '2002-08-01', 'S', 'F', GETDATE(), '0', 8),
	('i217473298498378988932754', '1999-09-01', 'S', 'M', GETDATE(), '1', 9),
	('j219483945782893873249573', '2001-10-01', 'M', 'F', GETDATE(), '0', 10)
;

insert into hr.shift values
	('Shift 1', '08:00:00', '16:00:00'),
	('Shift 2', '16:00:00', '00:00:00'),
	('Shift 3', '00:00:00', '08:00:00')
;

insert into hr.department values 
	('Front Office', GETDATE()), 
	('Security', GETDATE()), 
	('Marketing', GETDATE()), 
	('Accounting', GETDATE()), 
	('Food and Beverage', GETDATE()), 
	('Housekeeping', GETDATE()), 
	('Purchasing', GETDATE()), 
	('Engineering', GETDATE()), 
	('Personalia (HRD)', GETDATE())
;

insert into hr.employee_department_history(edhi_emp_id, edhi_dept_id, edhi_shift_id) values 
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3),
	(4, 4, 1),
	(5, 5, 2),
	(6, 6, 3),
	(7, 7, 1),
	(8, 8, 2),
	(9, 9, 3),
	(10, 2, 1)
;

insert into hr.employee_pay_history (ephi_emp_id, ephi_rate_change_date) values
	(1, GETDATE()),
	(2, GETDATE()),
	(3, GETDATE()),
	(4, GETDATE()),
	(5, GETDATE()),
	(6, GETDATE()),
	(7, GETDATE()),
	(8, GETDATE()),
	(9, GETDATE()),
	(10, GETDATE())
;

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