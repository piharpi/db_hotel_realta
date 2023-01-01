USE tempdb;
GO

DROP DATABASE IF EXISTS Hotel_Realta;
GO

CREATE DATABASE Hotel_Realta;
GO

-- menggunakan db hotel_realta
USE Hotel_Realta;
GO

CREATE SCHEMA Users;
GO

CREATE SCHEMA Master;
GO

CREATE SCHEMA Hotel;
GO 

CREATE SCHEMA HR;
GO

CREATE SCHEMA Booking;
GO

CREATE SCHEMA Resto;

GO

CREATE SCHEMA Payment;
GO

CREATE SCHEMA purchasing;
GO

-- MODULE MASTERS --

CREATE TABLE Master.regions (
  region_code int IDENTITY(1, 1),
  region_name nvarchar(35) UNIQUE NOT NULL,
  CONSTRAINT pk_region_code PRIMARY KEY(region_code)
);

CREATE TABLE Master.country (
  country_id int IDENTITY(1, 1),
  country_name nvarchar(55) UNIQUE NOT NULL,
  country_region_id int,
  CONSTRAINT pk_country_id PRIMARY KEY (country_id),
  CONSTRAINT fk_country_region_id FOREIGN KEY(country_region_id) REFERENCES Master.regions(region_code) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.provinces (
  prov_id int IDENTITY (1, 1),
  prov_name nvarchar(85) NOT NULL,
  prov_country_id int CONSTRAINT pk_prov_id PRIMARY KEY(prov_id),
  CONSTRAINT fk_prov_country_name FOREIGN KEY(prov_country_id) REFERENCES Master.country(country_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.address (
  addr_id int IDENTITY(1, 1),
  addr_line1 nvarchar(255) NOT NULL,
  addr_line2 nvarchar(255),
  addr_postal_code nvarchar(5),
  addr_spatial_location geography,
  addr_prov_id int,
  CONSTRAINT pk_addr_id PRIMARY KEY(addr_id),
  CONSTRAINT fk_addr_prov_id FOREIGN KEY(addr_prov_id) REFERENCES Master.provinces(prov_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.category_group (
  cagro_id int IDENTITY(1, 1),
  cagro_name nvarchar(25) UNIQUE NOT NULL CHECK (cagro_name IN ('1', '2', '3 ', '4', '5', '6', '7')),
  cagro_description nvarchar(255),
  cagro_type nvarchar(25) NOT NULL CHECK (cagro_type IN('category', 'service', 'facility')),
  cagro_icon nvarchar(255),
  cagro_icon_url nvarchar(255),
  CONSTRAINT pk_cagro_id PRIMARY KEY(cagro_id)
);

CREATE TABLE Master.policy (
  poli_id int IDENTITY(1, 1),
  poli_name nvarchar(55) NOT NULL,
  poli_description nvarchar(255),
  CONSTRAINT pk_poli_id PRIMARY KEY(poli_id)
);

CREATE TABLE Master.policy_category_group (
  poca_poli_id int NOT NULL,
  poca_cagro_id int NOT NULL,
  CONSTRAINT fk_poca_poli_id FOREIGN KEY(poca_poli_id) REFERENCES Master.policy(poli_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT fk_poca_cagro_id FOREIGN KEY(poca_cagro_id) REFERENCES Master.category_group(cagro_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.price_item (
  prit_id int IDENTITY(1, 1),
  prit_name nvarchar(55) UNIQUE NOT NULL,
  prit_price money NOT NULL,
  prit_description nvarchar(255),
  prit_type nvarchar(15) NOT NULL CHECK (prit_type IN ('SNACK', 'FACILITY', 'SOFTDRINK', 'FOOD', 'SERVICE')),
  prit_modified_date datetime,
  CONSTRAINT pk_prit_id PRIMARY KEY(prit_id)
);

CREATE TABLE Master.service_task (
  seta_id int IDENTITY(1, 1),
  seta_name nvarchar(85) UNIQUE NOT NULL,
  seta_seq smallint CONSTRAINT pk_set_id PRIMARY KEY(seta_id)
);

CREATE TABLE Master.members (
  memb_name nvarchar(15) NOT NULL,
  memb_description nvarchar(100),
  CONSTRAINT pk_memb_name PRIMARY KEY(memb_name)
);

-- MODULE USERS	--

CREATE TABLE users.users (
    user_id INT IDENTITY(1,1) NOT NULL,
    user_full_name NVARCHAR (55) DEFAULT 'guest' NOT NULL,
    user_type NVARCHAR (15) CHECK(user_type IN('T','C','I')),
    user_company_name NVARCHAR (255),
    user_email NVARCHAR(256),
    user_phone_number NVARCHAR (25) UNIQUE NOT NULL,
    user_modified_date DATETIME,
	CONSTRAINT pk_user_id PRIMARY KEY(user_id)
);

CREATE TABLE users.user_members (
    usme_user_id INT,
    usme_memb_name NVARCHAR (15) CHECK(usme_memb_name IN('Silver','Gold','VIP','Wizard')),
    usme_promote_date DATETIME,
    usme_points SMALLINT,
    usme_type NVARCHAR(15) DEFAULT 'Expired',
	CONSTRAINT pk_usme_user_id PRIMARY KEY(usme_user_id),
	CONSTRAINT fk_usme_user_id FOREIGN KEY(usme_user_id) REFERENCES users.users (user_id)
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	CONSTRAINT fk_usme_memb_name FOREIGN KEY (usme_memb_name) REFERENCES master.members(memb_name)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.roles (
    role_id INT IDENTITY(1,1),
    role_name NVARCHAR (35) NOT NULL,
	CONSTRAINT pk_role_id PRIMARY KEY(role_id)
);

CREATE TABLE users.user_roles (
    usro_user_id INT,
    usro_role_id INT,
	CONSTRAINT pk_usro_user_id PRIMARY KEY(usro_user_id),
	CONSTRAINT fk_usro_user_id FOREIGN KEY (usro_user_id) REFERENCES users.users (user_id) 
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_usro_role_id FOREIGN KEY (usro_role_id) REFERENCES users.roles (role_id) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.user_profiles (
    uspro_id INT IDENTITY(1,1),
    uspro_national_id NVARCHAR (20) NOT NULL,
    uspro_birth_date DATE NOT NULL,
    uspro_job_title NVARCHAR (50),
    uspro_marital_status NCHAR(1) CHECK(uspro_marital_status IN('M','S')),
    uspro_gender NCHAR(1) CHECK(uspro_gender IN('M','F')),
    uspro_addr_id INT,
    uspro_user_id INT,
	CONSTRAINT pk_usro_id PRIMARY KEY(uspro_id),
	CONSTRAINT fk_uspro_user_id FOREIGN KEY (uspro_user_id) REFERENCES users.users (user_id) 
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_uspro_addr_id FOREIGN KEY (uspro_addr_id) REFERENCES master.address (addr_id) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.bonus_points (
    ubpo_id INT IDENTITY(1,1),
    ubpo_user_id INT,
    ubpo_total_points SMALLINT,
    ubpo_bonus_type NCHAR (1),
    ubpo_created_on DATETIME,
	CONSTRAINT pk_ubpo_id PRIMARY KEY(ubpo_id),
	CONSTRAINT fk_ubpo_user_id FOREIGN KEY (ubpo_user_id) REFERENCES users.users (user_id) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.user_password (
    uspa_user_id INT IDENTITY(1,1),
    uspa_passwordHash VARCHAR (128),
    uspa_passwordSalt VARCHAR (10),
	CONSTRAINT pk_uspa_user_id PRIMARY KEY(uspa_user_id),
	CONSTRAINT fk_uspa_user_id FOREIGN KEY (uspa_user_id) REFERENCES users.users (user_id) 
);

--MODULE HOTELS --

-- Create a new table called 'hotels' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.hotels', 'U') IS NOT NULL DROP TABLE Hotel.hotels -- Create the table in the specified schema
CREATE TABLE Hotel.hotels (
  hotel_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_hotel_id PRIMARY KEY,
  -- primary key column
  hotel_name NVARCHAR(85) NOT NULL,
  hotel_description NVARCHAR(500) NULL,
  hotel_rating_star SMALLINT NULL,
  hotel_phonenumber NVARCHAR(25) NOT NULL,
  hotel_modified_date DATETIME NULL,
  -- Primary Key
  hotel_addr_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT fk_hotel_addr_id FOREIGN KEY (hotel_addr_id) REFERENCES Master.address(addr_id)
);

-- Create a new table called 'hotel_reviews' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.hotel_reviews', 'U') IS NOT NULL DROP TABLE Hotel.hotel_reviews -- Create the table in the specified schema
CREATE TABLE Hotel.hotel_reviews (
  hore_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_hore_id PRIMARY KEY,
  -- primary key column
  hore_user_review NVARCHAR(125) NOT NULL,
  hore_rating BIT NOT NULL CHECK(hore_rating IN(1, 2, 3, 4, 5)) DEFAULT 5,
  hore_created_on DATETIME NULL,
  -- FOREIGN KEY
  hore_user_id INT NOT NULL,
  hore_hotel_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT pk_hore_user_id FOREIGN KEY (hore_user_id) REFERENCES Users.users(user_id),
  CONSTRAINT fk_hore_hotel_id FOREIGN KEY (hore_hotel_id) REFERENCES Hotel.hotels(hotel_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE
);

-- Create a new table called 'facilities' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.facilities', 'U') IS NOT NULL DROP TABLE Hotel.facilities -- Create the table in the specified schema
CREATE TABLE Hotel.facilities (
  faci_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_faci_id PRIMARY KEY,
  -- primary key column
  faci_description NVARCHAR(255) NULL,
  faci_max_number INT NULL,
  faci_measure_unit VARCHAR(15) NULL CHECK(faci_measure_unit IN('People', 'Beds')),
  faci_room_number NVARCHAR(6) NOT NULL,
  faci_startdate DATETIME NOT NULL,
  faci_endate DATETIME NOT NULL,
  faci_low_price MONEY NOT NULL,
  faci_high_price MONEY NOT NULL,
  faci_rate_price MONEY NOT NULL,
  faci_discount SMALLMONEY NULL,
  faci_tax_rate SMALLMONEY NULL,
  faci_modified_date DATETIME NULL,
  --FOREIGN KEY
  faci_cagro_id INTEGER NOT NULL,
  faci_hotel_id INT NOT NULL,
  -- UNIQUE ID
  CONSTRAINT uq_faci_room_number UNIQUE (faci_room_number),
  -- Add this later, on production
  CONSTRAINT fk_faci_cagro_id FOREIGN KEY (faci_cagro_id) REFERENCES Master.category_group(cagro_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE,
    CONSTRAINT fk_faci_hotel_id FOREIGN KEY (faci_cagro_id) REFERENCES Hotel.hotels(hotel_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE
);

-- Create a new table called 'facility_price_history' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.facility_price_history', 'U') IS NOT NULL DROP TABLE Hotel.facility_price_history -- Create the table in the specified schema
CREATE TABLE Hotel.facility_price_history (
  faph_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_faph_id PRIMARY KEY,
  -- primary key column
  faph_startdate DATETIME NOT NULL,
  faph_enddate DATETIME NOT NULL,
  faph_low_price MONEY NOT NULL,
  faph_high_price MONEY NOT NULL,
  faph_rate_price MONEY NOT NULL,
  faph_discount SMALLMONEY NOT NULL,
  faph_tax_rate SMALLMONEY NOT NULL,
  faph_modified_date DATETIME,
  -- FOREIGN KEY
  faph_faci_id INT NOT NULL,
  faph_user_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT fk_faph_faci_id FOREIGN KEY (faph_faci_id) REFERENCES Hotel.facilities(faci_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE,
    CONSTRAINT fk_faph_user_id FOREIGN KEY (faph_user_id) REFERENCES Users.users(user_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE
);

-- Create a new table called 'facility_photos' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.facility_photos', 'U') IS NOT NULL DROP TABLE Hotel.facility_photos -- Create the table in the specified schema
CREATE TABLE Hotel.facility_photos (
  fapho_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_fapho_id PRIMARY KEY,
  -- primary key column
  fapho_thumbnail_filename NVARCHAR(50) NULL,
  fapho_photo_filename NVARCHAR(50) NULL,
  fapho_primary BIT NULL CHECK(fapho_primary IN(0, 1)),
  fapho_url NVARCHAR(255) NULL,
  fapho_modified_date DATETIME,
  -- FOREIGN KEY
  fapho_faci_id INT NOT NULL,
  CONSTRAINT pk_fapho_faci_id FOREIGN KEY (fapho_faci_id) REFERENCES Hotel.facilities(faci_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
)

-- MODULE HR --
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
	constraint fk_faci_id foreign key(wode_faci_id) references hotel.facilities(faci_id)-- comment alter
);


-- MODULE BOOKING --
CREATE TABLE Booking.special_offers
(
    spof_id INT IDENTITY(1,1) NOT NULL,
    spof_name NVARCHAR(55) NOT NULL,
    spof_description NVARCHAR(255) NOT NULL,
    spof_type NCHAR(5) NOT NULL CHECK (spof_type in ('T','C','I')),
    spof_discount SMALLMONEY NOT NULL,
    spof_start_date DATETIME NOT NULL,
    spof_end_date DATETIME NOT NULL,
    spof_min_qty INT,
    spof_max_qty INT,
    spof_modified_date DATETIME
    constraint pk_spof_id PRIMARY KEY(spof_id)
)
create table Booking.booking_orders(
	boor_id INT	IDENTITY (1,1),
	boor_order_number nvarchar(20) NOT NULL,
	boor_order_date DATETIME NOT NULL,
	boor_arrival_date DATETIME,
	boor_total_room SMALLINT,
	boor_total_guest SMALLINT,
	boor_discount SMALLMONEY,
	boor_total_tax SMALLMONEY,
	boor_total_ammount MONEY,
	boor_down_payment MONEY,
	boor_pay_type NCHAR(2) NOT NULL check (boor_pay_type in ('CR','C','D ','PG')),
	boor_is_paid NCHAR(2) NOT NULL check (boor_is_paid in ('DP','P','R ')),
	boor_type NVARCHAR(15) NOT NULL check (boor_type in ('T','C','I')),
	boor_cardnumber NVARCHAR(25),
	boor_member_type NVARCHAR(15),
	boor_status NVARCHAR(15) check (boor_status in ('BOOKING','CHECKIN','CHECKOUT','CLEANING','CANCELED')),
	boor_user_id INT,
	boor_hotel_id INT
	CONSTRAINT pk_boor_id PRIMARY KEY (boor_id),
	CONSTRAINT unique_boor_order_number UNIQUE (boor_order_number),
	CONSTRAINT fk_boor_user_id FOREIGN KEY (boor_user_id) REFERENCES Users.users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_boor_hotel_id FOREIGN KEY (boor_hotel_id) REFERENCES Hotel.hotels (hotel_id) ON DELETE CASCADE ON UPDATE CASCADE
	
)

CREATE TABLE Booking.booking_order_detail(
	borde_boor_id INTEGER,
	borde_id Int IDENTITY (1,1) UNIQUE NOT NULL,
	borde_checkin DATETIME NOT NULL,
	borde_checkout DATETIME NOT NULL,
	borde_adults INTEGER,
	borde_kids INTEGER,
	borde_price MONEY,
	borde_extra MONEY,
	borde_discount SMALLMONEY,
	borde_tax SMALLMONEY,
	borde_subtotal MONEY,
	borde_faci_id INTEGER,
	CONSTRAINT pk_borde_id_boor_id PRIMARY KEY (borde_id, borde_boor_id),
	CONSTRAINT fk_border_boor_id FOREIGN KEY(borde_boor_id)
		REFERENCES Booking.booking_orders(boor_id),
	-- 	ON DELETE CASCADE ON UPDATE CASCADE - REMINDER FOR MAKE TRIGGER
	CONSTRAINT fk_borde_faci_id FOREIGN KEY(borde_faci_id) 
		REFERENCES Hotel.facilities(faci_id) 
		ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE Booking.booking_order_detail_extra(
	boex_id Int IDENTITY (1,1),
	boex_price MONEY,
	boex_qty SMALLINT,
	boex_subtotal MONEY,
	boex_measure_unit NVARCHAR (50), check(boex_measure_unit in ('people','unit','kg')),
	boex_borde_id int,
	boex_prit_id int
	CONSTRAINT pk_boex_id PRIMARY KEY (boex_id),
	CONSTRAINT fk_boex_borde_id FOREIGN KEY (boex_borde_id) 
		REFERENCES Booking.booking_order_detail (borde_id) 
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_boex_prit_id FOREIGN KEY (boex_prit_id) 
		REFERENCES Master.price_item(prit_id) 
		ON DELETE CASCADE ON UPDATE CASCADE
)


CREATE TABLE Booking.special_offer_coupons
(
    soco_id INT IDENTITY(1,1),
    soco_borde_id INT,
    soco_spof_id INT,
    CONSTRAINT pk_soco_id PRIMARY KEY(soco_id),
    CONSTRAINT fk_soco_borde_id FOREIGN KEY(soco_borde_id) 
		REFERENCES Booking.booking_order_detail(borde_id) 
		on DELETE CASCADE on UPDATE CASCADE,
    CONSTRAINT fk_soco_spof_id FOREIGN KEY(soco_spof_id) 
		REFERENCES Booking.special_offers(spof_id) 
		on DELETE CASCADE on UPDATE CASCADE
)

create table Booking.user_breakfast
(
    usbr_borde_id INT,
    usbr_modified_date DATETIME,
    usbr_total_vacant SMALLINT NOT NULL,
    CONSTRAINT pk_usbr_borde_id_usbr_modified_date PRIMARY KEY(usbr_borde_id,usbr_modified_date),
    CONSTRAINT fk_usbr_borde_id FOREIGN KEY(usbr_borde_id) 
		REFERENCES Booking.booking_order_detail(borde_id) 
		ON DELETE CASCADE ON UPDATE CASCADE
)

-- MODULE RESTO --

CREATE TABLE resto.resto_menus
(
    reme_faci_id INT,
    reme_id INT IDENTITY(1,1),
    reme_name NVARCHAR(55) NOT NULL,
    reme_description NVARCHAR(255),
    reme_price MONEY NOT NULL,
    reme_status NVARCHAR(15) NOT NULL,
    reme_modified_date DATETIME,
    CONSTRAINT pk_reme_faci_id PRIMARY KEY (reme_id),
    CONSTRAINT reme_faci_id FOREIGN KEY (reme_faci_id) REFERENCES resto.facilities(faci_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE resto.order_menus
(
    orme_id INT IDENTITY,
    orme_order_number NVARCHAR (20) NOT NULL,
    orme_order_date DATETIME NOT NULL,
    orme_total_item SMALLINT,
    orme_total_discount SMALLMONEY,
    orme_total_amount MONEY,
    orme_pay_type NCHAR(2) NOT NULL,
    orme_cardnumber NVARCHAR(25),
    orme_is_paid nchar(2),
    orme_modified_date DATETIME,
    orme_user_id INTEGER,
    CONSTRAINT pk_orme_id PRIMARY KEY (orme_id),
    CONSTRAINT fk_orme_user_id FOREIGN KEY (orme_user_id) REFERENCES resto.users(user_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE resto.order_menu_detail
(
    omde_id INT IDENTITY,
    orme_price MONEY NOT NULL,
    orme_qty SMALLINT NOT NULL,
    orme_subtotal MONEY NOT NULL,
    orme_discount SMALLMONEY,
    omde_orme_id INTEGER,
    omde_reme_id INTEGER,
    CONSTRAINT pk_omme_id PRIMARY KEY (omde_id),
    CONSTRAINT fk_omde_orme_id FOREIGN KEY (omde_orme_id) REFERENCES resto.order_menus(orme_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_omde_reme_id FOREIGN KEY (omde_reme_id) REFERENCES resto.resto_menus(reme_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE resto.resto_menu_photos
(
    remp_id INT IDENTITY,
    remp_thumbnial_filname NVARCHAR (50),
    remp_photo_filename NVARCHAR (50),
    remp_primary BIT,
    remp_url NVARCHAR (255),
    remp_reme_id INT,
    CONSTRAINT pk_remp_id PRIMARY KEY (remp_id),
    CONSTRAINT fk_remp_reme_id FOREIGN KEY (remp_reme_id) REFERENCES resto.resto_menus(reme_id)
);

-- MODULE PAYMENT --

--create tabel Payment.Entity
CREATE TABLE Payment.Entity(
	entity_id INT IDENTITY(1, 1) NOT NULL,
	CONSTRAINT PK_PaymentEntityId PRIMARY KEY (entity_id) 
)

-- create tabel Payment.Bank
CREATE TABLE Payment.Bank(
	bank_entity_id INT NOT NULL,
	bank_code NVARCHAR(10) UNIQUE NOT NULL,
	bank_name NVARCHAR(55) UNIQUE NOT NULL,
	bank_modified_date DATETIME
	CONSTRAINT PK_PaymentBankEntityId PRIMARY KEY(bank_entity_id),
	CONSTRAINT FK_PaymentBankEntityId FOREIGN KEY(bank_entity_id) 
		REFERENCES Payment.Entity (entity_id) 
		ON UPDATE CASCADE 
		ON DELETE CASCADE
)

-- create tabel Payment.PaymentGateway
CREATE TABLE Payment.PaymentGateway(
	paga_entity_id INT NOT NULL,
	paga_code NVARCHAR(10) UNIQUE NOT NULL,
	paga_name NVARCHAR(55) UNIQUE NOT NULL,
	paga_modified_date DATETIME,
	CONSTRAINT PK_PaymentGatewayEntityId PRIMARY KEY(paga_entity_id),
	CONSTRAINT FK_PaymentGatewayEntityId FOREIGN KEY(paga_entity_id)
		REFERENCES Payment.Entity (entity_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)

-- create tabel Payment.UserAccount
CREATE TABLE Payment.UserAccounts(
	usac_entity_id INT NOT NULL,
	usac_user_id INT NOT NULL,
	usac_account_number VARCHAR(25) UNIQUE NOT NULL,
	usac_saldo MONEY,
	usac_type NVARCHAR(15),
	usac_expmonth TINYINT,
	usac_expyear SMALLINT,
	usac_modified_date DATETIME,
	CONSTRAINT CK_PaymentUserAccountsType CHECK (usac_type IN ('debet', 'credit card', 'payment')),
	CONSTRAINT PK_PaymentUserAccountsEntityId PRIMARY KEY(usac_entity_id, usac_user_id),
	CONSTRAINT FK_PaymentUserAccountsEntityBank FOREIGN KEY(usac_entity_id) 
		REFERENCES Payment.Bank (bank_entity_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT FK_PaymentUserAccountsEntityPayment FOREIGN KEY(usac_entity_id)
		REFERENCES Payment.PaymentGateway(paga_entity_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT FK_PaymentUserAccountsUserId FOREIGN KEY(usac_user_id)
		REFERENCES Users.Users (user_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)

-- create table Payment.PaymentTransaction
CREATE TABLE Payment.PaymentTransaction(
	patr_id INT IDENTITY(1,1) PRIMARY KEY,
	patr_trx_number NVARCHAR(55) UNIQUE,
	patr_debet MONEY,
	patr_credit MONEY,
	patr_type NCHAR(3) NOT NULL,
	patr_note NVARCHAR(255),
	patr_modified_date DATETIME,
	patr_order_number NVARCHAR(55),
	patr_source_id INT,
	patr_target_id INT,
	patr_trx_number_ref NVARCHAR(55) UNIQUE,
	patr_user_id INT,
	CONSTRAINT CK_PaymentPaymentTransactionType CHECK (patr_type IN ('TP', 'TRB', 'RPY', 'RF', 'ORM')),
	CONSTRAINT FK_PaymentPaymentTransactionUserId FOREIGN KEY (patr_user_id)
		REFERENCES Users.Users (user_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT FK_PaymentPaymentTransactionSourceId FOREIGN KEY (patr_source_id)
		REFERENCES Payment.Bank(bank_entity_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT FK_PaymentPaymentTransactionTargetId FOREIGN KEY (patr_target_id)
		REFERENCES Payment.Bank(bank_entity_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT FK_PaymentPaymentBookingOrdersId FOREIGN KEY (patr_order_number)
		REFERENCES Booking.Booking_Orders(boor_order_number)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT FK_PaymentPaymentRestoOrderMenus FOREIGN KEY (patr_order_number)
		REFERENCES Resto.OrderMenus(orme_order_number)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)

-- MODULE PURCHASING --

CREATE TABLE purchasing.vendor(
  vendor_id INT IDENTITY(1,1),
  vendor_name NVARCHAR(55) NOT NULL,
  vendor_active BIT DEFAULT 1,
  vendor_priority BIT DEFAULT 0,
  vendor_register_date DATETIME NOT NULL,
  vendor_weburl NVARCHAR(1025),
  vendor_modifier_date DATETIME,

  CONSTRAINT pk_vendor_id PRIMARY KEY (vendor_id),
  CONSTRAINT ck_vendor_priority CHECK (vendor_priority IN (0,1)),
  CONSTRAINT ck_vendor_active CHECK (vendor_active IN (0,1))
);

CREATE TABLE purchasing.stocks(
  stock_id INT IDENTITY(1,1),
  stock_name NVARCHAR(255) NOT NULL,
  stock_description NVARCHAR(255),
  stock_quantity SMALLINT,
  stock_reorder_point SMALLINT DEFAULT 0,
  stock_used SMALLINT DEFAULT 0,
  stock_scrap SMALLINT DEFAULT 0,
  stock_price MONEY DEFAULT 0,
  stock_standar_cost MONEY DEFAULT 0,
  stock_size NVARCHAR(25),
  stock_color NVARCHAR(15),
  stock_modified_date DATETIME,

  CONSTRAINT pk_department_id PRIMARY KEY (stock_id)
);

CREATE TABLE purchasing.stock_photo(
  spho_id INT IDENTITY(1,1),
  spho_thumbnail_filename NVARCHAR(50),
  spho_photo_filename NVARCHAR(50),
  spho_primary BIT DEFAULT 0,
  spho_url NVARCHAR(355),
  spho_stock_id INT,

  CONSTRAINT pk_spho_id PRIMARY KEY (spho_id),
  CONSTRAINT fk_spho_stock_id FOREIGN KEY (spho_stock_id) 
    REFERENCES purchasing.stocks(stock_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT ck_spho_primary CHECK (spho_primary IN (0,1))
);

CREATE TABLE purchasing.purchase_order_header(
    pohe_id INT IDENTITY(1,1) NOT NULL,
    pohe_number NVARCHAR(20),
    pohe_status TINYINT DEFAULT 1,
    pohe_order_date DATETIME,
    pohe_subtotal MONEY,
    pohe_tax MONEY,
    pohe_total_amount AS pohe_subtotal+pohe_tax,
    pohe_refund MONEY DEFAULT NULL,
    pohe_arrival_date DATETIME,
    pohe_pay_type NCHAR(2) NOT NULL,
    pohe_emp_id INT,
    pohe_vendor_id INT,

    CONSTRAINT pk_pohe_id PRIMARY KEY (pohe_id),
    CONSTRAINT uq_pohe_number UNIQUE (pohe_number),
    CONSTRAINT fk_pohe_emp_id FOREIGN KEY (pohe_emp_id) 
      REFERENCES hr.employee(emp_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pohe_vendor_id FOREIGN KEY (pohe_vendor_id) 
      REFERENCES purchasing.vendor(vendor_id) 
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_pohe_pay_type CHECK (pohe_pay_type IN('TR', 'CA')),
    CONSTRAINT ck_pohe_status CHECK (pohe_status IN(1, 2, 3, 4)),
);

CREATE TABLE purchasing.purchase_order_detail (
  pode_pohe_id INT,
  pode_id INT IDENTITY(1,1),
  pode_order_qty SMALLINT NOT NULL,
  pode_price MONEY NOT NULL,
  pode_line_total AS ISNULL(pode_order_qty*pode_price, 0.00),
  pode_received_qty DECIMAL(8,2),
  pode_rejected_qty DECIMAL(8,2),
  pode_stocked_qty AS pode_received_qty - pode_rejected_qty,
  pode_modified_date DATETIME,
  pode_stock_id INT,

  CONSTRAINT pk_pode_id PRIMARY KEY (pode_id),
  CONSTRAINT fk_pode_pohe_id FOREIGN KEY (pode_pohe_id) 
    REFERENCES purchasing.purchase_order_header(pohe_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_pode_stock_id FOREIGN KEY (pode_stock_id) 
    REFERENCES purchasing.stocks(stock_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE purchasing.stock_detail (
  stod_stock_id INT,
  stod_id INT IDENTITY,
  stod_barcode_number NVARCHAR(255),
  stod_status NCHAR(2) DEFAULT 1,
  stod_notes NVARCHAR(1024),
  stod_faci_id INT,
  stod_pohe_id INT,

  CONSTRAINT pk_stod_id PRIMARY KEY (stod_id),
  CONSTRAINT uq_stod_barcode_number UNIQUE (stod_barcode_number),
  CONSTRAINT fk_stod_stock_id FOREIGN KEY (stod_stock_id) 
    REFERENCES purchasing.stocks(stock_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_stod_pohe_id FOREIGN KEY (stod_pohe_id) 
    REFERENCES purchasing.purchase_order_header(pohe_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_stod_faci_id FOREIGN KEY (stod_faci_id) 
    REFERENCES hotel.facilities(faci_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_stod_status CHECK (stod_status IN(1, 2, 3, 4))
);

-- TRIGGER TRIGGER TRIGGER TRIGGER TRIGGER

-- DROP TRIGGER purchasing.tr_purchase_order_detail;
GO

CREATE TRIGGER tr_update_sub_total
ON purchasing.purchase_order_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE purchasing.purchase_order_header
    SET pohe_subtotal = 
      (SELECT SUM(pode_line_total) 
        FROM purchasing.purchase_order_detail 
        WHERE pode_pohe_id = pohe_id)
    WHERE pohe_id IN 
      (SELECT pode_pohe_id FROM inserted) 
    OR pohe_id IN (SELECT pode_pohe_id FROM deleted);
END;
GO

-- TRIGGER STOCKS
-- DROP TRIGGER purchasing.tr_update_stock_scrap;

CREATE TRIGGER tr_update_stock_scrap
ON purchasing.stock_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_scrap = 
    (SELECT COUNT(*)
     FROM purchasing.stock_detail sd
     WHERE sd.stod_status IN (2, 3) AND s.stock_id = sd.stod_stock_id)
  FROM purchasing.stocks s;
END;
GO

-- DROP TRIGGER purchasing.tr_update_stock_used;

CREATE TRIGGER tr_update_stock_used
ON purchasing.stock_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_used = 
    (SELECT COUNT(*)
     FROM purchasing.stock_detail sd
     WHERE sd.stod_status = 4 AND s.stock_id = sd.stod_stock_id)
  FROM purchasing.stocks s;
END;
GO

-- DROP TRIGGER purchasing.tr_update_stock_quantity;

CREATE TRIGGER tr_update_stock_quantity
ON purchasing.purchase_order_header
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_quantity = 
    (SELECT SUM(pod.pode_stocked_qty)
     FROM purchasing.purchase_order_detail pod
     JOIN purchasing.purchase_order_header poh ON poh.pohe_id = pod.pode_pohe_id
     WHERE s.stock_id = pod.pode_stock_id and poh.pohe_status = 4)
  FROM purchasing.stocks s;
END;
GO


