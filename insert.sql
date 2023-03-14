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

-- RESET IDENT MODULE Master
DBCC CHECKIDENT ('Master.regions', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.country', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.provinces', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.address', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.price_items', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.members', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.service_task', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.category_group', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.policy', RESEED, 1);
GO
DBCC CHECKIDENT ('Master.policy_category_group', RESEED, 1);
GO

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
VALUES ('1','Asia'), ('2','Europe'), ('3','North America'), ('4','South America'), ('5','Africa')
SET IDENTITY_INSERT Master.Regions OFF;
-- SELECT*FROM Master.Regions
-- ORDER by region_code ASC

SET IDENTITY_INSERT Master.Country ON;
INSERT INTO Master.country (country_id, country_name, country_region_id) VALUES 
(1, 'Indonesia', 1), (2, 'Thailand', 1), (3, 'Japan', 1), (4, 'Germany', 2), (5, 'France', 2),
(6, 'United States', 3), (7, 'Canada', 3), (8, 'Brazil', 4), (9, 'Argentina', 4), (10, 'South Africa', 5);
SET IDENTITY_INSERT Master.Country OFF;
-- SELECT*FROM Master.Country
-- ORDER by country_id ASC

SET IDENTITY_INSERT Master.Provinces ON;
INSERT INTO Master.provinces (prov_id, prov_name, prov_country_id) VALUES 
(1, 'Jakarta', 1), 
(2, 'Bali', 1), 
(3, 'Chiang Mai', 2), 
(4, 'Tokyo', 3), 
(5, 'Berlin', 4),
(6, 'Paris', 5), 
(7, 'California', 6), 
(8, 'New York', 6), 
(9, 'Ontario', 7), 
(10, 'Sao Paulo', 8),
(11, 'Buenos Aires', 9), 
(12, 'Cape Town', 10), 
(13, 'Durban', 10), 
(14, 'Gauteng', 10), 
(15, 'Nairobi', 3);
SET IDENTITY_INSERT Master.Provinces OFF;
SET IDENTITY_INSERT Payment.payment_transaction OFF;

-- SELECT*FROM Master.provinces
-- ORDER BY prov_id


SET IDENTITY_INSERT Master.Address ON;
INSERT INTO Master.address (addr_id, addr_line1, addr_line2, addr_city, addr_postal_code, addr_spatial_location, addr_prov_id) VALUES
(1, 'Jl. Sudirman No.1', NULL, 'Jakarta', '12345', 'POINT(-6.2146 106.8451)', 1),
(2, 'Jl. Raya Kuta No.25', NULL, 'Bali', '54321', 'POINT(-8.7158 115.1702)', 2),
(3, '123 Moo 4, Tambon San Sai Noi', NULL, 'Chiang Mai', '67890', 'POINT(18.8408 98.9611)', 3),
(4, '1-1-1 Shibuya', NULL, 'Tokyo', '01234', 'POINT(35.6581 139.7414)', 4),
(5, '10 Unter den Linden', NULL, 'Berlin', '23456', 'POINT(52.5166 13.3833)', 5),
(6, '55 Rue du Faubourg Saint-Honoré', NULL, 'Paris', '34567', 'POINT(48.8714 2.3074)', 6),
(7, '123 Main St', NULL, 'Los Angeles', '45678', 'POINT(34.0522 -118.2437)', 7),
(8, '456 Park Ave', NULL, 'New York', '56789', 'POINT(40.7711 -73.9742)', 8),
(9, '789 King St W', NULL, 'Toronto', '67890', 'POINT(43.6468 -79.3933)', 9),
(10, '123 Avenida Paulista', NULL, 'Sao Paulo', '78901', 'POINT(-23.5674 -46.6476)', 10),
(11, '456 Calle Florida', NULL, 'Buenos Aires', '89012', 'POINT(-34.6037 -58.3816)', 11),
(12, '123 Long St', NULL, 'Cape Town', '90123', 'POINT(-33.9189 18.4232)', 12),
(13, '456 Durban Rd', NULL, 'Durban', '01234', 'POINT(-29.8587 31.0218)', 13),
(14, '789 Oxford Rd', NULL, 'Johannesburg', '12345', 'POINT(-26.2041 28.0473)', 14),
(15, '123 Uhuru Hwy', NULL, 'Nairobi', '23456', 'POINT(-1.2921 36.8219)', 15);
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
INSERT INTO Master.policy (poli_id,poli_name, poli_description)
VALUES
('1','Early Check-In Policy', 'Policy related to early check-in requests'),
('2','Late Check-Out Policy', 'Policy related to late check-out requests'),
('3','Extra Person Policy', 'Policy related to additional guests in the room'),
('4','Parking Policy', 'Policy related to parking facilities'),
('5','Room Service Policy', 'Policy related to room service requests');
SET IDENTITY_INSERT Master.policy OFF;
-- SELECT*FROM Master.policy
-- ORDER BY poli_id ASC

