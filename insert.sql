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
