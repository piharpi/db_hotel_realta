USE Hotel_Realta;
GO

-- DELETE MODULE Purchasing
DBCC CHECKIDENT ('Purchasing.stocks', RESEED, 1);
GO

DBCC CHECKIDENT ('Purchasing.purchase_order_header', RESEED, 1);
GO

DELETE Purchasing.purchase_order_detail;
DELETE Purchasing.stock_detail;
DELETE Purchasing.stock_photo;
DELETE Purchasing.stocks;
DELETE Purchasing.purchase_order_header;
DELETE Purchasing.vendor;
DELETE Purchasing.cart;

-- DELETE MODULE Payment
DBCC CHECKIDENT ('Payment.payment_transaction', RESEED, 1);
GO

DELETE Payment.payment_transaction;
DELETE Payment.payment_gateway;
DELETE Payment.entity;
DELETE Payment.bank;

-- DELETE MODULE Resto
DELETE Resto.order_menus;
DELETE Resto.resto_menu_photos;
DELETE Resto.order_menu_detail;
DELETE Resto.resto_menus;

-- DELETE MODULE Booking
DELETE Booking.user_breakfast;
DELETE Booking.special_offers;
DELETE Booking.booking_order_detail_extra;
DELETE Booking.booking_order_detail;
DELETE Booking.booking_orders;
DELETE Booking.special_offer_coupons;

-- DELETE MODULE HR
DELETE HR.work_order_detail;
DELETE HR.work_orders;
DELETE HR.employee_pay_history;
DELETE HR.employee_department_history;
DELETE HR.department;
DELETE HR.shift;
DELETE HR.employee;
DELETE HR.job_role;

-- RESET IDENT MODULE Hotel
DBCC CHECKIDENT ('Hotel.hotels', RESEED, 1);
GO
DBCC CHECKIDENT ('Hotel.hotel_reviews', RESEED, 1);
GO
DBCC CHECKIDENT ('Hotel.facilities', RESEED, 1);
GO
DBCC CHECKIDENT ('Hotel.facility_photos', RESEED, 1);
GO
DBCC CHECKIDENT ('Hotel.facility_price_history', RESEED, 1);
GO

-- DELETE MODULE Hotel
DELETE Hotel.hotels;
DELETE Hotel.hotel_reviews;
DELETE Hotel.facilities;
DELETE Hotel.facility_photos;
DELETE Hotel.facility_price_history;


-- DELETE MODULE Users
DELETE Users.roles;
DELETE Users.user_roles;
DELETE Users.bonus_points;
DELETE Users.user_password;
DELETE Users.users;
DELETE Users.user_profiles;
DELETE Users.user_members;

-- DELETE MODULE Master
DELETE Master.regions;
DELETE Master.country;
DELETE Master.provinces;
DELETE Master.address;
DELETE Master.price_items;
DELETE Master.members;
DELETE Master.service_task;
DELETE Master.category_group;
DELETE Master.policy;
DELETE Master.policy_category_group;


-- File insert

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
-- SELECT*FROM Master.Regions
-- ORDER by region_code ASC

SET IDENTITY_INSERT Master.Country ON;
INSERT INTO Master.Country (country_id, country_name, country_region_id)
VALUES (1, 'France', 1), (2, 'Germany', 2), (3, 'Spain', 3),
	   (4, 'Italy', 4), (5, 'United Kingdom', 5), (6, 'Netherlands', 6),
	   (7, 'Belgium', 7), (8, 'Denmark', 8), (9, 'Sweden', 9),
	   (10, 'Norway', 10), (11, 'China', 11), (12, 'Japan', 12),
	   (13, 'South Korea', 13), (14, 'North Korea', 14), (15, 'India', 15),
	   (16, 'Pakistan', 16), (17, 'Bangladesh', 17), (18, 'Nepal', 18),
	   (19, 'Bhutan', 19), (20, 'Sri Lanka', 20);
SET IDENTITY_INSERT Master.Country OFF;
-- SELECT*FROM Master.Country
-- ORDER by country_id ASC

SET IDENTITY_INSERT Master.Provinces ON;
INSERT INTO Master.Provinces (prov_id, prov_name, prov_country_id)
VALUES (1, 'Ontario', 1), (2, 'Quebec', 1), (3, 'British Columbia', 1),
	   (4, 'Alberta', 1), (5, 'Manitoba', 1), (6, 'Saskatchewan', 1),
	   (7, 'New Brunswick', 1), (8, 'Nova Scotia', 1), (9, 'Prince Edward Island', 1),
	   (10, 'Newfoundland and Labrador', 1), (11, 'Hesse', 2), (12, 'Bavaria', 2),
	   (13, 'Baden-Württemberg', 2), (14, 'North Rhine-Westphalia', 2), (15, 'Lower Saxony', 2),
	   (16, 'Andalusia', 3), (17, 'Catalonia', 3), (18, 'Valencia', 3),
	   (19, 'Galicia', 3), (20, 'Castilla y León', 3);
SET IDENTITY_INSERT Master.Provinces OFF;

-- SELECT*FROM Master.provinces
-- ORDER BY prov_id


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
-- SELECT*FROM Master.Address
-- ORDER BY addr_id ASC


--CATEGORY_GROUP
SET IDENTITY_INSERT Master.category_group ON;
INSERT INTO Master.category_group (cagro_id, cagro_name, cagro_description, cagro_type, cagro_icon, cagro_icon_url)
VALUES
  (1, 'ROOM', 'Rooms for guests to stay in', 'category', 'room.png', 'https://example.com/room.png'),
  (2, 'RESTAURANT', 'On-site restaurant for guests to dine in', 'service', 'restaurant.png', 'https://example.com/restaurant.png'),
  (3, 'MEETING ROOM', 'Rooms for meetings and events', 'facility', 'meeting_room.png', 'https://example.com/meeting_room.png'),
  (4, 'GYM', 'Fitness center for guests to use', 'facility', 'gym.png', 'https://example.com/gym.png'),
  (5, 'AULA', 'Multipurpose room for events', 'facility', 'aula.png', 'https://example.com/aula.png'),
  (6, 'SWIMMING POOL', 'Outdoor swimming pool for guests to use', 'facility', 'swimming_pool.png', 'https://example.com/swimming_pool.png'),
  (7, 'BALROOM', 'Ballroom for events and parties', 'facility', 'balroom.png', 'https://example.com/balroom.png');
SET IDENTITY_INSERT Master.category_group OFF;

-- SELECT*FROM Master.category_group
-- ORDER BY cagro_id ASC

--POLICY
SET IDENTITY_INSERT Master.policy ON;
insert into master.policy (poli_id, poli_name, poli_description)
values
(1,'Pembatalan Gratis', 'Kebijakan pembatalan gratis yang memberikan kemudahan bagi tamu untuk membatalkan reservasi mereka hingga 24 jam sebelum tanggal check-in tanpa dikenakan biaya apapun'),
(2,'Check-in Awal', 'Kebijakan check-in awal yang memberikan kemudahan bagi tamu untuk melakukan check-in lebih awal dari waktu yang ditentukan, dengan biaya tambahan yang telah ditentukan'),
(3,'Check-out Terlambat', 'Kebijakan check-out terlambat yang memberikan kemudahan bagi tamu untuk melakukan check-out lebih lambat dari waktu yang ditentukan, dengan biaya tambahan yang telah ditentukan'),
(4,'Fasilitas Anak-anak', 'Kebijakan fasilitas anak-anak yang memberikan kemudahan bagi tamu yang membawa anak-anak dengan fasilitas yang disesuaikan dengan kebutuhan anak-anak, seperti kamar yang lebih luas dan fasilitas bermain');
SET IDENTITY_INSERT Master.policy OFF;
-- SELECT*FROM Master.policy
-- ORDER BY poli_id ASC