--PRICE_ITEM
SET IDENTITY_INSERT Master.price_items ON;

INSERT INTO Master.price_items (prit_id, prit_name, prit_price, prit_description, prit_type, prit_icon_url)
VALUES 
  (1, 'Minuman Soda', 15000, 'Minuman soda dingin dalam kaleng', 'SOFTDRINK', 'https://example.com/soda.png'),
  (2, 'Coklat Panas', 25000, 'Coklat panas dengan marshmallow di atasnya', 'SNACK', 'https://example.com/chocolate.png'),
  (3, 'Layanan Pijat Kepala', 120000, 'Layanan pijat kepala selama 30 menit', 'SERVICE', 'https://example.com/head-massage.png'),
  (4, 'Makanan Ringan', 20000, 'Kemasan makanan ringan berisi keripik, kacang, dan kacang tanah', 'SNACK', 'https://example.com/snacks.png'),
  (5, 'Kamar Mandi Bersih', 50000, 'Layanan kebersihan kamar mandi', 'SERVICE', 'https://example.com/clean-bathroom.png'),
  (6, 'Sepatu Boot Bercahaya', 100000, 'Sepatu boot bercahaya untuk di malam hari', 'FACILITY', 'https://example.com/light-up-boots.png'),
  (7, 'Paket Sarapan', 75000, 'Paket sarapan berisi roti panggang, telur, dan jus jeruk', 'FOOD', 'https://example.com/breakfast.png'),
  (8, 'Layanan Laundry', 80000, 'Layanan laundry untuk satu set pakaian', 'SERVICE', 'https://example.com/laundry.png'),
  (9, 'Sarapan Ala Inggris', 120000, 'Sarapan ala Inggris dengan telur dadar, sosis, dan kentang goreng', 'FOOD', 'https://example.com/english-breakfast.png'),
  (10, 'Minuman Es', 20000, 'Minuman es yang menyegarkan dengan potongan buah-buahan', 'SOFTDRINK', 'https://example.com/iced-drink.png'),
  (11, 'Pijat Badan', 200000, 'Layanan pijat badan selama 60 menit', 'SERVICE', 'https://example.com/full-body-massage.png'),
  (12, 'Makanan Penutup', 35000, 'Pilihan berbagai makanan penutup lezat', 'FOOD', 'https://example.com/dessert.png'),
  (13, 'Sepatu Pantai', 50000, 'Sepatu pantai yang nyaman dan anti selip', 'FACILITY', 'https://example.com/beach-shoes.png'),
  (14, 'Layanan Kebersihan Kamar', 100000, 'Layanan kebersihan kamar untuk satu kali kunjungan', 'SERVICE', 'https://example.com/clean-room.png'),
  (15, 'Minuman Kemasan', 10000, 'Berbagai pilihan minuman dalam kemasan praktis', 'SOFTDRINK', 'https://example.com/packaged-drink.png');
SET IDENTITY_INSERT Master.price_items OFF;
-- SELECT*FROM Master.price_items
-- ORDER BY prit_id ASC

