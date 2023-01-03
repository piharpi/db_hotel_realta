-- INSERT MASTER MODULE
--REGION
SET IDENTITY_INSERT Master.Regions ON;
INSERT INTO Master.Regions (region_code, region_name)
VALUES ('1', 'Region 1'), ('2', 'Region 2'), ('3', 'Region 3'),
       ('4', 'Region 4'), ('5', 'Region 5'), ('6', 'Region 6'),
       ('7', 'Region 7'), ('8', 'Region 8'), ('9', 'Region 9'),
       ('10', 'Region 10'), ('11', 'Region 11'), ('12', 'Region 12'),
       ('13', 'Region 13'), ('14', 'Region 14'), ('15', 'Region 15'),
       ('16', 'Region 16'), ('17', 'Region 17'), ('18', 'Region 18'),
       ('19', 'Region 19'), ('20', 'Region 20');
SET IDENTITY_INSERT Master.Regions OFF;
SELECT*FROM Master.Regions
ORDER by region_code ASC

SET IDENTITY_INSERT Master.Country ON;
INSERT INTO .Master.Country (country_id, country_name, country_region_id)
VALUES (1, 'France', 1), (2, 'Germany', 2), (3, 'Spain', 3),
       (4, 'Italy', 4), (5, 'United Kingdom', 5), (6, 'Netherlands', 6),
       (7, 'Belgium', 7), (8, 'Denmark', 8), (9, 'Sweden', 9),
       (10, 'Norway', 10), (11, 'China', 11), (12, 'Japan', 12),
       (13, 'South Korea', 13), (14, 'North Korea', 14), (15, 'India', 15),
       (16, 'Pakistan', 16), (17, 'Bangladesh', 17), (18, 'Nepal', 18),
       (19, 'Bhutan', 19), (20, 'Sri Lanka', 20);
SET IDENTITY_INSERT Master.Country OFF;
SELECT*FROM Master.Country
ORDER by country_id ASC

SET IDENTITY_INSERT Master.Provinces ON;
INSERT INTO Master.Provinces (prov_id, prov_name, prov_country_id)
VALUES (1, 'Ontario', 1), (2, 'Quebec', 1), (3, 'British Columbia', 1),
       (4, 'Alberta', 1), (5, 'Manitoba', 1), (6, 'Saskatchewan', 1),
       (7, 'New Brunswick', 1), (8, 'Nova Scotia', 1), (9, 'Prince Edward Island', 1),
       (10, 'Newfoundland and Labrador', 1), (11, 'Hesse', 2), (12, 'Bavaria', 2),
       (13, 'Baden-Württemberg', 2), (14, 'North Rhine-Westphalia', 2), (15, 'Lower Saxony', 2),
       (16, 'Andalusia', 3), (17, 'Catalonia', 3), (18, 'Valencia', 3),
       (19, 'Galicia', 3), (20, 'Castilla y León', 3);
SET IDENTITY_INSERT Master.provinces OFF;
SELECT*FROM Master.provinces
ORDER BY prov_id


SET IDENTITY_INSERT Master.Address ON;
INSERT INTO Master.Address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_prov_id)
VALUES (1, '123 Main Street', '', 'A1AA1', geography::Point(43.65, -79.38, 4326), 1),
    (2, '456 Maple Avenue', '', 'B2BB2', geography::Point(43.65, -79.38, 4326), 1),
    (3, '789 Oak Boulevard', '', 'C3CC3', geography::Point(43.65, -79.38, 4326), 1),
    (4, '321 Pine Street', '', 'D4DD4', geography::Point(43.65, -79.38, 4326), 1),
    (5, '654 Cedar Road', '', 'E5EE5', geography::Point(43.65, -79.38, 4326), 1),
    (6, '987 Spruce Lane', '', 'F6FF6', geography::Point(43.65, -79.38, 4326), 1),
    (7, '246 Fir Avenue', '', 'G77G7', geography::Point(43.65, -79.38, 4326), 1),
    (8, '369 Hemlock Drive', '', 'H8HH8', geography::Point(43.65, -79.38, 4326), 1),
    (9, '159 Willow Way', '', 'I9II9', geography::Point(43.65, -79.38, 4326), 1),
    (10, '753 Maple Street', '', 'J0JJ0', geography::Point(43.65, -79.38, 4326), 1),
    (11, '1 Parliament Hill', '', 'K1KA6', geography::Point(45.42, -75.70, 4326), 2),
    (12, '2 Sussex Drive', '', 'K1NK1', geography::Point(45.42, -75.70, 4326), 2),
    (13, '3 Rideau Street', '', 'K1NJ9', geography::Point(45.42, -75.70, 4326), 2),
    (14, '4 Wellington Street', '', 'K1PJ9', geography::Point(45.42, -75.70, 4326), 2),
    (15, '5 Elgin Street', '', 'K1PK7', geography::Point(45.42, -75.70, 4326), 2),
    (16, 'Avenida de la Constitución, 3', '', '41001', geography::Point(37.38, -6.00, 4326), 16),
    (17, 'Plaza de Santo Domingo, 3', '', '41001', geography::Point(37.38, -6.00, 4326), 16),
    (18, 'Calle de la Ribera, 15', '', '41001', geography::Point(37.38, -6.00, 4326), 16),
    (19, 'Calle del Arenal, 12', '', '41001', geography::Point(37.38, -6.00, 4326), 16),
    (20, 'Calle de la Ribera, 25', '', '41001', geography::Point(37.38, -6.00, 4326), 16);
