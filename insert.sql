-- File insert 

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

-- INSERT PURCHASING MODULE

INSERT INTO purchasing.vendor (vendor_name, vendor_active, vendor_priority, vendor_register_date, vendor_weburl, vendor_modifier_date)
VALUES ('Global Equipment Co.', 1, 0, '2022-01-01', 'www.globalequipment.com', '2022-01-02'),
       ('Sustainable Solutions Inc.', 1, 1, '2022-02-01', 'www.sustainablesolutions.com', '2022-02-02'),
       ('Quality Parts LLC', 1, 0, '2022-03-01', 'www.qualityparts.com', '2022-03-02'),
       ('Innovative Technologies Corp.', 0, 1, '2022-04-01', 'www.innovativetechnologies.com', '2022-04-02'),
       ('Dynamic Enterprises Inc.', 1, 0, '2022-05-01', 'www.dynamicenterprises.com', '2022-05-02'),
       ('Elite Supplies Co.', 1, 1, '2022-06-01', 'www.elitesupplies.com', '2022-06-02'),
       ('Superior Products LLC', 0, 0, '2022-07-01', 'www.superiorproducts.com', '2022-07-02'),
       ('Advanced Materials Inc.', 1, 1, '2022-08-01', 'www.advancedmaterials.com', '2022-08-02'),
       ('Bright Ideas Inc.', 1, 0, '2022-09-01', 'www.brightideas.com', '2022-09-02'),
       ('Progressive Solutions Inc.', 0, 1, '2022-10-01', 'www.progressivesolutions.com', '2022-10-02');

INSERT INTO purchasing.purchase_order_header (pohe_number, pohe_status, pohe_order_date, pohe_tax, pohe_refund, pohe_arrival_date, pohe_pay_type, pohe_emp_id, pohe_vendor_id)
VALUES
  ('PO-001', 1, GETDATE(), 150000, 0, GETDATE() + 10, 'CA', 1, 1),
  ('PO-002', 1, GETDATE(), 300000, 0, GETDATE() + 15, 'CA', 1, 2),
  ('PO-003', 1, GETDATE(), 450000, 0, GETDATE() + 20, 'TR', 1, 3),
  ('PO-004', 1, GETDATE(), 600000, 0, GETDATE() + 25, 'TR', 1, 4),
  ('PO-005', 1, GETDATE(), 750000, 0, GETDATE() + 30, 'CA', 1, 5);

INSERT INTO purchasing.stocks (stock_name, stock_description, stock_size, stock_color, stock_modified_date)
VALUES
  ('Sprei Hotel', 'Sprei dengan bahan yang nyaman dan tahan lama', 'King', 'Putih', GETDATE()),
  ('Bantal Hotel', 'Bantal dengan bahan yang nyaman dan tahan lama', 'Standard', 'Putih', GETDATE()),
  ('Handuk Hotel', 'Handuk dengan bahan yang nyaman dan tahan lama', 'Standard', 'Putih', GETDATE()),
  ('Gorden Hotel', 'Gorden dengan bahan yang tahan lama dan mudah dicuci', 'Standard', 'Putih', GETDATE()),
  ('Gelas Hotel', 'Gelas dengan bahan yang tahan lama dan mudah dicuci', 'Standard', 'Transparan', GETDATE());