--Policy_Category_Group
INSERT INTO Master.policy_category_group (poca_poli_id, poca_cagro_id)
VALUES
(4, 1),
(2, 2),
(5, 2),
(3, 3),
(1, 4),
(2, 4),
(4, 4),
(5, 4),
(1, 5),
(3, 5),
(4, 5),
(5, 5),
(2, 6),
(4, 6),
(5, 6),
(1, 7),
(3, 7),
(5, 7);

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
	   (3,'Bob Johnson', 'I', 'ABC Inc.', 'bob.johnson@abc.com', '123-456-7892', GETDATE()),
	   (4,'Samantha Williams', 'T', 'Def Corp.', 'samantha.williams@def.com', '123-456-7893', GETDATE()),
	   (5,'Michael Brown', 'C', 'Ghi Inc.', 'michael.brown@ghi.com', '123-456-7894', GETDATE()),
	   (6,'Emily Davis', 'I', 'Jkl Ltd.', 'emily.davis@jkl.com', '123-456-7895', GETDATE()),
	   (7,'William Thompson', 'T', 'Mno Inc.', 'william.thompson@mno.com', '123-456-7896', GETDATE()),
	   (8,'Ashley Johnson', 'C', 'Pqr Corp.', 'ashley.johnson@pqr.com', '123-456-7897', GETDATE()),
	   (9,'David Anderson', 'I', 'Stu Inc.', 'david.anderson@stu.com', '123-456-7898', GETDATE()),
	   (10,'Jessica Smith', 'T', 'Vwx Corp.', 'jessica.smith@vwx.com', '123-456-7899', GETDATE()),
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
(10, 5),
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
INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_rating_star, hotel_phonenumber, hotel_modified_date, hotel_addr_id, hotel_status)
VALUES
('Hotel Amaris Palembang', 'Hotel bintang 3 dengan fasilitas yang lengkap dan modern di Palembang', 3, '+62 823 3456 7891', '2022-01-01', 1, 0),
('Grand Clarion Hotel Palembang', 'Hotel bintang 4 dengan kamar yang luas dan nyaman di Palembang', 4, '+62 823 1234 5678', '2022-02-01', 2, 0),
('Aston Hotel Palembang', 'Hotel bintang 5 dengan fasilitas spa dan kolam renang di Palembang', 5, '+62 823 9012 3456', '2022-03-01', 3, 0),
('Hotel Santika Palembang', 'Hotel bintang 3 dengan fasilitas kelas atas di Palembang', 3, '+62 823 7890 1234', '2022-04-01', 3, 0),
('Ibis Hotel Palembang', NULL, 3, '+62 823 4567 8901', '2022-05-01', 2, 0),
('Grand Mercure Hotel Palembang', 'Hotel bintang 4 dengan fasilitas mewah di Palembang', 4, '+62 823 1234 5679', '2022-06-01', 5, 0),
('Marriott Hotel Palembang', 'Hotel bintang 5 dengan fasilitas spa dan fitness center di Palembang', 5, '+62 823 9012 3457', '2022-07-01', 1, 0),
('Zest Hotel Palembang', 'Hotel bintang 3 dengan desain modern dan nyaman di Palembang', NULL, '+62 823 7890 1235', '2022-08-01', 4, 0),
('The Westin Hotel Palembang', 'Hotel bintang 4 dengan fasilitas kelas atas di Palembang', 4, '+62 823 4567 8902', '2022-09-01', 5, 0),
('Swiss-Belhotel Palembang', 'Hotel bintang 5 dengan fasilitas mewah di Palembang', 5, '+62 823 1234 5680', NULL, 4, 0)

-- select * from Hotel.hotels

INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Pool', 'Outdoor pool with sun loungers and parasols', 100, 'people', 'POOL01', '2022-01-01', '2022-12-31', 50000, 100000, 75000, 25000, 10000, 6, 1, 2); -- POOL