SET IDENTITY_INSERT Master.Address OFF;
SELECT*FROM Master.Address
ORDER BY addr_id ASC


--CATEGORY_GROUP
SET IDENTITY_INSERT Master.category_group ON;
INSERT INTO master.category_group (cagro_id, cagro_name, cagro_description, cagro_type, cagro_icon, cagro_icon_url)
VALUES
  (1, 'ROOM', 'Rooms for guests to stay in', 'category', 'room.png', 'https://example.com/room.png'),
  (2, 'RESTAURANT', 'On-site restaurant for guests to dine in', 'service', 'restaurant.png', 'https://example.com/restaurant.png'),
  (3, 'MEETING ROOM', 'Rooms for meetings and events', 'facility', 'meeting_room.png', 'https://example.com/meeting_room.png'),
  (4, 'GYM', 'Fitness center for guests to use', 'facility', 'gym.png', 'https://example.com/gym.png'),
  (5, 'AULA', 'Multipurpose room for events', 'facility', 'aula.png', 'https://example.com/aula.png'),
  (6, 'SWIMMING POOL', 'Outdoor swimming pool for guests to use', 'facility', 'swimming_pool.png', 'https://example.com/swimming_pool.png'),
  (7, 'BALROOM', 'Ballroom for events and parties', 'facility', 'balroom.png', 'https://example.com/balroom.png');
SET IDENTITY_INSERT Master.category_group OFF;
SELECT*FROM Master.category_group
ORDER BY cagro_id ASC

--POLICY
SET IDENTITY_INSERT Master.policy ON;
insert into master.policy (poli_name, poli_description)
values
('Pembatalan Gratis', 'Kebijakan pembatalan gratis yang memberikan kemudahan bagi tamu untuk membatalkan reservasi mereka hingga 24 jam sebelum tanggal check-in tanpa dikenakan biaya apapun'),
('Check-in Awal', 'Kebijakan check-in awal yang memberikan kemudahan bagi tamu untuk melakukan check-in lebih awal dari waktu yang ditentukan, dengan biaya tambahan yang telah ditentukan'),
('Check-out Terlambat', 'Kebijakan check-out terlambat yang memberikan kemudahan bagi tamu untuk melakukan check-out lebih lambat dari waktu yang ditentukan, dengan biaya tambahan yang telah ditentukan'),
('Fasilitas Anak-anak', 'Kebijakan fasilitas anak-anak yang memberikan kemudahan bagi tamu yang membawa anak-anak dengan fasilitas yang disesuaikan dengan kebutuhan anak-anak, seperti kamar yang lebih luas dan fasilitas bermain');
SET IDENTITY_INSERT Master.policy OFF;
SELECT*FROM Master.policy
ORDER BY poli_id ASC

--PRICE_ITEM
SET IDENTITY_INSERT Master.price_item ON;
insert into master.price_item ( prit_name, prit_price, prit_description, prit_type, prit_modified_date)
values
('Kue Kering', 12000, 'Kue kering dengan beragam rasa yang enak dan lezat', 'SNACK', '2022-01-01'),
('Kamar Standar', 500000, 'Kamar standar dengan fasilitas yang cukup lengkap', 'FACILITY', '2022-01-01'),
('Aqua', 10000, 'Minuman bersoda dengan rasa jeruk yang segar', 'SOFTDRINK', '2022-01-01'),
('Nasi Goreng', 35000, 'Nasi goreng dengan bahan-bahan yang berkualitas dan rasa yang nikmat', 'FOOD', '2022-01-01'),
('Massage', 80000, 'Layanan massage yang dapat membantu mengurangi stres dan merelaksasi tubuh', 'SERVICE', '2022-01-01');
SET IDENTITY_INSERT Master.price_item OFF;
SELECT*FROM Master.price_item
ORDER BY prit_id ASC