INSERT INTO purchasing.stock_detail (stod_stock_id, stod_barcode_number, stod_status, stod_notes, stod_faci_id, stod_pohe_id)
VALUES
  (1, 'Barcode Sprei 1', 2, 'Sprei di kamar 101', 1, 1),
  (1, 'Barcode Sprei 2', 4, 'Sprei di kamar 102', 1, 1),
  (1, 'Barcode Sprei 3', 4, 'Sprei di kamar 103', 1, 1),
  (1, 'Barcode Sprei 4', 1, 'Sprei di kamar 104', 1, 1),
  (1, 'Barcode Sprei 5', 1, 'Sprei di kamar 105', 1, 1),
  (2, 'Barcode Bantal 1', 3, 'Bantal di kamar 106', 2, 2),
  (2, 'Barcode Bantal 2', 1, 'Bantal di kamar 107', 2, 2),
  (2, 'Barcode Bantal 3', 1, 'Bantal di kamar 108', 2, 2),
  (2, 'Barcode Bantal 4', 1, 'Bantal di kamar 109', 2, 2),
  (2, 'Barcode Bantal 5', 1, 'Bantal di kamar 110', 2, 2),
  (3, 'Barcode Handuk 6', 1, 'Handuk di kamar 111', 3, 3),
  (3, 'Barcode Handuk 7', 1, 'Handuk di kamar 112', 3, 3),
  (3, 'Barcode Handuk 8', 1, 'Handuk di kamar 113', 3, 3),
  (3, 'Barcode Handuk 9', 1, 'Handuk di kamar 114', 3, 3),
  (3, 'Barcode Handuk 10', 1, 'Handuk di kamar 115', 3, 3),
  (4, 'Barcode Gorden 1', 1, 'Gorden di kamar 116', 4, 4),
  (4, 'Barcode Gorden 2', 1, 'Gorden di kamar 117', 4, 4),
  (4, 'Barcode Gorden 3', 1, 'Gorden di kamar 118', 4, 4),
  (4, 'Barcode Gorden 4', 1, 'Gorden di kamar 119', 4, 4),
  (4, 'Barcode Gorden 5', 1, 'Gorden di kamar 120', 4, 4),
  (5, 'Barcode Gelas 1', 1, 'Gelas di kamar 121', 5, 5),
  (5, 'Barcode Gelas 2', 1, 'Gelas di kamar 122', 5, 5),
  (5, 'Barcode Gelas 3', 1, 'Gelas di kamar 123', 5, 5),
  (5, 'Barcode Gelas 4', 1, 'Gelas di kamar 124', 5, 5),
  (5, 'Barcode Gelas 5', 1, 'Gelas di kamar 125', 5, 5);

INSERT INTO purchasing.stock_photo (spho_thumbnail_filename, spho_photo_filename, spho_primary, spho_url, spho_stock_id)
VALUES
  ('thumbnail-1.jpg', 'photo-1.jpg', 1, 'https://stock-photos.com/thumbnail-1.jpg', 1),
  ('thumbnail-2.jpg', 'photo-2.jpg', 0, 'https://stock-photos.com/thumbnail-2.jpg', 2),
  ('thumbnail-3.jpg', 'photo-3.jpg', 0, 'https://stock-photos.com/thumbnail-3.jpg', 3),
  ('thumbnail-4.jpg', 'photo-4.jpg', 1, 'https://stock-photos.com/thumbnail-4.jpg', 4),
  ('thumbnail-5.jpg', 'photo-5.jpg', 0, 'https://stock-photos.com/thumbnail-5.jpg', 5);

INSERT INTO purchasing.purchase_order_detail (pode_pohe_id, pode_order_qty, pode_price, pode_received_qty, pode_rejected_qty, pode_modified_date, pode_stock_id)
VALUES
  (1, 10, 100000, 9, 1, GETDATE(), 1),
  (1, 20, 150000, 18, 2, GETDATE(), 2),
  (2, 30, 200000, 28, 2, GETDATE(), 3),
  (2, 40, 250000, 38, 2, GETDATE(), 4),
  (2, 50, 300000, 48, 2, GETDATE(), 5),
  (3, 60, 350000, 57, 3, GETDATE(), 1),
  (3, 70, 400000, 67, 3, GETDATE(), 2),
  (3, 80, 450000, 77, 3, GETDATE(), 3),
  (4, 90, 500000, 87, 3, GETDATE(), 4),
  (4, 100, 550000, 97, 3, GETDATE(), 5),
  (5, 110, 600000, 107, 3, GETDATE(), 1),
  (5, 120, 650000, 117, 3, GETDATE(), 2),
  (5, 130, 700000, 127, 3, GETDATE(), 3);