--Checker Trigger
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Restaurant', NULL, 100, 'people', 'REST01', '2022-01-01', '2022-12-31', 40000, 80000, 60000, 25000, 10000, 2, 1, 2) -- RESTAURANT
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Gym', 'Fully equipped gym with treadmills stationary bikes, and weights', 50, 'people', 'GYM01', '2022-01-01', '2022-12-31', 30000, 50000, 40000, 25000, 10000, 4, 1, 2) -- GYM
,('Metting Room', 'Meeting room Luxury, and body treatments', NULL, 'people', 'MTG01', '2022-01-01', '2022-12-31', 80000, 120000, 100000, 25000, 10000, 3, 1, 2) -- MEETING
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2, NULL, 'DLR01', '2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 1, 2)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2,'beds', 'SPR01', '2022-01-01', '2022-01-30', 150000, 180000, 160000, NULL, 10000, 1, 1, 2)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4,'beds', 'FMR01', '2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, NULL, 1, 1, 2)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2,'beds', 'STR01','2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 1, 2)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2,'beds', 'DBR01', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 1, 2)


--DATA 2
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Restaurant', 'Fine dining restaurant serving international cuisine', 100, 'people', 'REST02', '2022-01-01', '2022-12-31', 40000, 80000, 60000, 25000, 10000, 2, 2, 4) -- RESTAURANT
,('Pool', 'Outdoor pool with sun loungers and parasols', 100, 'people', 'POOL02', '2022-01-01', '2022-12-31', 50000, 100000, 75000, 25000, 10000, 6, 2, 4) -- POOL
,('Gym', 'Fully equipped gym with treadmills, stationary bikes, and weights', 50, 'people', 'GYM02', '2022-01-01', '2022-12-31',20000, 30000, 25000, 25000, 10000, 4, 2, 4) -- GYM
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2, 'beds', 'DLR02', '2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 2, 4)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'SPR02', '2022-01-01', '2022-01-30', 150000, 180000, 160000, 25000, 10000, 1, 2, 4)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4, 'beds', 'FMR02', '2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, 10000, 1, 2, 4)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'STR02', '2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 2, 4)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2, 'beds', 'DBR02', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 2, 4)


--DATA 3
INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id, faci_user_id)
VALUES
('Restaurant', 'Fine dining restaurant serving international cuisine', 100, 'people', 'REST03', '2022-01-01', '2022-12-31', 40000, 80000, 60000, 25000, 10000, 2, 3, 7) -- RESTAURANT
,('Swimming Pool', 'Our hotel has a large outdoor swimming pool with a depth of 1.5 meters', 50, 'people', 'POOL3', '2022-01-01', '2022-12-31', 50000, 100000, 75000, 25000, 10000, 6, 3, 7) -- SWIMING POOL
,('Fitness Center', 'Our hotel has a fully equipped fitness center open 24 hours a day', 30, 'people', 'FIT3', '2022-01-01', '2022-12-31', 30000, 50000, 40000, 25000, 10000, 4, 3, 7) -- GYM
,('Aula', 'Our hotel has a traditional Aula that can accommodate up to 10 people', 10, 'people', 'AULA3', '2022-01-01', '2022-12-31', 25000, 35000, 30000, 25000, 10000, 1, 3, 7) -- AULA
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2, 'beds', 'DLR03', '2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 3, 7)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'SPR03', '2022-01-01', '2022-01-30', 150000, 180000, 160000, 25000, 10000, 1, 3, 7)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4, 'beds', 'FMR03', '2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, 10000, 1, 3, 7)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'STR03', '2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 3, 7)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2, 'beds', 'DBR03', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 3, 7)

INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES 
('Pengalaman menginap di hotel ini sangat menyenangkan.', 5, '2022-01-01', 1, 1);

-- THIS CHECKER FOR TRIGGER
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES 
('Saya sangat puas dengan pelayanan di hotel ini.', 4, '2022-01-02', 6, 1);
INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
VALUES 
('Kamar yang kami tempati cukup luas dan bersih, tapi ada beberapa masalah dengan AC yang berisik.', 3, '2022-01-03', 6, 1), 
('Deskripsi ini sengaja di buat untuk pengecekan nilai NULL natinya', 1, NULL, 10, 1);