--PRICE_ITEM
SET IDENTITY_INSERT Master.price_items ON;
insert into master.price_items (prit_id, prit_name, prit_price, prit_description, prit_type, prit_modified_date)
values
(1, 'Kue Kering', 12000, 'Kue kering dengan beragam rasa yang enak dan lezat', 'SNACK', '2022-01-01'),
(2, 'Kamar Standar', 500000, 'Kamar standar dengan fasilitas yang cukup lengkap', 'FACILITY', '2022-01-01'),
(3, 'Aqua', 10000, 'Minuman bersoda dengan rasa jeruk yang segar', 'SOFTDRINK', '2022-01-01'),
(4, 'Nasi Goreng', 35000, 'Nasi goreng dengan bahan-bahan yang berkualitas dan rasa yang nikmat', 'FOOD', '2022-01-01'),
(5, 'Massage', 80000, 'Layanan massage yang dapat membantu mengurangi stres dan merelaksasi tubuh', 'SERVICE', '2022-01-01');
SET IDENTITY_INSERT Master.price_items OFF;
-- SELECT*FROM Master.price_items
-- ORDER BY prit_id ASC

--MEMBER
insert into master.members (memb_name, memb_description)
values
('SILVER', 'Keanggotaan SILVER memberikan diskon 10% pada semua layanan hotel'),
('GOLD', 'Keanggotaan GOLD memberikan diskon 20% pada semua layanan hotel dan fasilitas gratis late check-out hingga pukul 12 siang'),
('VIP', 'Keanggotaan VIP memberikan diskon 30% pada semua layanan hotel, fasilitas gratis late check-out hingga pukul 12 siang, dan akses ke VIP lounge'),
('WIZARD', 'Keanggotaan WIZARD memberikan diskon 50% pada semua layanan hotel, fasilitas gratis late check-out hingga pukul 12 siang, akses ke VIP lounge, dan fasilitas gratis upgrade kamar');
-- SELECT*FROM Master.members

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
-- SELECT*FROM Master.service_task
-- ORDER BY seta_id ASC;

--- INSERT MODULE USERS
SET IDENTITY_INSERT Users.users ON;
INSERT INTO users.users (user_id, user_full_name, user_type, user_company_name, user_email, user_phone_number, user_modified_date)
VALUES (1,'John Smith', 'T', 'Acme Inc.', 'john.smith@acme.com', '123-456-7890', GETDATE()),
	   (2,'Jane Doe', 'C', 'XYZ Corp.', 'jane.doe@xyz.com', '123-456-7891', GETDATE()),
	   (3,'Account Realta', 'C', 'Hotel Realta.', 'realta@hotel.com', '033-456-7899', GETDATE()),
	   (4,'Samantha Williams', 'T', 'Def Corp.', 'samantha.williams@def.com', '123-456-7893', GETDATE()),
	   (5,'Michael Brown', 'C', 'Ghi Inc.', 'michael.brown@ghi.com', '123-456-7894', GETDATE()),
	   (6,'Emily Davis', 'I', 'Jkl Ltd.', 'emily.davis@jkl.com', '123-456-7895', GETDATE()),
	   (7,'William Thompson', 'T', 'Mno Inc.', 'william.thompson@mno.com', '123-456-7896', GETDATE()),
	   (8,'Ashley Johnson', 'C', 'Pqr Corp.', 'ashley.johnson@pqr.com', '123-456-7897', GETDATE()),
	   (9,'David Anderson', 'I', 'Stu Inc.', 'david.anderson@stu.com', '123-456-7898', GETDATE()),
	   (10,'Bob Johnson', 'I', 'ABC Inc.', 'bob.johnson@abc.com', '123-456-7892', GETDATE()),
	   (11,'David Brown', 'T', 'Example Co', 'david.brown@example.com', '555-555-1222', GETDATE()),
	   (12,'Jessica Smith', 'C', 'Test Inc', 'jessica.smith@test.com', '555-555-1223', GETDATE()),
	   (13,'James Johnson', 'I', 'Acme Inc', 'james.johnson@acme.com', '555-555-1224', GETDATE()),
	   (14,'Samantha Williams', 'C', 'XYZ Corp', 'samantha.williams@xyz.com', '555-555-1225', GETDATE()),
	   (15,'Robert Davis', 'T', 'Example Co', 'robert.davis@example.com', '555-555-1226', GETDATE());
SET IDENTITY_INSERT Users.users OFF;
-- SELECT * FROM Users.users;

-- Insert 15 rows into the users.user_members table
INSERT INTO users.user_members (usme_user_id, usme_memb_name, usme_promote_date, usme_points, usme_type)
VALUES (1, 'SILVER', '2022-01-01', 100, 'Active'),
	   (2, 'GOLD', '2022-02-01', 200, 'Active'),
	   (3, 'VIP', '2022-03-01', 300, 'Active'),
	   (4, 'WIZARD', '2022-04-01', 400, 'Active'),
	   (5, 'SILVER', '2022-05-01', 500, 'Active'),
	   (6, 'GOLD', '2022-06-01', 600, 'Active'),
	   (7, 'VIP', '2022-07-01', 700, 'Active'),
	   (8, 'WIZARD', '2022-08-01', 800, 'Active'),
	   (9, 'SILVER', '2022-09-01', 900, 'Active'),
	   (10, 'GOLD', '2022-10-01', 1000, 'Active'),
	   (11, 'SILVER', '2022-11-01', 1000, 'Expired'),
	   (12, 'GOLD', '2022-12-01', 1000, 'Expired'),
	   (13, 'VIP', '2022-01-01', 1000, 'Expired'),
	   (14, 'WIZARD', '2022-02-01', 1000, 'Expired'),
	   (15, 'GOLD', '2022-03-01', 1000, 'Expired');
-- SELECT * FROM Users.user_members;

-- Insert 5 rows into the users.roles table
SET IDENTITY_INSERT users.roles ON;
INSERT INTO users.roles (role_id, role_name)
VALUES
(1, 'Guest'),
(2, 'Manager'),
(3, 'OfficeBoy'),
(4, 'Admin'),
(5, 'User');
SET IDENTITY_INSERT users.roles OFF;
-- SELECT * FROM Users.roles;

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
(10, 2),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5);
-- select * from users.user_roles;

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
-- select * from users.user_profiles;

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
-- select * from users.user_password;

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
-- select * from users.bonus_points;

