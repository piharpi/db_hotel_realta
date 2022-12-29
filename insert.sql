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
    (reme_name, reme_description, reme_price, reme_status, reme_modified_date)
VALUES
    ('Nasi Goreng', 'Nasi goreng dengan bahan dasar nasi yang ditumis bersama telur dan sayuran', 15000, 'Available', GETDATE()),
    ('Soto Ayam', 'Soto ayam dengan kuah yang gurih dan daging ayam yang empuk', 20000, 'Available', GETDATE()),
    ('Gado-gado', 'Gado-gado dengan bahan dasar lontong dan sayuran-sayuran segar', 10000, 'Available', GETDATE()),
    ('Bakso', 'Bakso dengan daging sapi yang dipotong-potong dan dimasak dengan bumbu khusus', 15000, 'Available', GETDATE()),
    ('Ayam Goreng', 'Ayam goreng dengan tepung yang renyah dan daging ayam yang empuk', 25000, 'Available', GETDATE()),
    ('Sate Ayam', 'Sate ayam dengan bumbu kacang yang lezat', 20000, 'Available', GETDATE()),
    ('Nasi Kuning', 'Nasi kuning dengan bahan dasar nasi yang dicampur dengan telur dan kecap', 10000, 'Available', GETDATE()),
    ('Sop Buntut', 'Sop buntut dengan bahan dasar daging buntut yang empuk dan kuah yang gurih', 30000, 'Available', GETDATE()),
    ('Bubur Ayam', 'Bubur ayam dengan bahan dasar nasi yang dicampur dengan daging ayam dan sayuran', 10000, 'Available', GETDATE()),
    ('Mie Goreng', 'Mie goreng dengan bahan dasar mie yang ditumis bersama telur dan sayuran', 15000, 'Available', GETDATE()),
    ('Cap Cay', 'Cap cay dengan bahan dasar sayuran yang dicampur dengan daging sapi dan kuah kaldu', 20000, 'Available', GETDATE());

SELECT * FROM resto.resto_menus;

--resto.order_menu
INSERT INTO resto.order_menus (orme_order_number, orme_order_date, orme_total_item, orme_total_discount, orme_total_amount, orme_pay_type, orme_cardnumber, orme_is_paid, orme_modified_date)
VALUES 
    ('INV001', GETDATE(), 2, 0, 30000, 'C', NULL, 'P', GETDATE()),
    ('INV002', GETDATE(), 3, 5000, 45000, 'PG', NULL, 'P', GETDATE()),
    ('INV003', GETDATE(), 1, 0, 15000, 'CR', '4111-1111-1111-1111', 'P', GETDATE()),
    ('INV004', GETDATE(), 4, 10000, 60000, 'D', '5111-1111-1111-1111', 'P', GETDATE()),
    ('INV005', GETDATE(), 3, 8000, 42000, 'BO', NULL, 'P', GETDATE()),
    ('INV006', GETDATE(), 2, 4000, 30000, 'C', NULL, 'P', GETDATE()),
    ('INV007', GETDATE(), 1, 0, 15000, 'CR', '4111-1111-1111-1111', 'P', GETDATE()),
    ('INV008', GETDATE(), 3, 9000, 45000, 'PG', NULL, 'P', GETDATE()),
    ('INV009', GETDATE(), 2, 2000, 30000, 'D', '5111-1111-1111-1111', 'P', GETDATE());

SELECT * FROM resto.order_menu_detail;

--resto order menu detail

INSERT INTO resto.order_menu_detail (orme_price, orme_qty, orme_subtotal, orme_discount)
VALUES 
    (15000, 2, 30000, 0),
    (20000, 1, 20000, 0),
    (25000, 2, 50000, 0),
    (15000, 3, 45000, 0),
    (20000, 2, 40000, 0),
    (25000, 1, 25000, 0),
    (15000, 1, 15000, 0),
    (20000, 2, 40000, 0),
    (25000, 3, 75000, 0),
    (20000, 1, 20000, 0);


--resto photos

INSERT INTO resto.resto_menu_photos (remp_thumbnial_filname, remp_photo_filename, remp_primary, remp_url)
VALUES 
    ('mie-ayam.jpg', 'mie-ayam-large.jpg', 1, 'https://www.example.com/mie-ayam.jpg'),
    ('nasi-goreng.jpg', 'nasi-goreng-large.jpg', 1, 'https://www.example.com/nasi-goreng.jpg'),
    ('soto-ayam.jpg', 'soto-ayam-large.jpg', 1, 'https://www.example.com/soto-ayam.jpg'),
    ('ayam-goreng.jpg', 'ayam-goreng-large.jpg', 0, 'https://www.example.com/ayam-goreng.jpg'),
    ('sate-ayam.jpg', 'sate-ayam-large.jpg', 0, 'https://www.example.com/sate-ayam.jpg'),
    ('kare-ayam.jpg', 'kare-ayam-large.jpg', 0, 'https://www.example.com/kare-ayam.jpg'),
    ('sushi.jpg', 'sushi-large.jpg', 1, 'https://www.example.com/sushi.jpg'),
    ('udon.jpg', 'udon-large.jpg', 0, 'https://www.example.com/udon.jpg'),
    ('ramen.jpg', 'ramen-large.jpg', 0, 'https://www.example.com/ramen.jpg'),
    ('gyudon.jpg', 'gyudon-large.jpg', 1, 'https://www.example.com/gyudon.jpg');