INSERT INTO Hotel.Facility_Photos (fapho_thumbnail_filename, fapho_photo_filename, fapho_primary, fapho_url, fapho_modified_date, fapho_faci_id)
VALUES ('thumbnail1.jpg', 'photo1.jpg', 1, 'https://example.com/thumbnail1', GETDATE(), 1),
       ('thumbnail2.jpg', 'photo2.jpg', 0, 'https://example.com/thumbnail2', GETDATE(), 1),
       ('thumbnail3.jpg', 'photo3.jpg', 0, 'https://example.com/thumbnail3', GETDATE(), 2),
       ('thumbnail4.jpg', 'photo4.jpg', 1, 'https://example.com/thumbnail4', GETDATE(), 2),
       ('thumbnail5.jpg', 'photo5.jpg', 0, 'https://example.com/thumbnail5', GETDATE(), 3);

INSERT INTO Hotel.Facility_Photos (fapho_thumbnail_filename, fapho_photo_filename, fapho_primary, fapho_url, fapho_modified_date, fapho_faci_id)
VALUES ('thumbnail6.jpg', 'photo6.jpg', 1, 'https://example.com/thumbnail6', GETDATE(), 3);

INSERT INTO Hotel.Facility_Photos (fapho_thumbnail_filename, fapho_photo_filename, fapho_primary, fapho_url, fapho_modified_date, fapho_faci_id)
VALUES ('thumbnail7.jpg', 'photo7.jpg', 1, 'https://example.com/thumbnail7', GETDATE(), 3);



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
INSERT INTO Booking.booking_orders (boor_id, boor_order_number,boor_order_date, boor_total_room ,boor_pay_type, boor_is_paid, boor_type, boor_user_id, boor_hotel_id)
VALUES (1, 'BO#20221127-0001', '2023-01-27', 4,'C', 'DP', 'T', 1, 1),
       (2, 'BO#20221127-0002', '2023-01-27', 4,'C', 'P', 'C', 2, 2),
       (3, 'BO#20221127-0003', '2023-01-27', 4,'D', 'R', 'I', 3, 3),
       (4, 'BO#20221127-0004', '2023-01-27', 4,'C', 'DP', 'T', 4, 4),
       (5, 'BO#20221127-0005', '2023-01-27', 4,'D', 'P', 'C', 5, 5),
       (6, 'BO#20221127-0006', '2023-01-27', 4,'C', 'R', 'I', 6, 6),
       (7, 'BO#20221127-0007', '2023-01-27', 4,'D', 'DP', 'T', 7, 7),
       (8, 'BO#20221127-0008', '2023-01-27', 4,'C', 'P', 'C', 8, 8),
       (9, 'BO#20221127-0009', '2023-01-27', 4,'C', 'R', 'I', 9, 9),
       (10, 'BO#20221127-0010', '2023-01-27', 3,'C', 'DP', 'T', 10, 10),
       (11, 'BO#20221127-0011', '2023-01-27', 3,'D', 'P', 'C', 9, 9),
       (12, 'BO#20221127-0012', '2023-01-27', 3,'D', 'R', 'I', 10, 10),
       (13, 'BO#20221127-0013', '2023-01-27', 3,'D', 'DP', 'T', 7, 7),
       (14, 'BO#20221127-0014', '2023-01-27', 3,'C', 'P', 'C', 2, 1),
       (15, 'BO#20221127-0015', '2023-01-27', 3,'D', 'R', 'I', 8, 5),
       (16, 'BO#20221127-0016', '2023-01-27', 3,'D', 'DP', 'T', 7, 6),
       (17, 'BO#20221127-0017', '2023-01-27', 3,'C', 'P', 'C', 1, 7)
SET IDENTITY_INSERT Booking.booking_orders OFF
-- SELECT*FROM Booking.booking_orders