-- INSERT MODULE Hotel
--* DATA HOTEL *--
INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('Grand Hyatt Jakarta', 'Luxury hotel in the heart of Jakarta', 1, '+62 21 29921234', 4, 'Jl. M. H. Thamrin No.30, Jakarta Pusat', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('Aston Priority Simatupang Hotel & Conference Center', 'Contemporary hotel in South Jakarta', 0, '+62 21 78838777', 5, 'Jl. Let. Jend. T.B. Simatupang Kav. 9 Kebagusan Pasar Minggu, Jakarta Selatan', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('The Trans Luxury Hotel Bandung', 'Luxury hotel in Bandung', 0, '+62 22 87348888', 6, 'Jl. Gatot Subroto No. 289, Bandung, Jawa Barat', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('Padma Resort Ubud', 'Resort with rice field views in Ubud', 1, '+62 361 3011111', 7, 'Banjar Carik, Desa Puhu, Payangan, Gianyar, Bali', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('Four Seasons Resort Bali at Sayan', 'Luxury resort in the heart of Bali', 0, '+62 361 977577', 8, 'Sayan, Ubud, Bali', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('The Stones - Legian, Bali', 'Beachfront hotel in Legian, Bali', 1, '+62 361 3005888', 9, 'Jl. Raya Pantai Kuta, Banjar Legian Kelod, Legian, Bali', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_addr_id, hotel_addr_description, hotel_modified_date)
VALUES ('Aryaduta Makassar', 'City hotel in Makassar', 1, '+62 411 871111', 4, 'Jl. Somba Opu No. 297, Makassar, Sulawesi Selatan', GETDATE());

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('Hotel Tugu Malang', 'Hotel mewah dengan desain klasik Indonesia', 0, '(0341) 363891', GETDATE(), 5, 'Jl. Tugu No. 3, Klojen, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('The Shalimar Boutique Hotel', 'Hotel butik bintang 4 dengan taman tropis', 0, '(0341) 550888', GETDATE(), 5, 'Jalan Salak No. 38-42, Oro Oro Dowo, Klojen, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('Hotel Santika Premiere Malang', 'Hotel bintang 4 dengan restoran dan kolam renang', 1, '(0341) 405405', GETDATE(), 5, 'Jl. Letjen S. Parman No. 60, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('Ijen Suites Resort & Convention', 'Hotel mewah dengan kolam renang dan spa', 1, '(0341) 404888', GETDATE(), 5, 'Jalan Raya Kahuripan No. 16, Tlogomas, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('Atria Hotel Malang', 'Hotel mewah dengan pemandangan pegunungan', 0, '(0341) 402888', GETDATE(), 5, 'Jl. Letjen Sutoyo No.79, Klojen, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('Jambuluwuk Batu Resort', 'Resor bintang 4 dengan taman dan kolam renang', 0, '(0341) 596333', GETDATE(), 5, 'Jl. Trunojoyo No.99, Oro Oro Ombo, Batu, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('Aria Gajayana Hotel', 'Hotel mewah dengan pemandangan pegunungan', 0, '(0341) 320188', GETDATE(), 5, 'Jl. Hayam Wuruk No. 5, Klojen, Malang');

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_status, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_addr_description)
VALUES ('The Batu Hotel & Villas', 'Hotel mewah dengan kolam renang dan restoran', 1, '(0341) 512555', GETDATE(), 5, 'Jalan Raya Selecta No.1');
-- select * from Hotel.hotels

--* DATA REVIEWS *--
-- Data 1
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Hotel ini sangat menyenangkan!', 5, GETDATE(), 1, 1);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Pelayanan hotel sangat baik', 4, GETDATE(), 5, 1);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Kamar hotel sangat bersih dan nyaman', 5, GETDATE(), 6, 1);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Sangat puas dengan penginapan ini', 1, GETDATE(), 10, 1);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Sarapan paginya enak dan bervariasi', 1, GETDATE(), 11, 1);

-- Data 2
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Saya suka kamar mandinya yang luas', 4, GETDATE(), 1, 2);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Lokasi hotelnya sangat dekat dengan pusat kota', 4, GETDATE(), 5, 2);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Makanan di restoran hotelnya enak', 5, GETDATE(), 6, 2);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Pengalaman menginap yang menyenangkan', 5, GETDATE(), 10, 2);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Pelayanan receptionistnya ramah dan cepat', 5, GETDATE(), 11, 2);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Hotel yang direkomendasikan', 5, GETDATE(), 15, 2);

-- Data 3
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Kamar hotelnya luas dan bersih', 5, GETDATE(), 1, 3);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Sarapan paginya enak dan bergizi', 4, GETDATE(), 5, 3);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Fasilitas hotelnya lengkap', 5, GETDATE(), 6, 3);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Sangat puas dengan pelayanan hotelnya', 5, GETDATE(), 10, 3);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Harga yang sangat terjangkau', 5, GETDATE(), 11, 3);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Saya suka dengan suasana hotelnya yang tenang', 5, GETDATE(), 15, 3);

--DATA 4
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Hotel yang bagus untuk staycation', 5, GETDATE(), 1, 4);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Pemandangannya indah dari kamar', 4, GETDATE(), 5, 4);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Tempat yang pas untuk liburan keluarga', 5, GETDATE(), 6, 4);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Saya akan merekomendasikan hotel ini ke teman', 5, GETDATE(), 10, 4);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Sangat menyenangkan menginap di hotel ini', 5, GETDATE(), 11, 4);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Layanan hotelnya memuaskan', 5, GETDATE(), 15, 4);

-- DATA 5
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Kamar hotelnya bersih dan nyaman', 5, GETDATE(), 1, 5);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Lokasi hotelnya sangat dekat dengan pusat kota', 4, GETDATE(), 5, 5);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Pelayanan yang sangat baik', 5, GETDATE(), 6, 5);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Hotel yang cocok untuk perjalanan bisnis', 5, GETDATE(), 10, 5);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Saya suka kolam renangnya yang besar', 4, GETDATE(), 11, 5);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES
('Hotelnya direkomendasikan untuk liburan keluarga', 5, GETDATE(), 15, 5);


--* DATA FACILITIES *--
--DATA 1
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Single Room', 'Cozy and comfortable room with a single bed', 1, 'beds', '101', '2023-03-14 14:00:00', '2023-03-16 12:00:00', 500000, 700000, 1, NULL, 10, GETDATE(), 1, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Double Room', 'Spacious room with a double bed', 2, 'beds', '102', '2023-03-14 14:00:00', '2023-03-16 12:00:00', 700000, 900000, 1, NULL, 10, GETDATE(), 1, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Twin Room', 'Room with two single beds', 2, 'beds', '103', '2023-03-14 14:00:00', '2023-03-16 12:00:00', 600000, 800000, 1, NULL, 10, GETDATE(), 1, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Deluxe Room', 'Luxurious room with a king-size bed and a sofa', 3, 'beds', '104', '2023-03-14 14:00:00', '2023-03-16 12:00:00', 1000000, 1500000, 1, NULL, 10, GETDATE(), 1, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Restaurant', 'Fine dining restaurant with a wide selection of menu', 50, 'people', 'R101', '2023-03-14 08:00:00', '2023-03-15 22:00:00', 500000, 1000000, 2, NULL, 10, GETDATE(), 2, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Meeting Room', 'Meeting room with modern facilities and equipment', 30, 'people', 'M101', '2023-03-14 08:00:00', '2023-03-15 18:00:00', 750000, 1250000, 2, NULL, 10, GETDATE(), 3, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Gym', 'Fitness center with state-of-the-art equipment', NULL, 'people', 'G101', '2023-03-14 06:00:00', '2023-03-16 22:00:00', 100000, 150000, 3, NULL, 10, GETDATE(), 4, 1, 2);
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Swimming Pool', 'Outdoor swimming pool with a view of the city', NULL, 'people', 'SP101', '2023-03-14 08:00:00', '2023-03-16 18:00:00', 200000, 300000, 3, NULL, 10, GETDATE(), 6, 1, 2);


