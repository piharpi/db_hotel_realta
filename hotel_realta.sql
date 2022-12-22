CREATE DATABASE Hotel_Realta

USE Hotel_Realta

-- create table
create table hr.job_role (
	joro_id int identity(1, 1) not null,
	joro_name nvarchar(55) not null,
	joro_modified_date datetime,
	CONSTRAINT pk_joro_id PRIMARY KEY(joro_id),
	CONSTRAINT uq_joro_name UNIQUE (joro_name)
);

create table hr.department (
	dept_id int identity (1,1) not null,
	dept_name nvarchar(50) not null,
	dept_modified_date datetime,
	constraint pk_dept_id primary key (dept_id)
);

create table hr.employee (
	emp_id int identity(1,1) not null,
	emp_national_id nvarchar(25) not null,
	emp_birth_date datetime not null,
	emp_marital_status nchar(1) not null,
	emp_gender nchar(1) not null,
	emp_hire_date datetime  not null,
	emp_salaried_flag nchar(1)  not null,
	emp_vacation_hours int,
	emp_sickleave_hourse int,
	emp_current_flag int,
	emp_emp_id int,
	emp_photo nvarchar(255),
	emp_modified_date datetime,
	emp_joro_id int not null,
	constraint pk_emp_id primary key (emp_id),
	constraint uq_emp_national_id unique (emp_national_id),
	constraint fk_emp_joro_id foreign key (emp_joro_id) references hr.job_role(joro_id),
	constraint fk_emp_id foreign key (emp_emp_id) references hr.employee(emp_id)
);

create table hr.employee_pay_history (
	ephi_emp_id int not null,
	ephi_rate_change_date datetime not null,
	ephi_rate_salary money,
	ephi_pay_frequence int,
	ephi_modified_date datetime,
	constraint pk_ephi_emp_id_ephi_rate_change_date primary key(ephi_emp_id, ephi_rate_change_date),
	constraint fk_ephi_emp_id foreign key(ephi_emp_id) references hr.employee(emp_id)
);

create table hr.shift(
	shift_id int identity(1,1),
	shift_name nvarchar(25) not null,
	shift_start_time datetime not null,
	shift_end_time datetime not null,
	constraint pk_shift_id primary key(shift_id),
	constraint uq_shift_name unique (shift_name),
	constraint uq_shift_start_time unique (shift_start_time),
	constraint uq_shift_end_time unique (shift_end_time)
);

create table hr.employee_department_history (
	edhi_id int identity(1,1) not null,
	edhi_emp_id int not null,
	edhi_start_date datetime,
	edhi_end_date datetime,
	edhi_modified_date datetime,
	edhi_dept_id int not null,
	edhi_shift_id int not null,
	constraint pk_edhi_id_edhi_emp_id primary key (edhi_id, edhi_emp_id),
	constraint fk_edhi_emp_id foreign key(edhi_emp_id) references hr.employee(emp_id),
	constraint fk_shift_id foreign key (edhi_shift_id) references hr.shift(shift_id),
	constraint fk_edhi_dept_id foreign key (edhi_dept_id) references hr.department(dept_id)
);
-- this table can't create after users.users
create table hr.work_orders (
	woro_id int identity(1,1),
	woro_date datetime not null,
	woro_status nvarchar(15), 
	woro_user_id int,
	constraint pk_woro_id primary key(woro_id),
	constraint fk_woro_user_id foreign key(woro_user_id) references users.users(user_id) -- comment alter
);

-- this table can't create after hotel.facilites, master.service_task, and hr.work_orders
create table hr.work_order_detail (
	wode_id int identity(1,1),
	wode_task_menu nvarchar(255),
	wode_status nvarchar(15),
	wode_start_date datetime,
	wode_end_date datetime,
	wode_notes nvarchar(255),
	wode_emp_id int,
	wode_seta_id int,
	wode_faci_id int,
	wode_woro_id int,
	constraint pk_wode_id primary key(wode_id),
	constraint fk_woro_wode_id foreign key(wode_woro_id) references hr.work_orders(woro_id),
	constraint fk_wode_emp_id foreign key(wode_emp_id) references hr.employee(emp_id), -- comment alter
	constraint fk_wode_seta_id foreign key(wode_seta_id) references master.service_task(seta_id), -- comment alter
	constraint fk_faci_id foreign key(wode_faci_id) references hotel.facilites(faci_id)-- comment alter
);

-- use this if you want create table without relation first and comment alter
-- alter table hr.work_order_detail add constraint fk_wode_emp_id foreign key(wode_emp_id) references hr.employee(emp_id);
-- alter table hr.work_order_detail add constraint fk_wode_seta_id foreign key(wode_seta_id) references master.service_task(seta_id);
-- alter table hr.work_order_detail add foreign key(wode_faci_id) references hotel.facilites(faci_id);

-- insert dummy data
--SET IDENTITY_INSERT hr.regions ON;
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('1','1995-01-14', '2');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('2','1995-02-09', '2');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('3','1995-03-17', '2');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('4','1995-04-03', '3');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('5','1995-07-12', '2');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('6','1995-08-19', '5');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('7','1995-09-17', '4');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('8','1995-11-20', '5');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('9','1995-12-23', '5');
--Insert into HR.work_orders (woro_id,woro_date, woro_user_id) values ('10','1995-12-27', '4');
--SET IDENTITY_INSERT hr.regions OFF;

--SET IDENTITY_INSERT hr.regions ON;
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('1', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('2', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('3', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('4', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('5', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('6', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('7', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('8', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('9', '', '', '', '', '', '', '', '', '');
--Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id) values ('10', '', '', '', '', '', '', '', '', '');
--SET IDENTITY_INSERT hr.regions OFF;

