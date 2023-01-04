--memasukkan file insert

USE TempDBRealta;
GO
-- Dummy Data;
-- Insert rows into table 'Users.users'


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

INSERT INTO Hotel.Hotels (hotel_name, hotel_description, hotel_rating_star, hotel_phonenumber, hotel_modified_date, hotel_addr_id)
VALUES
('Hotel Amaris Palembang', 'Hotel bintang 3 dengan fasilitas yang lengkap dan modern di Palembang', 3, '+62 823 3456 7891', '2022-01-01', 1),
('Grand Clarion Hotel Palembang', 'Hotel bintang 4 dengan kamar yang luas dan nyaman di Palembang', 4, '+62 823 1234 5678', '2022-02-01', 2),
('Aston Hotel Palembang', 'Hotel bintang 5 dengan fasilitas spa dan kolam renang di Palembang', 5, '+62 823 9012 3456', '2022-03-01', 3),
('Hotel Santika Palembang', 'Hotel bintang 3 dengan fasilitas kelas atas di Palembang', 3, '+62 823 7890 1234', '2022-04-01', 3),
('Ibis Hotel Palembang', 'Hotel bintang 3 dengan tarif terjangkau di Palembang', 3, '+62 823 4567 8901', '2022-05-01', 2),
('Grand Mercure Hotel Palembang', 'Hotel bintang 4 dengan fasilitas mewah di Palembang', 4, '+62 823 1234 5679', '2022-06-01', 5),
('Marriott Hotel Palembang', 'Hotel bintang 5 dengan fasilitas spa dan fitness center di Palembang', 5, '+62 823 9012 3457', '2022-07-01', 1),
('Zest Hotel Palembang', 'Hotel bintang 3 dengan desain modern dan nyaman di Palembang', 3, '+62 823 7890 1235', '2022-08-01', 4),
('The Westin Hotel Palembang', 'Hotel bintang 4 dengan fasilitas kelas atas di Palembang', 4, '+62 823 4567 8902', '2022-09-01', 5),
('Swiss-Belhotel Palembang', 'Hotel bintang 5 dengan fasilitas mewah di Palembang', 5, '+62 823 1234 5680', '2022-10-01', 4)

INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id)
VALUES
('Pool', 'Outdoor pool with sun loungers and parasols', 100, 'people', 'POOL01', '2022-01-01', '2022-12-31', 50000, 100000, 75000, 25000, 10000, 6, 1) -- POOL
,('Restaurant', 'Fine dining restaurant serving international cuisine', 100, 'people', 'REST01', '2022-01-01', '2022-12-31', 40000, 80000, 60000, 25000, 10000, 2, 1) -- RESTAURANT
,('Gym', 'Fully equipped gym with treadmills stationary bikes, and weights', 50, 'people', 'GYM01', '2022-01-01', '2022-12-31', 30000, 50000, 40000, 25000, 10000, 4, 1) -- GYM
,('Metting Room', 'Meeting room Luxury, and body treatments', 20, 'people', 'MTG01', '2022-01-01', '2022-12-31', 80000, 120000, 100000, 25000, 10000, 3, 1) -- MEETING
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2,'beds', 'DLR01', '2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 1)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2,'beds', 'SPR01', '2022-01-01', '2022-01-30', 150000, 180000, 160000, 25000, 10000, 1, 1)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4,'beds', 'FMR01', '2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, 10000, 1, 1)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2,'beds', 'STR01','2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 1)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2,'beds', 'DBR01', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 1)


INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id)
VALUES
('Restaurant', 'Fine dining restaurant serving international cuisine', 100, 'people', 'REST02', '2022-01-01', '2022-12-31', 40000, 80000, 60000, 25000, 10000, 2, 2) -- RESTAURANT
,('Pool', 'Outdoor pool with sun loungers and parasols', 100, 'people', 'POOL02', '2022-01-01', '2022-12-31', 50000, 100000, 75000, 25000, 10000, 6, 2) -- POOL
,('Gym', 'Fully equipped gym with treadmills, stationary bikes, and weights', 50, 'people', 'GYM02', '2022-01-01', '2022-12-31',20000, 30000, 25000, 25000, 10000, 4, 2) -- GYM
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2, 'beds', 'DLR02', '2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 2)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'SPR02', '2022-01-01', '2022-01-30', 150000, 180000, 160000, 25000, 10000, 1, 2)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4, 'beds', 'FMR02', '2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, 10000, 1, 2)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'STR02', '2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 2)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2, 'beds', 'DBR02', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 2)


INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id)
VALUES
('Restaurant', 'Fine dining restaurant serving international cuisine', 100, 'people', 'REST03', '2022-01-01', '2022-12-31', 40000, 80000, 60000, 25000, 10000, 2, 3) -- RESTAURANT
,('Swimming Pool', 'Our hotel has a large outdoor swimming pool with a depth of 1.5 meters', 50, 'people', 'POOL3', '2022-01-01', '2022-12-31', 50000, 100000, 75000, 25000, 10000, 6, 3) -- SWIMING POOL
,('Fitness Center', 'Our hotel has a fully equipped fitness center open 24 hours a day', 30, 'people', 'FIT3', '2022-01-01', '2022-12-31', 30000, 50000, 40000, 25000, 10000, 4, 3) -- GYM
,('Aula', 'Our hotel has a traditional Aula that can accommodate up to 10 people', 10, 'people', 'AULA3', '2022-01-01', '2022-12-31', 25000, 35000, 30000, 25000, 10000, 1, 3) -- AULA
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2, 'beds', 'DLR03', '2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 3)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'SPR03', '2022-01-01', '2022-01-30', 150000, 180000, 160000, 25000, 10000, 1, 3)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4, 'beds', 'FMR03', '2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, 10000, 1, 3)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'STR03', '2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 3)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2, 'beds', 'DBR03', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 3)


INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit, 
faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, 
faci_discount, faci_tax_rate, faci_cagro_id, faci_hotel_id)
VALUES
('Conference Room', 'Our hotel has a spacious conference room that can accommodate up to 200 people', 200, 'people', 'CON4', '2022-01-01', '2022-12-31', 200000, 300000, 250000, 25000, 10000, 5, 4) -- AULA
,('Metting Room', 'Meeting room Luxury with a variety of treatments and therapies', 15, 'people', 'MTG4', '2022-01-01', '2022-12-31', 100000, 150000, 125000, 25000, 10000, 3, 4) -- MEETING ROOM
,('Restaurant', 'Our hotel has a fine dining restaurant that serves a variety of international cuisines', 100, 'people', 'RES4','2022-01-01', '2022-12-31', 200000, 300000, 250000, 25000, 10000, 2, 4) -- RESTAURANT
,('Deluxe Room', 'Kamar luas dengan fasilitas mewah, termasuk kamar mandi pribadi dengan shower dan bathtub', 2, 'beds', 'DLR04','2022-01-01', '2022-01-30', 200000, 250000, 230000, 25000, 10000, 1, 4)
,('Superior Room', 'Kamar standar dengan fasilitas lengkap, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'SPR04', '2022-01-01', '2022-01-30', 150000, 180000, 160000, 25000, 10000, 1, 4)
,('Family Room', 'Kamar untuk keluarga, dengan 2 tempat tidur single dan 1 tempat tidur double, serta fasilitas lengkap', 4, 'beds', 'FMR04','2022-01-01', '2022-01-30', 250000, 300000, 270000, 25000, 10000, 1, 4)
,('Standard Room', 'Kamar standar dengan fasilitas sederhana, termasuk kamar mandi pribadi dengan shower', 2, 'beds', 'STR04', '2022-01-01', '2022-01-30', 100000, 125000, 115000, 25000, 10000, 1, 4)
,('Double Room', 'Kamar dengan 2 tempat tidur single, serta fasilitas lengkap', 2, 'beds', 'DBR04', '2022-01-01', '2022-01-30', 150000, 175000, 160000, 25000, 10000, 1, 4)

-- Data Fix