--DATA 2
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('Deluxe Room', 'A comfortable room with a king-size bed and a balcony', 2, 'beds', 'DR-101', '2023-04-01', '2023-04-07', 900000, 1000000, 1, NULL, NULL, 1, 2, 4, GETDATE());
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('Twin Room', 'A cozy room with two twin-size beds', 2, 'beds', 'TR-201', '2023-04-01', '2023-04-07', 700000, 800000, 1, NULL, NULL, 1, 2, 4, GETDATE());
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('Family Room', 'A spacious room with a king-size bed and two twin-size beds', 4, 'beds', 'FR-301', '2023-04-01', '2023-04-07', 1200000, 1400000, 1, NULL, NULL, 1, 2, 4, GETDATE());
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('Standard Room', 'A basic room with a queen-size bed', 2, 'beds', 'SR-401', '2023-04-01', '2023-04-07', 500000, 600000, 1, NULL, NULL, 1, 2, 4, GETDATE());
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('The Garden', 'A cozy restaurant with a beautiful garden view', 60, 'people', 'GDN-101', '2023-04-01', '2023-04-07', 5000000, 6000000, 1, NULL, NULL, 2, 2, 4, GETDATE());
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('The Spa', 'A relaxing spa with various treatments and facilities', 10, 'people', 'SPA-201', '2023-04-01', '2023-04-07', 15000000, 18000000, 1, NULL, NULL, 5, 2, 4, GETDATE());
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_expose_price, faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id, faci_modified_date)
VALUES
('The Meeting Room', 'A functional meeting room with modern amenities', 25, 'people', 'MTG-301', '2023-04-01', '2023-04-07', 3000000, 3500000, 1, NULL, NULL, 3, 2, 4, GETDATE());;


--DATA 3
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Deluxe Room', 'Spacious room with modern amenities', 2, 'beds', 'D01', '2023-03-14', '2023-03-16', 1000000, 1500000, NULL, 1, 10, 10, GETDATE(), 1, 3, 9);
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Superior Room', 'Cozy room with city view', 2, 'beds', 'D02', '2023-03-14', '2023-03-16', 900000, 1200000, NULL, 1, NULL, NULL, GETDATE(), 1, 3, 9);
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Pool Villa', 'Private villa with pool access', 2, 'people', 'PV01', '2023-03-14', '2023-03-16', 3000000, 3500000, NULL, 1, NULL, NULL, GETDATE(), 1, 3, 9);
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Meeting Room 1', 'Suitable for small meetings', 20, 'people', 'M01', '2023-03-14', '2023-03-16', 1500000, 2000000, NULL, 1, NULL, NULL, GETDATE(), 3, 3, 9);
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Gym', 'Fully equipped gym with personal trainer', 50, 'people', 'G01', '2023-03-14', '2023-03-16', 750000, 1000000, NULL, 1, 20, 10, GETDATE(), 4, 3, 9);
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Sauna', 'Relaxing sauna for your wellness', 10, 'people', 'S01', '2023-03-14', '2023-03-16', 300000, 400000, NULL, 1, NULL, NULL, GETDATE(), 6, 3, 9);
INSERT INTO Hotel.Facilities 
(faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_enddate, faci_low_price, faci_high_price, faci_rate_price, faci_expose_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES 
('Ballroom', 'Elegant ballroom for your event', 100, 'people', 'B01', '2023-03-14', '2023-03-16', 10000000, 15000000, NULL, 1, 10, 10, GETDATE(), 7, 3, 9);


--* DATA Facility Photos *--
INSERT INTO Hotel.Facility_Photos (fapho_photo_filename, fapho_thumbnail_filename, fapho_original_filename, fapho_file_size, fapho_file_type, fapho_primary, fapho_url, fapho_modified_date, fapho_faci_id)
SELECT 'photo1.jpg', 'thumb1.jpg', 'orig1.jpg', 1024, 'jpg', 0, 'https://example.com/photo1.jpg', GETDATE(), faci_id FROM Hotel.Facilities
UNION ALL
SELECT 'photo2.jpg', 'thumb2.jpg', 'orig2.jpg', 2048, 'jpg', 0, 'https://example.com/photo2.jpg', GETDATE(), faci_id FROM Hotel.Facilities
UNION ALL
SELECT 'photo3.jpg', 'thumb3.jpg', 'orig3.jpg', 3072, 'jpg', 0, 'https://example.com/photo3.jpg', GETDATE(), faci_id FROM Hotel.Facilities;

DECLARE @fapho_id INT
DECLARE @fapho_faci_id INT

DECLARE curFacilityPhotos CURSOR FOR
SELECT fapho_id, fapho_faci_id
FROM Hotel.Facility_Photos

OPEN curFacilityPhotos

FETCH NEXT FROM curFacilityPhotos INTO @fapho_id, @fapho_faci_id

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Hotel.Facility_Photos
    SET fapho_primary = 0
    WHERE fapho_id = @fapho_id AND fapho_faci_id = @fapho_faci_id
    
    FETCH NEXT FROM curFacilityPhotos INTO @fapho_id, @fapho_faci_id
END

CLOSE curFacilityPhotos
DEALLOCATE curFacilityPhotos;
-- SELECT * FROM Hotel.Facility_Photos WHERE fapho_faci_id=1
-- END OF HOTEL --

-- INSERT MODULE HR
SET IDENTITY_INSERT hr.job_role ON
insert into hr.job_role (joro_id, joro_name, joro_modified_date) values
	(1,'Resepsionis', GETDATE()),
	(2,'Porter', GETDATE()),
	(3,'Concierge', GETDATE()),
	(4,'Room Service', GETDATE()),
	(5,'Waiter', GETDATE()),
	(6,'Staff Dapur', GETDATE()),
	(7,'Housekeeper', GETDATE()),
	(8,'Room Division Manager', GETDATE()),
	(9,'Maintenance Staff', GETDATE()),
	(10,'Hotel Manager', GETDATE()),
	(11,'Purchasing', GETDATE()),
	(12,'Sales & Marketing', GETDATE()),
	(13,'Event Planner', GETDATE()),
	(14,'Akuntan', GETDATE());
SET IDENTITY_INSERT hr.job_role OFF
-- select * from hr.job_role;

SET IDENTITY_INSERT hr.employee ON
insert into hr.employee (emp_id, emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date,
	emp_salaried_flag, emp_joro_id) values
	(1, 'a123123123456456456789789', '2001-01-01', 'S', 'M', GETDATE(), '1', 1),
	(2, 'b456456456123123123789789', '2002-02-01', 'M', 'F', GETDATE(), '0', 2),
	(3, 'c231231231339339339013013', '2003-03-01', 'M', 'M', GETDATE(), '1', 3),
	(4, 'd524524524621621621832832', '1999-04-01', 'S', 'F', GETDATE(), '0', 4),
	(5, 'e122122122322322322494944', '1997-05-01', 'S', 'M', GETDATE(), '1', 5),
	(6, 'f090285082940243284423853', '1999-06-01', 'M', 'F', GETDATE(), '0', 6),
	(7, 'g122932483892095343534255', '1998-07-01', 'M', 'M', GETDATE(), '1', 7),
	(8, 'h214392573294812743928523', '2002-08-01', 'S', 'F', GETDATE(), '0', 8),
	(9, 'i217473298498378988932754', '1999-09-01', 'S', 'M', GETDATE(), '1', 9),
	(10, 'j219483945782893873249573', '2001-10-01', 'M', 'F', GETDATE(), '0', 10)
;
SET IDENTITY_INSERT hr.employee OFF
-- select * from hr.employee;

SET IDENTITY_INSERT hr.shift ON
insert into hr.shift(shift_id, shift_name, shift_start_time, shift_end_time) values
	(1,'Shift 1', '08:00:00', '16:00:00'),
	(2,'Shift 2', '16:00:00', '00:00:00'),
	(3,'Shift 3', '00:00:00', '08:00:00')
;
SET IDENTITY_INSERT hr.shift OFF
-- select * from hr.shift;

SET IDENTITY_INSERT hr.department ON
insert into hr.department(dept_id, dept_name, dept_modified_date)values
	(1, 'Front Office', GETDATE()),
	(2, 'Security', GETDATE()),
	(3, 'Marketing', GETDATE()),
	(4, 'Accounting', GETDATE()),
	(5, 'Food and Beverage', GETDATE()),
	(6, 'Housekeeping', GETDATE()),
	(7, 'Purchasing', GETDATE()),
	(8, 'Engineering', GETDATE()),
	(9, 'Personalia (HRD)', GETDATE())
;
SET IDENTITY_INSERT hr.department OFF
-- select * from hr.department;

SET IDENTITY_INSERT hr.employee_department_history ON
insert into hr.employee_department_history(edhi_id, edhi_emp_id, edhi_dept_id, edhi_shift_id) values
	(1,1, 1, 1),
	(2,2, 2, 2),
	(3,3, 3, 3),
	(4,4, 4, 1),
	(5,5, 5, 2),
	(6,6, 6, 3),
	(7,7, 7, 1),
	(8,8, 8, 2),
	(9,9, 9, 3),
	(10,10, 2, 1)
;
SET IDENTITY_INSERT hr.employee_department_history OFF
-- select * from hr.employee_department_history;

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
-- select * from hr.employee_pay_history;

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
-- select * from hr.work_orders

SET IDENTITY_INSERT HR.work_order_detail ON;
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('1', 'work detail 1', 'INPROGRESS', '1995-01-14', '1995-03-14', 'Masih Bekerja', '2', '2', '1', '2');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('2', 'work detail 2', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '3', '1', '2', '1');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('3', 'work detail 3', 'CANCELLED', '1995-01-14', '1995-03-14', 'Ada Kenadala', '4', '1', '5', '3');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('4', 'work detail 4', 'INPROGRESS', '1995-01-14', '1995-03-14', 'Masih Bekerja', '6', '3', '9', '5');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('5', 'work detail 5', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '5', '4', '8', '6');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('6', 'work detail 6', 'CANCELLED', '1995-01-14', '1995-03-14', 'Ada Kenadala', '5', '5', '7', '7');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('7', 'work detail 7', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '10', '4', '1', '10');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('8', 'work detail 8', 'CANCELLED', '1995-01-14', '1995-03-14', 'Ada Kenadala', '10', '1', '2', '1');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('9', 'work detail 9', 'COMPLETED', '1995-01-14', '1995-03-14', 'Selesai', '4', '3', '2', '5');
Insert into HR.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) values ('10', 'work detail 10', 'INPROGRESS', '1995-01-14', '1995-03-14', 'Masih Bekerja', '4', '5', '6', '4');
SET IDENTITY_INSERT HR.work_order_detail OFF;
-- select * from hr.work_order_detail;

