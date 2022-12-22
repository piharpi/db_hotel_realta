-- CREATE DATABASE Hotel_Realta;
-- GO
-- GO;
-- CREATE SCHEMA purchasing;
-- CREATE SCHEMA hr;
-- GO;
-- CREATE SCHEMA hotel;
-- GO;

-- create table hr.employee(
--     emp_id int,
--     CONSTRAINT pk_emp_id PRIMARY KEY (emp_id)
-- )

-- create table hotel.facilities(
--     hofa_faci_id int,
--     CONSTRAINT pk_hofa_faci_id PRIMARY KEY (hofa_faci_id)
-- )

USE Hotel_Realta;

create table purchasing.stocks(
	stock_id int identity (1,1),
	stock_name nvarchar(255) NOT NULL,
	stock_description nvarchar(255),
	stock_quantity smallint not null,
	stock_reorder_point smallint not null,
	stock_used smallint,
	stock_scrap smallint,
	stock_price money not null,
	stock_standar_cost money not null,
	stock_size nvarchar (25),
	stock_color nvarchar (15),
	stock_modified_date datetime,
	constraint pk_department_id primary key (stock_id)
);

create table purchasing.stock_photo(
	spho_id int identity (1,1),
	spho_thumbnail_filename nvarchar (50),
	spho_photo_filename nvarchar (50),
	spho_primary bit DEFAULT 0 CHECK (spho_primary IN (0,1)),
	spho_url nvarchar(355),
	spho_stock_id int,
	constraint pk_spho_id primary key (spho_id),
	constraint fk_spho_stock_id foreign key (spho_stock_id) references purchasing.stocks(stock_id) ON DELETE CASCADE on UPDATE CASCADE
);

create table purchasing.vendor(
	vendor_id int identity (1,1),
	vendor_name nvarchar(55) not null,
	vendor_active bit default 1 CHECK (vendor_active in (0,1)),
	vendor_priority bit default 0 CHECK (vendor_priority in (0,1)),
	vendor_register_date datetime not null,
	vendor_weburl nvarchar(1025),
	vendor_modifier_date datetime,
	constraint pk_vendor_id primary key (vendor_id)
);

CREATE TABLE purchasing.purchase_order_header(
    pohe_id INT IDENTITY(1,1) NOT NULL,
    pohe_number NVARCHAR(20),
    pohe_status TINYINT DEFAULT 1 CHECK (pohe_status IN(1, 2, 3, 4)),
    pohe_order_date DATETIME,
    pohe_subtotal MONEY,
    pohe_tax MONEY,
    pohe_total_amount MONEY,
    pohe_refund MONEY,
    pohe_arrival_date DATETIME,
    pohe_pay_type NCHAR(2) NOT NULL CHECK (pohe_pay_type IN('TR', 'CA')),
    pohe_emp_id INT,
    pohe_vendor_id INT

    CONSTRAINT pk_pohe_id PRIMARY KEY(pohe_id),
    CONSTRAINT fk_pohe_emp_id FOREIGN KEY (pohe_emp_id) REFERENCES hr.employee(emp_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pohe_vendor_id FOREIGN KEY (pohe_vendor_id) REFERENCES purchasing.vendor(vendor_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create TABLE purchasing.stock_detail (
    stod_stock_id int,
    stod_id int identity,
    stod_barcode_number nvarchar (255),
    stod_status nchar(2) default 1,
    stod_notes nvarchar(1024),
    stod_faci_id int,
    stod_pohe_id int,

    CONSTRAINT pk_stod_id primary key (stod_id),
    CONSTRAINT fk_stod_stock_id foreign key (stod_stock_id) references purchasing.stocks(stock_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_stod_pohe_id foreign key (stod_pohe_id) references purchasing.purchase_order_header(pohe_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_stod_faci_id foreign key (stod_faci_id) references hotel.facilities(hofa_faci_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_stod_barcode_number unique (stod_barcode_number)
);

CREATE TABLE purchasing.purchase_order_detail(
    pode_pohe_id INT,
    pode_id int IDENTITY (1,1),
    pode_order_qty smallint not NULL,
    pode_price money not null,
    pode_line_total money not null,
    pode_received_qty decimal(8,2),
    pode_rejected_qty decimal (8,2),
    pode_stocked_qty decimal (9,2),
    pode_modified_date datetime,
    pode_stock_id int,

    CONSTRAINT pk_pode_id PRIMARY KEY (pode_id),
    CONSTRAINT fk_pode_pohe_id FOREIGN KEY (pode_pohe_id) REFERENCES purchasing.purchase_order_header(pohe_id) ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_pode_stock_id FOREIGN KEY (pode_stock_id) REFERENCES purchasing.stocks(stock_id) ON DELETE CASCADE ON UPDATE CASCADE 
);