--MEMBER
insert into master.members (memb_name, memb_description)
values
('SILVER', 'Keanggotaan SILVER memberikan diskon 10% pada semua layanan hotel'),
('GOLD', 'Keanggotaan GOLD memberikan diskon 20% pada semua layanan hotel dan fasilitas gratis late check-out hingga pukul 12 siang'),
('VIP', 'Keanggotaan VIP memberikan diskon 30% pada semua layanan hotel, fasilitas gratis late check-out hingga pukul 12 siang, dan akses ke VIP lounge'),
('WIZARD', 'Keanggotaan WIZARD memberikan diskon 50% pada semua layanan hotel, fasilitas gratis late check-out hingga pukul 12 siang, akses ke VIP lounge, dan fasilitas gratis upgrade kamar');
SELECT*FROM Master.members

--SERVICE_TASK
SET IDENTITY_INSERT Master.service_task ON;
insert into master.service_task (seta_id, seta_name, seta_seq)
values
(1, 'Receptionist', 1),
(2, 'Housekeeping', 2),
(3, 'Chef', 3),
(4, 'Security', 4),
(5, 'Manager', 5);
SET IDENTITY_INSERT Master.service_task OFF;
SELECT*FROM Master.service_task
ORDER BY seta_id ASC


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

--- INSERT MODULE USERS
-- Insert 15 rows into the users.users table
INSERT INTO users.users (user_full_name, user_type, user_company_name, user_email, user_phone_number, user_modified_date)
VALUES ('John Smith', 'T', 'Acme Inc.', 'john.smith@acme.com', '123-456-7890', GETDATE()),
       ('Jane Doe', 'C', 'XYZ Corp.', 'jane.doe@xyz.com', '123-456-7891', GETDATE()),
       ('Bob Johnson', 'I', 'ABC Inc.', 'bob.johnson@abc.com', '123-456-7892', GETDATE()),
       ('Samantha Williams', 'T', 'Def Corp.', 'samantha.williams@def.com', '123-456-7893', GETDATE()),
       ('Michael Brown', 'C', 'Ghi Inc.', 'michael.brown@ghi.com', '123-456-7894', GETDATE()),
       ('Emily Davis', 'I', 'Jkl Ltd.', 'emily.davis@jkl.com', '123-456-7895', GETDATE()),
       ('William Thompson', 'T', 'Mno Inc.', 'william.thompson@mno.com', '123-456-7896', GETDATE()),
       ('Ashley Johnson', 'C', 'Pqr Corp.', 'ashley.johnson@pqr.com', '123-456-7897', GETDATE()),
       ('David Anderson', 'I', 'Stu Inc.', 'david.anderson@stu.com', '123-456-7898', GETDATE()),
       ('Jessica Smith', 'T', 'Vwx Corp.', 'jessica.smith@vwx.com', '123-456-7899', GETDATE()),
	   ('David Brown', 'T', 'Example Co', 'david.brown@example.com', '555-555-1222', GETDATE()),
	   ('Jessica Smith', 'C', 'Test Inc', 'jessica.smith@test.com', '555-555-1223', GETDATE()),
	   ('James Johnson', 'I', 'Acme Inc', 'james.johnson@acme.com', '555-555-1224', GETDATE()),
	   ('Samantha Williams', 'C', 'XYZ Corp', 'samantha.williams@xyz.com', '555-555-1225', GETDATE()),
	   ('Robert Davis', 'T', 'Example Co', 'robert.davis@example.com', '555-555-1226', GETDATE());

-- Insert 4 rows into the master.members table
INSERT INTO master.members (memb_name)
VALUES ('Silver'),
       ('Gold'),
       ('VIP'),
       ('Wizard')

-- Insert 15 rows into the users.user_members table
INSERT INTO users.user_members (usme_user_id, usme_memb_name, usme_promote_date, usme_points, usme_type)
VALUES (1, 'Silver', '2022-01-01', 100, 'Active'),
       (2, 'Gold', '2022-02-01', 200, 'Active'),
       (3, 'VIP', '2022-03-01', 300, 'Active'),
       (4, 'Wizard', '2022-04-01', 400, 'Active'),
       (5, 'Silver', '2022-05-01', 500, 'Active'),
       (6, 'Gold', '2022-06-01', 600, 'Active'),
       (7, 'VIP', '2022-07-01', 700, 'Active'),
       (8, 'Wizard', '2022-08-01', 800, 'Active'),
       (9, 'Silver', '2022-09-01', 900, 'Active'),
       (10, 'Gold', '2022-10-01', 1000, 'Active'),
	   (11, 'Silver', '2022-11-01', 1000, 'Expired'),
	   (12, 'Gold', '2022-12-01', 1000, 'Expired'),
	   (13, 'VIP', '2022-01-01', 1000, 'Expired'),
	   (14, 'Wizard', '2022-02-01', 1000, 'Expired'),
	   (15, 'Gold', '2022-03-01', 1000, 'Expired');

-- Insert 5 rows into the users.roles table
SET IDENTITY_INSERT users.roles ON;