-- INSERT MODULE Booking
SET IDENTITY_INSERT Booking.special_offers ON
INSERT INTO Booking.special_offers (spof_id, spof_name, spof_description, spof_type, spof_discount, spof_start_date, spof_end_date, spof_min_qty, spof_max_qty, spof_modified_date)
VALUES (1, 'Winter Sale', 'Get 20% off your stay when you book a room during the winter months', 'T', 0.2, '2022-12-01', '2023-03-31', 1, 3, GETDATE()),
       (2, 'Weekend Getaway Deal', 'Stay two nights on the weekend and get 20% for the next night', 'C', 0.2 , '2022-12-01', '2023-03-31', 3, 5, GETDATE()),
       (3, 'Early Bird Special', 'Book at least 30 days in advance and save 15% on your stay', 'I', 0.15, '2022-12-01', '2023-03-31', 1, 2, GETDATE()),
       (4, 'Family Fun Package', 'Book a family room and get free breakfast for the kids', 'T', 0, '2022-12-01', '2023-03-31', 4, 6, GETDATE()),
       (5, 'Romance Package', 'Book a romantic getaway for two and get a bottle of champagne upon arrival', 'C', 0, '2022-12-01', '2023-03-31', 2, 5, GETDATE()),
       (6, 'Last Minute Deal', 'Book within 48 hours of arrival and save 20% on your stay', 'I', 0.2, '2022-12-01', '2023-03-31', 1, 3, GETDATE()),
       (7, 'AAA/CAA Discount', 'Show your AAA or CAA membership card and get 10% off your stay', 'T', 0.2 , '2022-12-01', '2023-03-31', 1, 3, GETDATE()),
       (8, 'Senior Discount', 'Guests 65 and over receive 10% off their stay', 'C', 0.1, '2022-12-01', '2022-03-31', 1, 3, GETDATE()),
       (9, 'Military Discount', 'Active duty military personnel receive 15% off their stay', 'I', 0.15, '2022-12-01', '2023-03-31', 1, 3, GETDATE())
SET IDENTITY_INSERT Booking.special_offers OFF
-- SELECT*FROM Booking.special_offers
-- select * from Booking.special_offers;


SET IDENTITY_INSERT Booking.booking_orders ON
INSERT INTO Booking.booking_orders (boor_id,boor_order_number, 	boor_order_date, boor_total_room, boor_total_ammount, boor_down_payment,
                                    boor_pay_type,boor_is_paid,boor_type, boor_cardnumber, boor_user_id,boor_hotel_id)
VALUES (1, 'BO#20221127-0001', '2023-01-27', 3,500000,200000,'D', 'DP', 'T', '431-2388-93', 1, 1),
       (2, 'BO#20221127-0002', '2023-01-27', 4,300000,0,'C', 'P', 'C', '123-2993-32',2, 2),
       (3, 'BO#20221127-0003', '2023-01-27', 4,300000,200000,'D', 'DP', 'T', '087363155421',4, 3),
       (4, 'BO#20221127-0004', '2023-01-27', 4,150000,50000,'PG', 'DP', 'C', '11-1111-1111', 8, 4),
       (5, 'BO#20221127-0005', '2023-01-27', 4,500000,2000,'C', 'P', 'C', '571-2939-23', 7, 5)
SET IDENTITY_INSERT Booking.booking_orders OFF
-- SELECT*FROM Booking.booking_orders