SET IDENTITY_INSERT Booking.booking_order_detail ON
INSERT INTO Booking.booking_order_detail (borde_boor_id, borde_id, borde_checkin, borde_checkout, borde_adults, borde_kids, borde_price, borde_extra, borde_discount, borde_tax, borde_faci_id)
VALUES (1, 1, '2022-11-27', '2022-11-28', 2, 0, 100, 0, 0, 10, 1),
       (2, 2, '2022-11-27', '2022-11-28', 2, 1, 120, 20, 10, 12, 2),
       (3, 3, '2022-11-27', '2022-11-28', 3, 0, 150, 30, 20, 15, 3),
       (4, 4, '2022-11-27', '2022-11-28', 2, 2, 200, 40, 30, 20, 4),
       (5, 5, '2022-11-27', '2022-11-28', 1, 1, 250, 50, 40, 25, 5),
       (6, 6, '2022-11-27', '2022-11-28', 4, 0, 300, 60, 50, 30, 6),
       (7, 7, '2022-11-27', '2022-11-28', 2, 3, 350, 70, 60, 35, 7),
       (8, 8, '2022-11-27', '2022-11-28', 3, 2, 400, 80, 70, 40, 8),
       (9, 9, '2022-11-27', '2022-11-28', 1, 4, 450, 90, 80, 45, 9),
       (10, 10, '2022-11-27', '2022-11-28', 4, 1, 500, 100, 90, 50, 1),
       (11, 11, '2022-11-27', '2022-11-28', 2, 0, 550, 110, 100, 55, 1),
       (12, 12, '2022-11-27', '2022-11-28', 3, 1, 600, 120, 110, 60, 2),
       (13, 13, '2022-11-27', '2022-11-28', 1, 2, 650, 130, 120, 65, 3),
       (14, 14, '2022-11-27', '2022-11-28', 4, 0, 700, 140, 130, 70, 4),
       (15, 15, '2022-11-27', '2022-11-28', 2, 3, 750, 150, 140, 75, 5),
       (16, 16, '2022-11-27', '2022-11-28', 3, 2, 800, 160, 150, 80, 6)
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
       (10, 55, 11, 'people', 10, 2),
       (11, 60, 12, 'unit', 11, 1),
       (12, 65, 13, 'kg', 12, 2),
       (13, 70, 14, 'people', 13, 3),
       (14, 75, 15, 'unit', 14, 4),
       (15, 80, 16, 'kg', 15, 5),
       (16, 85, 17, 'people', 16, 2),
       (17, 90, 18, 'unit', 1, 1),
       (18, 95, 19, 'kg', 2, 2),
       (19, 100, 20, 'people', 3, 2),
       (20, 105, 21, 'unit', 4, 3)
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
       (8, 8, 8),
       (9, 9, 9),
       (10, 10, 1)
SET IDENTITY_INSERT Booking.special_offer_coupons OFF
-- SELECT*FROM Booking.special_offer_coupons

