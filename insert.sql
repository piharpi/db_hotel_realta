-- File insert 
=======
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


--resto.resto_menus
INSERT INTO resto.resto_menus
    (reme_faci_id, reme_name, reme_description, reme_price, reme_status, reme_modified_date)
VALUES
    (2, 'Nasi Goreng', 'Nasi goreng dengan bahan dasar nasi yang ditumis bersama telur dan sayuran', 15000, 'Available', GETDATE()),
    (2, 'Soto Ayam', 'Soto ayam dengan kuah yang gurih dan daging ayam yang empuk', 20000, 'Available', GETDATE()),
    (2, 'Gado-gado', 'Gado-gado dengan bahan dasar lontong dan sayuran-sayuran segar', 10000, 'Available', GETDATE()),
    (2, 'Bakso', 'Bakso dengan daging sapi yang dipotong-potong dan dimasak dengan bumbu khusus', 15000, 'Available', GETDATE()),
    (2, 'Ayam Goreng', 'Ayam goreng dengan tepung yang renyah dan daging ayam yang empuk', 25000, 'Available', GETDATE()),
    (2, 'Sate Ayam', 'Sate ayam dengan bumbu kacang yang lezat', 20000, 'Available', GETDATE()),
    (2, 'Nasi Kuning', 'Nasi kuning dengan bahan dasar nasi yang dicampur dengan telur dan kecap', 10000, 'Available', GETDATE()),
    (2, 'Sop Buntut', 'Sop buntut dengan bahan dasar daging buntut yang empuk dan kuah yang gurih', 30000, 'Available', GETDATE()),
    (2, 'Bubur Ayam', 'Bubur ayam dengan bahan dasar nasi yang dicampur dengan daging ayam dan sayuran', 10000, 'Available', GETDATE()),
    (2, 'Mie Goreng', 'Mie goreng dengan bahan dasar mie yang ditumis bersama telur dan sayuran', 15000, 'Available', GETDATE()),
    (2, 'Cap Cay', 'Cap cay dengan bahan dasar sayuran yang dicampur dengan daging sapi dan kuah kaldu', 20000, 'Available', GETDATE());

--resto.order_menu
INSERT INTO resto.order_menus (orme_order_number, orme_order_date, orme_total_item, orme_total_discount, orme_total_amount, orme_pay_type, orme_cardnumber, orme_is_paid, orme_modified_date, orme_user_id)
VALUES ('MENUS#2022-01-01-00001', '2022-01-01', 2, 0, 40000, 'CA', NULL, 'P', GETDATE(), 1),
('MENUS#2022-01-01-00002', '2022-01-01', 3, 5000, 75000, 'CR', '1234567890123456', 'P', GETDATE(), 2),
('MENUS#2022-01-01-00003', '2022-01-01', 4, 0, 80000, 'D', '9876543210987654', 'B', GETDATE(), 3),
('MENUS#2022-01-01-00004', '2022-01-01', 5, 0, 100000, 'CA', NULL, 'P', GETDATE(), 4),
('MENUS#2022-01-01-00005', '2022-01-01', 6, 0, 120000, 'CR', '1234567890123456', 'P', GETDATE(), 5),
('MENUS#2022-01-01-00006', '2022-01-01', 7, 0, 140000, 'D', '9876543210987654', 'B', GETDATE(), 6);

--resto order menu detail

Berikut adalah contoh isian data dummy untuk tabel order_menu_detail:

INSERT INTO resto.order_menu_detail (orme_price, orme_qty, orme_subtotal, orme_discount, omde_orme_id, omde_reme_id)
VALUES
(10000, 2, 20000, 0, 1, 1),
(12000, 3, 36000, 0, 1, 2),
(15000, 2, 30000, 0, 2, 3),
(20000, 4, 80000, 0, 2, 4),
(10000, 3, 30000, 0, 3, 5),
(15000, 1, 15000, 0, 3, 6),
(20000, 3, 60000, 0, 4, 7),
(12000, 2, 24000, 0, 4, 8),
(10000, 4, 40000, 0, 5, 9),
(15000, 2, 30000, 0, 5, 10);

--resto photos

INSERT INTO resto.resto_menu_photos (remp_thumbnail_filename, remp_photo_filename, remp_primary, remp_url, remp_reme_id)
VALUES ('thumbnail1.jpg', 'photo1.jpg', 1, 'http://localhost/resto/menu/photo1.jpg', 1),
('thumbnail2.jpg', 'photo2.jpg', 0, 'http://localhost/resto/menu/photo2.jpg', 1),
('thumbnail3.jpg', 'photo3.jpg', 0, 'http://localhost/resto/menu/photo3.jpg', 1),
('thumbnail4.jpg', 'photo4.jpg', 1, 'http://localhost/resto/menu/photo4.jpg', 2),
('thumbnail5.jpg', 'photo5.jpg', 0, 'http://localhost/resto/menu/photo5.jpg', 2),
('thumbnail6.jpg', 'photo6.jpg', 0, 'http://localhost/resto/menu/photo6.jpg', 2),
('thumbnail7.jpg', 'photo7.jpg', 1, 'http://localhost/resto/menu/photo7.jpg', 3),
('thumbnail8.jpg', 'photo8.jpg', 0, 'http://localhost/resto/menu/photo8.jpg', 3),
('thumbnail9.jpg', 'photo9.jpg', 0, 'http://localhost/resto/menu/photo9.jpg', 3),
('thumbnail10.jpg', 'photo10.jpg', 1, 'http://localhost/resto/menu/photo10.jpg', 4);