SET IDENTITY_INSERT Booking.booking_order_detail ON
INSERT INTO Booking.booking_order_detail (borde_boor_id, borde_id, borde_checkin, borde_checkout, borde_adults, borde_kids, borde_price, borde_extra, borde_discount, borde_tax, borde_faci_id)
VALUES (1, 1, '2022-11-27', '2022-11-28', 2, 0, 100, 0, 0, 10, 5),
       (1, 2, '2022-11-27', '2022-11-28', 2, 1, 120, 20, 10, 12, 6),
       (2, 3, '2022-11-27', '2022-11-28', 3, 0, 150, 30, 20, 15, 7),
       (2, 4, '2022-11-27', '2022-11-28', 2, 2, 200, 40, 30, 20, 5),
       (3, 5, '2022-11-27', '2022-11-28', 1, 1, 250, 50, 40, 25, 5),
       (3, 6, '2022-11-27', '2022-11-28', 4, 0, 300, 60, 50, 30, 5),
       (4, 7, '2022-11-27', '2022-11-28', 2, 3, 350, 70, 60, 35, 6),
       (4, 8, '2022-11-27', '2022-11-28', 3, 2, 400, 80, 70, 40, 8),
       (5, 9, '2022-11-27', '2022-11-28', 1, 4, 450, 90, 80, 45, 6),
       (5, 10, '2022-11-27', '2022-11-28', 4, 1, 500, 100, 90, 50, 6)
SET IDENTITY_INSERT Booking.booking_order_detail OFF
-- SELECT*FROM Booking.booking_order_detail


SET IDENTITY_INSERT Booking.booking_order_detail_extra ON
INSERT INTO Booking.booking_order_detail_extra (boex_id, boex_price, boex_qty, boex_measure_unit, boex_borde_id, boex_prit_id)
VALUES (1, 10, 2, 'people', 1, 1),
       (2, 15, 3, 'unit', 2, 2),
       (3, 20, 4, 'kg', 3, 3),
       (4, 25, 5, 'people', 4, 4),
       (5, 30, 6, 'unit', 5, 5),
       (6, 35, 7, 'kg', 6, 5),
       (7, 40, 8, 'people', 7, 3),
       (8, 45, 9, 'unit', 8, 4),
       (9, 50, 10, 'kg', 9, 3),
       (10, 55, 11, 'people', 10, 2)
SET IDENTITY_INSERT Booking.booking_order_detail_extra OFF
-- SELECT*FROM Booking.booking_order_detail_extra

SET IDENTITY_INSERT Booking.special_offer_coupons ON
INSERT INTO Booking.special_offer_coupons (soco_id, soco_borde_id, soco_spof_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5),
       (6, 6, 6),
       (7, 7, 7),
       (8, 8, 8)
SET IDENTITY_INSERT Booking.special_offer_coupons OFF
-- SELECT*FROM Booking.special_offer_coupons

INSERT INTO Booking.user_breakfast (usbr_borde_id, usbr_modified_date, usbr_total_vacant)
VALUES
    (1,'2022-11-27',1),
    (2,'2022-11-27',  2),
    (3,'2022-11-27',  3),
    (4,'2022-11-27',  2),
    (5,'2022-11-27',  1),
    (6,'2022-11-27',  4),
    (7,'2022-11-27',  2),
    (8,'2022-11-27',  3),
    (9,'2022-11-27',  1),
    (10, '2022-11-27', 4)
-- select * from Booking.user_breakfast

-- INSERT MODULE RESTO
--resto.resto_menus
SET IDENTITY_INSERT resto.resto_menus ON
INSERT INTO resto.resto_menus
	(reme_id, reme_faci_id, reme_name, reme_description, reme_price, reme_status, reme_modified_date)
VALUES
	(1, 2, 'Nasi Goreng', 'Nasi goreng dengan bahan dasar nasi yang ditumis bersama telur dan sayuran', 15000, 'Available', GETDATE()),
	(2, 2, 'Soto Ayam', 'Soto ayam dengan kuah yang gurih dan daging ayam yang empuk', 20000, 'Available', GETDATE()),
	(3, 2, 'Gado-gado', 'Gado-gado dengan bahan dasar lontong dan sayuran-sayuran segar', 10000, 'Available', GETDATE()),
	(4, 2, 'Bakso', 'Bakso dengan daging sapi yang dipotong-potong dan dimasak dengan bumbu khusus', 15000, 'Available', GETDATE()),
	(5, 2, 'Ayam Goreng', 'Ayam goreng dengan tepung yang renyah dan daging ayam yang empuk', 25000, 'Available', GETDATE()),
	(6, 2, 'Sate Ayam', 'Sate ayam dengan bumbu kacang yang lezat', 20000, 'Available', GETDATE()),
	(7, 2, 'Nasi Kuning', 'Nasi kuning dengan bahan dasar nasi yang dicampur dengan telur dan kecap', 10000, 'Available', GETDATE()),
	(8, 2, 'Sop Buntut', 'Sop buntut dengan bahan dasar daging buntut yang empuk dan kuah yang gurih', 30000, 'Available', GETDATE()),
	(9, 2, 'Bubur Ayam', 'Bubur ayam dengan bahan dasar nasi yang dicampur dengan daging ayam dan sayuran', 10000, 'Available', GETDATE()),
	(10, 2, 'Mie Goreng', 'Mie goreng dengan bahan dasar mie yang ditumis bersama telur dan sayuran', 15000, 'Available', GETDATE()),
	(11, 2, 'Cap Cay', 'Cap cay dengan bahan dasar sayuran yang dicampur dengan daging sapi dan kuah kaldu', 20000, 'Available', GETDATE());
SET IDENTITY_INSERT resto.resto_menus OFF
-- SELECT*FROM resto.resto_menus;

--resto.order_menu
SET IDENTITY_INSERT resto.order_menus ON
INSERT INTO resto.order_menus (orme_id, orme_order_number, orme_order_date, orme_total_item,
                               orme_total_discount, orme_total_amount, orme_pay_type,
                               orme_cardnumber, orme_is_paid, orme_modified_date, orme_user_id)
VALUES (1, 'MENUS#20220101-00001', '2022-01-01', 2, 0, 40000, 'D', '431-2388-93', 'P', GETDATE(), 1),
(2,'MENUS#20220101-00002', '2022-01-01', 3, 5000, 75000, 'CR', '123-2993-32', 'P', GETDATE(), 2),
(3,'MENUS#20220101-00003', '2022-01-01', 4, 0, 80000, 'PG', '11-1111-1111', 'P', GETDATE(), 8),
(4,'MENUS#20220101-00004', '2022-01-01', 5, 0, 100000, 'C', NULL, 'B', GETDATE(), 4),
(5,'MENUS#20220101-00005', '2022-01-01', 6, 0, 120000, 'CR', '889-3921-22', 'P', GETDATE(), 6),
(6,'MENUS#20220101-00006', '2022-01-01', 7, 0, 140000, 'PG', '0873635251525', 'P', GETDATE(), 9);
SET IDENTITY_INSERT resto.order_menus OFF
-- SELECT*FROM resto.order_menus;