INSERT INTO Booking.user_breakfast (usbr_borde_id, usbr_modified_date, usbr_total_vacant)
VALUES
    (1, '2022-11-27',1),
    (2,'2022-11-27',  2),
    (3,'2022-11-27',  3),
    (4,'2022-11-27',  2),
    (5,'2022-11-27',  1),
    (6,'2022-11-27',  4),
    (7,'2022-11-27',  2),
    (8,'2022-11-27',  3),
    (9,'2022-11-27',  1),
    (10, '2022-11-27', 4),
    (11, '2022-11-27', 2),
    (12, '2022-11-27', 3),
    (13, '2022-11-27', 1),
    (14, '2022-11-27', 4),
    (15, '2022-11-27', 2),
    (16, '2022-11-27', 3)
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
INSERT INTO resto.order_menus (orme_id, orme_order_number, orme_order_date, orme_total_item, orme_total_discount, orme_total_amount, orme_pay_type, orme_cardnumber, orme_is_paid, orme_modified_date, orme_user_id)
VALUES (1, 'MENUS#2022-01-01-00001', '2022-01-01', 2, 0, 40000, 'CA', NULL, 'P', GETDATE(), 1),
(2,'MENUS#20220101-00002', '2022-01-01', 3, 5000, 75000, 'CR', '1234567890123456', 'P', GETDATE(), 2),
(3,'MENUS#20220101-00003', '2022-01-01', 4, 0, 80000, 'D', '9876543210987654', 'B', GETDATE(), 3),
(4,'MENUS#20220101-00004', '2022-01-01', 5, 0, 100000, 'CA', NULL, 'P', GETDATE(), 4),
(5,'MENUS#20220101-00005', '2022-01-01', 6, 0, 120000, 'CR', '1234567890123456', 'P', GETDATE(), 5),
(6,'MENUS#20220101-00006', '2022-01-01', 7, 0, 140000, 'D', '9876543210987654', 'B', GETDATE(), 6);
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
VALUES (8, 'GOPAY', 'PT. Dompet Anak Bangsa', CURRENT_TIMESTAMP),
       (9, 'OVO', 'PT. Visionet Internasional', CURRENT_TIMESTAMP),
       (10, 'DANA', 'PT. Espay Debit Indonesia', CURRENT_TIMESTAMP),
       (11, 'SHOPEEPAY', 'Shopee', CURRENT_TIMESTAMP),
       (12, 'FLIP', 'Fintek Karya Nusantara', CURRENT_TIMESTAMP),
       (13, 'JENIUS', 'PT. Bank BTPN Tbk', CURRENT_TIMESTAMP),
       (14, 'JAGO', 'PT. Bank Jago Tbk', CURRENT_TIMESTAMP),
       (15, 'SAKUKU', 'PT. Bank Central Asia Tbk', CURRENT_TIMESTAMP);
ENABLE TRIGGER [Payment].[InsertPaymentEntityId] ON [Payment].payment_gateway;

-- SELECT*FROM payment.payment_gateway;

-- user_accounts
INSERT
  INTO Payment.user_accounts(usac_entity_id, usac_user_id, usac_account_number, usac_saldo, usac_type, usac_expmonth, usac_expyear, usac_modified_date)
VALUES (1, 1, '6271263188999', 1000000, 'debet', 11, 22, CURRENT_TIMESTAMP),
       (2, 2, '8012372737662', 1000000, 'credit card', 12, 27, CURRENT_TIMESTAMP),
       (3, 3, '9712893896126', 1000000, 'debet', 03, 23, CURRENT_TIMESTAMP),
       (4, 4, '8129387462674', 1000000, 'debet', 08, 24, CURRENT_TIMESTAMP),
       (5, 5, '7781236462762', 1000000, 'debet', 09, 28, CURRENT_TIMESTAMP),
       (6, 6, '1278287363663', 1000000, 'credit card', 02, 25, CURRENT_TIMESTAMP),
       (7, 7, '6326361273712', 1000000, 'debet', 01, 26, CURRENT_TIMESTAMP),
       (8, 8, '812327176263', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (9, 9, '827363525152', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (10, 10, '829283525152', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (11, 11, '872363155421', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (12, 12, '873652901212', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (13, 13, '809283222364', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (14, 14, '890128352546', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP),
       (15, 15, '856272837172', 1000000, 'payment', 0, 0, CURRENT_TIMESTAMP);
-- SELECT*FROM payment.user_accounts;

-- payment_transactions
SET IDENTITY_INSERT Payment.payment_transaction ON
INSERT
  INTO Payment.payment_transaction(patr_id, patr_trx_number, patr_debet, patr_credit, patr_type, patr_note, patr_modified_date,
                                  patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
VALUES (1, 'TRB#20221127-0001', 150000, 150000, 'TRB', 'Tranfer Booking', CURRENT_TIMESTAMP, 'BO#20221127-0001', '6271263188999', '8012372737662', 'TRB#20221127-0001', 1),
       (2, 'TRB#20221127-0002', 150000, 150000, 'ORM', 'Order Menu', CURRENT_TIMESTAMP, 'MENUS#20221127-0001', '8012372737662', '6271263188999', 'TRB#20221127-0002', 2);
SET IDENTITY_INSERT Payment.payment_transaction OFF;
-- SELECT*FROM payment.payment_transaction;

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
