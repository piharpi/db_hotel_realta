-- CREATE DATABASE Hotel_Realta;
-- GO
-- GO;
-- CREATE SCHEMA purchasing;
-- CREATE SCHEMA hr;
-- CREATE SCHEMA hotel;
-- GO;

drop table purchasing.vendor, 
           purchasing.stock_detail, 
           purchasing.purchase_order_detail, 
           purchasing.purchase_order_header, 
           purchasing.stock_photo, 
           purchasing.stocks;

-- create table hr.employee(
--     emp_id int,
--     CONSTRAINT pk_emp_id PRIMARY KEY (emp_id)
-- )

-- create table hotel.facilities(
--     faci_id int,
--     CONSTRAINT pk_faci_id PRIMARY KEY (faci_id)
-- )

-- alter table purchasing.stock_detail drop CONSTRAINT fk_stod_faci_id;
-- alter table hotel.facilities drop CONSTRAINT pk_hofa_faci_id;
-- alter table purchasing.stock_detail add CONSTRAINT fk_stod_faci_id FOREIGN KEY (stod_faci_id) 
--     REFERENCES hotel.facilities(faci_id) 
--     ON DELETE CASCADE ON UPDATE CASCADE;


-- USE Hotel_Realta;

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
  stock_quantity SMALLINT DEFAULT 0,
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
    pohe_refund MONEY,
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
ON purchasing.purchase_order_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_quantity = 
    (SELECT SUM(pod.pode_stocked_qty)
     FROM purchasing.purchase_order_detail pod
     WHERE s.stock_id = pod.pode_stock_id)
  FROM purchasing.stocks s;
END;
GO


--== TESTER

-- DROP TABLE purchasing.detail;
-- DROP TABLE purchasing.header;

-- CREATE TABLE purchasing.header(
--     ph_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
--     ph_number NVARCHAR(20),
--     ph_status TINYINT DEFAULT 1 CHECK (ph_status IN(1, 2, 3, 4)),
--     ph_order_date DATETIME,
--     ph_subtotal MONEY,
--     ph_tax MONEY,
--     ph_total_amount AS ph_subtotal+ph_tax,
--     ph_refund MONEY,
--     ph_arrival_date DATETIME,
--     ph_pay_type NCHAR(2) NOT NULL CHECK (ph_pay_type IN('TR', 'CA'))
-- );

-- CREATE TABLE purchasing.detail(
--     pd_ph_id INT FOREIGN KEY (pd_ph_id) REFERENCES purchasing.header(ph_id),
--     pd_id int IDENTITY (1,1) PRIMARY KEY,
--     pd_order_qty smallint not NULL,
--     pd_price money not null,
--     pd_line_total AS ISNULL(pd_order_qty*pd_price, 0.00),
--     pd_received_qty decimal(8,2),
--     pd_rejected_qty decimal (8,2),
--     pd_stocked_qty as pd_received_qty - pd_rejected_qty,
--     pd_modified_date datetime
-- );

-- GO
-- DROP TRIGGER iDetail;
-- DROP TRIGGER uDetail;
-- GO

-- GO
-- CREATE TRIGGER iDetail
-- ON purchasing.detail
-- AFTER INSERT
-- AS
-- BEGIN
--   UPDATE purchasing.header
--   SET ph_subtotal = (SELECT SUM(pd_line_total) FROM purchasing.detail WHERE pd_ph_id = inserted.pd_ph_id)
--   FROM inserted
--   WHERE purchasing.header.ph_id = inserted.pd_ph_id;
-- END;

-- GO

-- CREATE TRIGGER uDetail
-- ON purchasing.detail
-- AFTER UPDATE
-- AS
-- BEGIN
--   UPDATE purchasing.header
--   SET ph_subtotal = (SELECT SUM(pd_line_total) FROM purchasing.detail WHERE pd_ph_id = inserted.pd_ph_id)
--   FROM inserted
--   WHERE purchasing.header.ph_id = inserted.pd_ph_id;
-- END;

-- GO

-- -- DUMMY DATA

-- INSERT INTO purchasing.header (ph_number, ph_order_date, ph_tax, ph_pay_type)
-- VALUES 
-- ('PO00001', '2021-01-01', 10, 'TR'),
-- ('PO00002', '2021-02-01', 20, 'CA'),
-- ('PO00003', '2021-03-01', 30, 'TR'),
-- ('PO00004', '2021-04-01', 40, 'CA'),
-- ('PO00005', '2021-05-01', 50, 'TR');


-- INSERT INTO purchasing.detail (pd_ph_id, pd_order_qty, pd_price, pd_received_qty, pd_rejected_qty, pd_modified_date)
-- VALUES 
-- (1, 10, 10, 8, 2, '2021-01-01'),
-- (2, 20, 20, 15, 5, '2021-02-01'),
-- (3, 30, 30, 25, 5, '2021-03-01'),
-- (4, 40, 40, 35, 5, '2021-04-01'),
-- (5, 50, 50, 45, 5, '2021-05-01');


-- UPDATE purchasing.detail
-- SET pd_order_qty = 30
-- WHERE pd_id = 1;

-- select ph_id, ph_subtotal, ph_tax, ph_total_amount, pd_id, pd_ph_id, pd_order_qty, pd_price, pd_line_total, pd_received_qty, pd_rejected_qty, pd_stocked_qty from purchasing.header h
-- join purchasing.detail d on d.pd_ph_id = h.ph_id;