--resto order menu detail
SET IDENTITY_INSERT resto.order_menu_detail ON
INSERT INTO resto.order_menu_detail (omde_id, orme_price, orme_qty, orme_discount, omde_orme_id, omde_reme_id)
VALUES
(1, 10000, 2, 0, 1, 1),
(2, 12000, 3, 0, 1, 2),
(3, 15000, 2, 0, 2, 3),
(4, 20000, 4, 0, 2, 4),
(5, 10000, 3, 0, 3, 5),
(6, 15000, 1, 0, 3, 6),
(7, 20000, 3, 0, 4, 11),
(8, 12000, 2, 0, 4, 2),
(9, 10000, 4, 0, 5, 3),
(10, 15000, 2, 0, 5, 4);
SET IDENTITY_INSERT resto.order_menu_detail OFF
-- SELECT*FROM resto.order_menu_detail;

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
-- SELECT*FROM resto.resto_menu_photos;

-- INSERT MODULE Payment
-- insert entity
SET IDENTITY_INSERT Payment.entity ON
INSERT
  INTO Payment.entity(entity_id)
VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25);
SET IDENTITY_INSERT Payment.Entity OFF;
-- SELECT*FROM payment.entity;

-- insert bank
DISABLE TRIGGER [Payment].[InsertBankEntityId] ON [Payment].bank;
INSERT
  INTO Payment.bank (bank_entity_id, bank_code, bank_name, bank_modified_date)
VALUES (1, '002', 'BRI', CURRENT_TIMESTAMP),
       (2, '009', 'BNI', CURRENT_TIMESTAMP),
       (3, '014', 'BCA', CURRENT_TIMESTAMP),
       (4, '427', 'BSI', CURRENT_TIMESTAMP),
       (5, '200', 'BTN', CURRENT_TIMESTAMP),
       (6, '008', 'MANDIRI', CURRENT_TIMESTAMP),
       (7, '147', 'MUAMALAT', CURRENT_TIMESTAMP);
ENABLE TRIGGER [Payment].[InsertBankEntityId] ON [Payment].bank;

-- SELECT*FROM payment.bank;

-- insert payment_gateway
DISABLE TRIGGER [Payment].[InsertPaymentEntityId] ON [Payment].payment_gateway;
INSERT
  INTO Payment.payment_gateway(paga_entity_id, paga_code, paga_name, paga_modified_date)
VALUES (8, 'GOTO', 'PT. Dompet Anak Bangsa', CURRENT_TIMESTAMP),
       (9, 'OVO', 'PT. Visionet Internasional', CURRENT_TIMESTAMP),
       (10, 'DANA', 'PT. Espay Debit Indonesia', CURRENT_TIMESTAMP),
       (11, 'SHOPEEPAY', 'Shopee', CURRENT_TIMESTAMP),
       (12, 'FLIP', 'Fintek Karya Nusantara', CURRENT_TIMESTAMP),
       (13, 'JENIUS', 'PT. Bank BTPN Tbk', CURRENT_TIMESTAMP),
       (14, 'JAGO', 'PT. Bank Jago Tbk', CURRENT_TIMESTAMP),
       (15, 'SAKUKU', 'PT. Bank Central Asia Tbk', CURRENT_TIMESTAMP);
ENABLE TRIGGER [Payment].[InsertPaymentEntityId] ON [Payment].payment_gateway;

-- SELECT*FROM payment.payment_gateway;

SET IDENTITY_INSERT Payment.user_accounts ON
-- user_accounts
INSERT
  INTO Payment.user_accounts(usac_id, usac_entity_id, usac_user_id, usac_account_number, usac_saldo, usac_type, usac_expmonth, usac_expyear, usac_modified_date)
