-- File insert 

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
insert into master.category_group (cagro_name, cagro_description, cagro_type, cagro_icon, cagro_icon_url)
values
('room', 'Kamar', 'category', 'icon-kamar', 'http://localhost/icon-kamar.png'),
('restaurant', 'Restoran', 'category', 'icon-restoran', 'http://localhost/icon-restoran.png'),
('meeting room', 'Ruang rapat', 'category', 'icon-ruang-rapat', 'http://localhost/icon-ruang-rapat.png'),
('gym', 'Gym', 'category', 'icon-gym', 'http://localhost/icon-gym.png'),
('aula', 'Aula', 'category', 'icon-aula', 'http://localhost/icon-aula.png'),
('swimming pool', 'Kolam renang', 'category', 'icon-kolam-renang', 'http://localhost/icon-kolam-renang.png'),
('balroom', 'Balroom', 'category', 'icon-balroom', 'http://localhost/icon-balroom.png');

--POLICY
insert into master.policy (poli_name, poli_description)
values
('Kebijakan pembatalan', 'Pembatalan tiket dapat dilakukan dengan mengirimkan permintaan pembatalan ke alamat email kami dalam jangka waktu tertentu sebelum tanggal keberangkatan.'),
('Kebijakan pengembalian uang', 'Pengembalian uang hanya dapat dilakukan dalam jangka waktu tertentu setelah tanggal keberangkatan, dengan potongan biaya administrasi sebesar 10% dari harga tiket.'),
('Kebijakan penukaran tiket', 'Penukaran tiket hanya dapat dilakukan dengan mengirimkan permintaan penukaran ke alamat email kami dalam jangka waktu tertentu sebelum tanggal keberangkatan. Biaya penukaran akan dikenakan sesuai dengan perbedaan harga tiket.');


--PRICE_ITEM
insert into master.price_item (prit_name, prit_price, prit_description, prit_type, prit_modified_date)
values
('Mie goreng', 12000, 'Mie goreng dengan bahan-bahan berkualitas', 'FOOD', '2022-01-01'),
('Es teh', 4000, 'Es teh dingin dengan rasa yang enak', 'SOFTDRINK', '2022-01-01'),
('Facial', 75000, 'Perawatan wajah dengan bahan-bahan alami', 'SERVICE', '2022-01-01'),
('Basket sepakbola', 250000, 'Basket sepakbola untuk olahraga bersama teman', 'FACILITY', '2022-01-01'),
('Kripik singkong', 5000, 'Kripik singkong dengan rasa original', 'SNACK', '2022-01-01'),
('Nasi goreng', 15000, 'Nasi goreng dengan bahan-bahan berkualitas', 'FOOD', '2022-01-01'),
('Es jeruk', 5000, 'Es jeruk dingin dengan rasa yang segar', 'SOFTDRINK', '2022-01-01'),
('Perawatan rambut', 100000, 'Perawatan rambut dengan produk-produk berkualitas', 'SERVICE', '2022-01-01'),
('Lapangan futsal', 500000, 'Lapangan futsal untuk olahraga bersama teman', 'FACILITY', '2022-01-01'),
('Kripik kentang', 7000, 'Kripik kentang dengan rasa original', 'SNACK', '2022-01-01');


--MEMBER
insert into master.members (memb_name, memb_description)
values
('SILVER', 'Kategori keanggotaan Silver dengan beragam keuntungan dan manfaat yang bisa dinikmati oleh member, seperti diskon 10% pada setiap pembelian di toko kami, akses ke kelas olahraga dan fitness gratis setiap minggu, serta gratis menonton pertandingan olahraga di stadium kami'),
('GOLD', 'Kategori keanggotaan Gold dengan beragam keuntungan dan manfaat yang lebih lengkap dibandingkan dengan kategori Silver, seperti diskon 15% pada setiap pembelian di toko kami, akses ke kelas olahraga dan fitness gratis setiap hari, serta gratis menonton pertandingan olahraga di stadium kami dan menikmati fasilitas VIP lounge'),
('VIP', 'Kategori keanggotaan VIP dengan beragam keuntungan dan manfaat yang lebih lengkap dibandingkan dengan kategori Gold, seperti diskon 20% pada setiap pembelian di toko kami, akses ke kelas olahraga dan fitness gratis setiap hari, serta gratis menonton pertandingan olahraga di stadium kami dan menikmati fasilitas VIP lounge dan fasilitas makan di restoran VIP'),
('WIZARD', 'Kategori keanggotaan Wizard dengan beragam keuntungan dan manfaat yang lebih lengkap dibandingkan dengan kategori VIP, serta fasilitas yang lebih eksklusif dan terbatas hanya untuk member Wizard, seperti diskon 25% pada setiap pembelian di toko kami, akses ke kelas olahraga dan fitness gratis setiap hari, serta gratis menonton pertandingan olahraga di stadium kami dan menikmati fasilitas VIP lounge dan fasilitas makan di restoran VIP');


--SERVICE_TASK
insert into master.service_task (seta_name, seta_seq)
values
('Receptionist', 1),
('Housekeeping', 2),
('Maintenance', 3),
('Security', 4),
('Food and Beverage Staff', 5),
('Fitness Trainer', 6),
('Spa Therapist', 7);