INSERT INTO users.roles (role_id, role_name)
VALUES 
(1, 'Guest'),
(2, 'Manager'),
(3, 'OfficeBoy'),
(4, 'Admin'),
(5, 'User')

SET IDENTITY_INSERT users.roles OFF;

-- Insert 15 rows into the users.user_roles table
INSERT INTO users.user_roles (usro_user_id, usro_role_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5);

-- Insert 15 dummy rows into the master.address table
SET IDENTITY_INSERT master.address ON;

INSERT INTO master.address (addr_id)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);

SET IDENTITY_INSERT master.address OFF;

-- Insert 15 dummy rows into the users.user_profiles table
SET IDENTITY_INSERT users.user_profiles ON;

INSERT INTO users.user_profiles (uspro_id, uspro_national_id, uspro_birth_date, uspro_job_title, uspro_marital_status, uspro_gender, uspro_addr_id, uspro_user_id)
VALUES (1, '123-45-6789', '1980-01-01', 'Manager', 'S', 'M', 1, 1),
       (2, '234-56-7890', '1985-02-02', 'Developer', 'M', 'F', 2, 2),
       (3, '345-67-8901', '1990-03-03', 'Designer', 'S', 'M', 3, 3),
       (4, '456-78-9012', '1995-04-04', 'Tester', 'M', 'F', 4, 4),
       (5, '567-89-0123', '2000-05-05', 'Analyst', 'S', 'M', 5, 5),
       (6, '678-90-1234', '2005-06-06', 'Consultant', 'M', 'F', 6, 6),
       (7, '789-01-2345', '2010-07-07', 'Salesperson', 'S', 'M', 7, 7),
       (8, '890-12-3456', '2015-08-08', 'HR Manager', 'M', 'F', 8, 8),
       (9, '901-23-4567', '2020-09-09', 'Project Manager', 'S', 'M', 9, 9),
       (10, '012-34-5678', '2025-10-10', 'Marketing Manager', 'M', 'F', 10, 10),
	   (11, '123-45-6789', '1985-01-01', 'Engineer', 'S', 'M', 11, 11),
	   (12, '234-56-7890', '1990-01-01', 'Designer', 'S', 'F', 12, 12),
	   (13, '345-67-8901', '1995-01-01', 'Journalist', 'S', 'M', 13, 13),
	   (14, '456-78-9012', '1980-01-01', 'Teacher', 'M', 'F', 14, 14),
	   (15, '567-89-0123', '1985-01-01', 'Writer', 'S', 'M', 15, 15);

SET IDENTITY_INSERT users.user_profiles OFF;

-- Insert 15 dummy rows into the users.user_password table
SET IDENTITY_INSERT users.user_password ON;

INSERT INTO users.user_password (uspa_user_id, uspa_passwordHash, uspa_passwordSalt)
VALUES
(1, '123456', 'abcdef'),
(2, 'password', 'ghijkl'),
(3, 'qwerty', 'mnopqr'),
(4, 'letmein', 'stuvwx'),
(5, 'trustno1', 'yzabcd'),
(6, 'sunshine', 'efghij'),
(7, 'iloveyou', 'klmnop'),
(8, 'monkey', 'qrstuv'),
(9, 'starwars', 'wxyzab'),
(10, 'master', 'cdefgh'),
(11, 'abc123', 'ijklmn'),
(12, '123abc', 'opqrst'),
(13, 'welcome', 'uvwxyz'),
(14, 'monkey1', 'abcdefg'),
(15, 'password1', 'hijklmn');


SET IDENTITY_INSERT users.user_password OFF;

-- Insert 15 dummy rows into the users.bonus_points table
SET IDENTITY_INSERT users.bonus_points ON;

INSERT INTO users.bonus_points (ubpo_id, ubpo_user_id, ubpo_total_points, ubpo_bonus_type, ubpo_created_on)
VALUES (1, 1, 1000, 'R', '2022-01-01'),
       (2, 2, 2000, 'P', '2022-02-02'),
       (3, 3, 3000, 'P', '2022-03-03'),
       (4, 4, 4000, 'R', '2022-04-04'),
       (5, 5, 5000, 'P', '2022-05-05'),
       (6, 6, 6000, 'P', '2022-06-06'),
       (7, 7, 7000, 'R', '2022-07-07'),
       (8, 8, 8000, 'P', '2022-08-08'),
       (9, 9, 9000, 'P', '2022-09-09'),
       (10, 10, 10000, 'R', '2022-10-10'),
	   (11, 11, 10000, 'P', '2022-11-11'),
	   (12, 12, 10000, 'R', '2022-12-12'),
	   (13, 13, 10000, 'P', '2022-01-01'),
	   (14, 14, 10000, 'R', '2022-02-02'),
	   (15, 15, 10000, 'P', '2022-03-03');

SET IDENTITY_INSERT users.bonus_points OFF;