VALUES (1, 1, 1, '431-2388-93', 1000000, 'debet', 11, 22, CURRENT_TIMESTAMP),
       (2, 1, 2, '123-2993-32', 0, 'credit_card', 12, 27, CURRENT_TIMESTAMP),
       (3, 3, 3, '131-3456-78', 0, 'debet', 05, 25, CURRENT_TIMESTAMP), -- Hotel Realta Account
       (4, 4, 4, '992-1923-39', 1000000, 'debet', 08, 24, CURRENT_TIMESTAMP),
       (5, 5, 5, '727-1931-34', 0, 'debet', 09, 28, CURRENT_TIMESTAMP),
       (6, 6, 6, '889-3921-22', 0, 'credit_card', 02, 25, CURRENT_TIMESTAMP),
       (7, 7, 7, '571-2939-23', 1000000, 'debet', 01, 26, CURRENT_TIMESTAMP),
       (8, 8, 8, '11-1111-1111', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (9, 9, 9, '0873635251525', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (10, 10, 10, '081289389126', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (11, 11, 4, '087363155421', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (12, 12, 12, '087365291212', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (13, 13, 13, '081928222364', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (14, 14, 14, '089012852546', 500000, 'payment', null, null, CURRENT_TIMESTAMP),
       (15, 15, 15, '085627287172', 500000, 'payment', null, null, CURRENT_TIMESTAMP);
SET IDENTITY_INSERT Payment.user_accounts OFF
-- SELECT*FROM payment.user_accounts;

-- payment_transactions
-- SET IDENTITY_INSERT Payment.payment_transaction ON
-- DISABLE TRIGGER [Payment].[CalculateUserAccountCredit] ON [Payment].[payment_transaction];

-- pay_type 'debet'
EXECUTE [Payment].[spCreateTransferBooking]
       'BO#20221127-0001'
       ,'431-2388-93'
       ,1
GO

-- pay_type 'cash',  ignored
EXECUTE [Payment].[spCreateTransferBooking]
       'BO#20221127-0002'
       ,'123-2993-32'
       ,1
GO

-- transaction order_menus, pay_type 'debet'
EXECUTE [Payment].[spCreateTransferOrderMenu]
       'MENUS#20220101-00001'
       ,'431-2388-93'
       ,1
GO

EXECUTE [Payment].[spCreateTransferRefund]
    'BO#20221127-0001',
    1
GO
-- INSERT
--   INTO Payment.payment_transaction(patr_debet, patr_credit, patr_type, patr_note, patr_modified_date,
--                                   patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
-- VALUES (0, 769999, 'TRB', 'Tranfer Booking Note', CURRENT_TIMESTAMP, 'BO#20221127-0001', '431-2388-93', '131-3456-78', null, 1);
-- INSERT
--   INTO Payment.payment_transaction(patr_debet, patr_credit, patr_type, patr_note, patr_modified_date,
--                                   patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
-- VALUES (0, 100000, 'ORM', 'Order Menu', CURRENT_TIMESTAMP, 'MENUS#20221127-0001', '123-2993-32', '131-3456-78', null, 2);
-- INSERT
--   INTO Payment.payment_transaction(patr_debet, patr_credit, patr_type, patr_note, patr_modified_date,
--                                   patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
-- VALUES (0, 235000, 'TP', 'Top Up Note', CURRENT_TIMESTAMP,  null, '992-1923-39', '087363155421', null, 4);
-- INSERT
--   INTO Payment.payment_transaction(patr_debet, patr_credit, patr_type, patr_note, patr_modified_date,
--                                   patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
-- VALUES (0, 0, 'RF', '*Refund Order Menu', CURRENT_TIMESTAMP,  null, null, null, Payment.fnFormatedTransactionId(3, 'ORM'), 2);

-- SET IDENTITY_INSERT Payment.payment_transaction OFF;
-- ENABLE TRIGGER [Payment].CalculateUserAccountCredit ON [Payment].payment_transaction;
-- SELECT*FROM payment.payment_transaction; debet 869999.0000

-- PURCHASING INSERT
DISABLE TRIGGER [Purchasing].[InsertVendorEntityId] ON [Purchasing].vendor;
INSERT INTO purchasing.vendor (vendor_entity_id, vendor_name, vendor_active, vendor_priority, vendor_weburl)
VALUES (16,'Global Equipment Co.', 1, 0, 'www.globalequipment.com'),
	   (17,'Sustainable Solutions Inc.', 1, 1, 'www.sustainablesolutions.com'),
	   (18,'Quality Parts LLC', 1, 0, 'www.qualityparts.com'),
	   (19,'Innovative Technologies Corp.', 0, 1, 'www.innovativetechnologies.com'),
	   (20,'Dynamic Enterprises Inc.', 1, 0, 'www.dynamicenterprises.com'),
	   (21,'Elite Supplies Co.', 1, 1, 'www.elitesupplies.com'),
	   (22,'Superior Products LLC', 0, 0, 'www.superiorproducts.com'),
	   (23,'Advanced Materials Inc.', 1, 1, 'www.advancedmaterials.com'),
	   (24,'Bright Ideas Inc.', 1, 0, 'www.brightideas.com'),
	   (25,'Progressive Solutions Inc.', 0, 1, 'www.progressivesolutions.com');
ENABLE TRIGGER [Purchasing].[InsertVendorEntityId] ON [Purchasing].vendor;
-- UPDATE purchasing.vendor SET vendor_priority = 0 where vendor_id=1
-- SELECT*FROM Purchasing.vendor;

SET IDENTITY_INSERT purchasing.stocks ON;
INSERT INTO purchasing.stocks (stock_id, stock_name, stock_description, stock_size, stock_color)
VALUES
  (1, 'Sprei Hotel', 'Sprei dengan bahan yang nyaman dan tahan lama', 'King', 'Putih'),
  (2, 'Bantal Hotel', 'Bantal dengan bahan yang nyaman dan tahan lama', 'Standard', 'Putih'),
  (3, 'Handuk Hotel', 'Handuk dengan bahan yang nyaman dan tahan lama', 'Standard', 'Putih'),
  (4, 'Gorden Hotel', 'Gorden dengan bahan yang tahan lama dan mudah dicuci', 'Standard', 'Putih'),
  (5, 'Gelas Hotel', 'Gelas dengan bahan yang tahan lama dan mudah dicuci', 'Standard', 'Transparan');
SET IDENTITY_INSERT purchasing.stocks OFF;
--  SELECT*FROM purchasing.stocks;

SET IDENTITY_INSERT purchasing.vendor_product ON;
INSERT INTO purchasing.vendor_product (vepro_id, vepro_qty_stocked, vepro_qty_remaining, vepro_price, venpro_stock_id, vepro_vendor_id)
VALUES (1, 3, 2, 1000000, 1, 25),
	   (2, 5, 6, 2000000, 2, 24),
	   (3, 2, 2, 3000000, 3, 23),
	   (4, 4, 4, 4000000, 4, 22),
	   (5, 8, 9, 5000000, 5, 21),
	   (6, 1, 9, 5000000, 5, 20),
	   (7, 6, 7, 7000000, 4, 19),
	   (8, 1, 5, 8000000, 3, 18),
	   (9, 4, 5, 9000000, 2, 17),
	   (10, 2, 3, 10000000, 1, 16);
SET IDENTITY_INSERT purchasing.vendor_product OFF;
-- UPDATE purchasing.vendor SET vendor_priority = 0 where vendor_id=1
-- SELECT*FROM Purchasing.vendor_product;

SET IDENTITY_INSERT purchasing.purchase_order_header ON;
INSERT INTO purchasing.purchase_order_header (pohe_id, pohe_number, pohe_status, pohe_refund, pohe_pay_type, pohe_emp_id, pohe_vendor_id)
VALUES
  (1, 'PO-20230115-001', 1, 0, 'CA', 1, 16),
  (2, 'PO-20230115-002', 1, 0, 'CA', 1, 17),
  (3, 'PO-20230115-003', 1, 0, 'TR', 1, 18),
  (4, 'PO-20230115-004', 1, 0, 'TR', 1, 19),
  (5, 'PO-20230115-005', 1, 0, 'CA', 1, 20);
SET IDENTITY_INSERT purchasing.purchase_order_header OFF;
-- SELECT*FROM Purchasing.purchase_order_header;

INSERT INTO purchasing.stock_detail (stod_stock_id, stod_barcode_number, stod_status, stod_notes, stod_faci_id, stod_pohe_id)
VALUES
  (1, 'Barcode Sprei 1', 2, 'Sprei di kamar 101', 1, 1),
  (2, 'Barcode Bantal 1', 3, 'Bantal di kamar 106', 2, 2),
  (3, 'Barcode Handuk 10', 1, 'Handuk di kamar 115', 3, 3),
  (4, 'Barcode Gorden 5', 1, 'Gorden di kamar 120', 4, 4),
  (5, 'Barcode Gelas 5', 1, 'Gelas di kamar 125', 5, 5);
-- SELECT*FROM Purchasing.stock_detail;

INSERT INTO purchasing.stock_photo (spho_thumbnail_filename, spho_photo_filename, spho_primary, spho_url, spho_stock_id)
VALUES
  ('thumbnail-1.jpg', 'photo-1.jpg', 1, 'https://stock-photos.com/thumbnail-1.jpg', 1),
  ('thumbnail-2.jpg', 'photo-2.jpg', 0, 'https://stock-photos.com/thumbnail-2.jpg', 2),
  ('thumbnail-3.jpg', 'photo-3.jpg', 0, 'https://stock-photos.com/thumbnail-3.jpg', 3),
  ('thumbnail-4.jpg', 'photo-4.jpg', 1, 'https://stock-photos.com/thumbnail-4.jpg', 4),
  ('thumbnail-5.jpg', 'photo-5.jpg', 0, 'https://stock-photos.com/thumbnail-5.jpg', 5);
-- SELECT*FROM Purchasing.stock_photo;


SET IDENTITY_INSERT purchasing.purchase_order_detail ON
INSERT INTO purchasing.purchase_order_detail (pode_id, pode_pohe_id, pode_order_qty, pode_price, pode_received_qty, pode_rejected_qty, pode_stock_id)
VALUES
  (1, 1, 10, 100000, 9, 1, 1),
  (2, 2, 50, 300000, 48, 2, 5),
  (3, 3, 60, 350000, 57, 3, 1),
  (4, 4, 100, 550000, 97, 3, 5),
  (5, 5, 110, 600000, 107, 3, 1);
SET IDENTITY_INSERT purchasing.purchase_order_detail OFF
-- SELECT*FROM Purchasing.purchase_order_detail;

-- SET IDENTITY_INSERT purchasing.cart ON
INSERT INTO purchasing.cart (cart_emp_id, cart_vepro_id, cart_order_qty)
VALUES (1, 1, 2),
	   (1, 2, 1),
	   (3, 3, 3),
	   (4, 4, 2),
	   (5, 5, 1)
-- SET IDENTITY_INSERT purchasing.cart OFF
-- SELECT*FROM purchasing.cart;

USE tempdb;
