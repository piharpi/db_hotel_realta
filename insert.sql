-- File insert 
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
SELECT*FROM Booking.special_offers


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
       (11, 'BO#20221127-0011', '2023-01-27', 3,'D', 'P', 'C', 11, 11),
       (12, 'BO#20221127-0012', '2023-01-27', 3,'D', 'R', 'I', 12, 12),
       (13, 'BO#20221127-0013', '2023-01-27', 3,'D', 'DP', 'T', 13, 13),
       (14, 'BO#20221127-0014', '2023-01-27', 3,'C', 'P', 'C', 14, 14),
       (15, 'BO#20221127-0015', '2023-01-27', 3,'D', 'R', 'I', 15, 15),
       (16, 'BO#20221127-0016', '2023-01-27', 3,'D', 'DP', 'T', 16, 16),
       (17, 'BO#20221127-0017', '2023-01-27', 3,'C', 'P', 'C', 17, 17)
SET IDENTITY_INSERT Booking.booking_orders OFF
SELECT*FROM Booking.booking_orders

SET IDENTITY_INSERT Booking.booking_order_detail ON
INSERT INTO Booking.booking_order_detail (borde_boor_id, borde_id, borde_checkin, borde_checkout, borde_adults, borde_kids, borde_price, borde_extra, borde_discount, borde_tax, borde_subtotal, borde_faci_id)
VALUES (1, 1, '2022-11-27', '2022-11-28', 2, 0, 100, 0, 0, 10, 110, 1),
       (2, 2, '2022-11-27', '2022-11-28', 2, 1, 120, 20, 10, 12, 138, 2),
       (3, 3, '2022-11-27', '2022-11-28', 3, 0, 150, 30, 20, 15, 145, 3),
       (4, 4, '2022-11-27', '2022-11-28', 2, 2, 200, 40, 30, 20, 190, 4),
       (5, 5, '2022-11-27', '2022-11-28', 1, 1, 250, 50, 40, 25, 215, 5),
       (6, 6, '2022-11-27', '2022-11-28', 4, 0, 300, 60, 50, 30, 270, 6),
       (7, 7, '2022-11-27', '2022-11-28', 2, 3, 350, 70, 60, 35, 295, 7),
       (8, 8, '2022-11-27', '2022-11-28', 3, 2, 400, 80, 70, 40, 330, 8),
       (9, 9, '2022-11-27', '2022-11-28', 1, 4, 450, 90, 80, 45, 355, 9),
       (10, 10, '2022-11-27', '2022-11-28', 4, 1, 500, 100, 90, 50, 390, 10),
       (11, 11, '2022-11-27', '2022-11-28', 2, 0, 550, 110, 100, 55, 415, 11),
       (12, 12, '2022-11-27', '2022-11-28', 3, 1, 600, 120, 110, 60, 450, 12),
       (13, 13, '2022-11-27', '2022-11-28', 1, 2, 650, 130, 120, 65, 475, 13),
       (14, 14, '2022-11-27', '2022-11-28', 4, 0, 700, 140, 130, 70, 510, 14),
       (15, 15, '2022-11-27', '2022-11-28', 2, 3, 750, 150, 140, 75, 535, 15),
       (16, 16, '2022-11-27', '2022-11-28', 3, 2, 800, 160, 150, 80, 570, 16)
SET IDENTITY_INSERT Booking.booking_order_detail OFF
SELECT*FROM Booking.booking_order_detail


SET IDENTITY_INSERT Booking.booking_order_detail_extra ON
INSERT INTO Booking.booking_order_detail_extra (boex_id, boex_price, boex_qty, boex_subtotal, boex_measure_unit, boex_borde_id, boex_prit_id)
VALUES (1, 10, 2, 20, 'people', 1, 1),
       (2, 15, 3, 45, 'unit', 2, 2),
       (3, 20, 4, 80, 'kg', 3, 3),
       (4, 25, 5, 125, 'people', 4, 4),
       (5, 30, 6, 180, 'unit', 5, 5),
       (6, 35, 7, 245, 'kg', 6, 6),
       (7, 40, 8, 320, 'people', 7, 7),
       (8, 45, 9, 405, 'unit', 8, 8),
       (9, 50, 10, 500, 'kg', 9, 9),
       (10, 55, 11, 605, 'people', 10, 10),
       (11, 60, 12, 720, 'unit', 11, 1),
       (12, 65, 13, 845, 'kg', 12, 2),
       (13, 70, 14, 980, 'people', 13, 3),
       (14, 75, 15, 1125, 'unit', 14, 4),
       (15, 80, 16, 1280, 'kg', 15, 5),
       (16, 85, 17, 1445, 'people', 16, 6),
       (17, 90, 18, 1620, 'unit', 1, 7),
       (18, 95, 19, 1805, 'kg', 2, 8),
       (19, 100, 20, 2000, 'people', 3, 9),
       (20, 105, 21, 2155, 'unit', 4, 10)
SET IDENTITY_INSERT Booking.booking_order_detail_extra OFF
SELECT*FROM Booking.booking_order_detail_extra
SELECT*FROM Master.price_item


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
SELECT*FROM Booking.special_offer_coupons

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
select * from Booking.user_breakfast

SET IDENTITY_INSERT Users.users ON
INSERT INTO Users.users (user_id, user_full_name, user_type, user_company_name, user_email, user_phone_number, user_modified_date)
VALUES  (1, 'John Doe', 'I', 'Doe Industries', 'john.doe@gmail.com', '555-555-1212', '2022-01-01'),
        (2, 'Jane Smith', 'C', 'Smith Enterprises', 'jane.smith@acme.com', '555-555-1213', '2022-01-02'),
        (3, 'Bob Johnson', 'T', 'Johnson Travel', 'bob.johnson@travelagency.com', '555-555-1214', '2022-01-03'),
        (4, 'Alice Williams', 'I', 'Williams Consulting', 'alice.williams@gmail.com', '555-555-1215', '2022-01-04'),
        (5, 'Mike Brown', 'C', 'Brown & Associates', 'mike.brown@acme.com', '555-555-1216', '2022-01-05'),
        (6, 'Sara Davis', 'T', 'Davis Travel Agency', 'sara.davis@travelagency.com', '555-555-1217', '2022-01-06'),
        (7, 'Jason Thompson', 'I', 'Thompson Solutions', 'jason.thompson@gmail.com', '555-555-1218', '2022-01-07'),
        (8, 'Emily Johnson', 'C', 'Johnson Corp', 'emily.johnson@acme.com', '555-555-1219', '2022-01-08'),
        (9, 'William Smith', 'T', 'Smith Travel Co.', 'william.smith@travelagency.com', '555-555-1220', '2022-01-09'),
        (10, 'Ashley Williams', 'I', 'Williams & Co.', 'ashley.williams@gmail.com', '555-555-1221', '2022-01-10'),
        (11, 'David Brown', 'C', 'Brown Industries', 'david.brown@acme.com', '555-555-1222', '2022-01-11'),
        (12, 'Jessica Davis', 'T', 'Davis Travel', 'jessica.davis@travelagency.com', '555-555-1223', '2022-01-12'),
        (13, 'James Thompson', 'I', 'Thompson Consultants', 'james.thompson@gmail.com', '555-555-1224', '2022-01-13'),
        (14, 'Sarah Johnson', 'C', 'Johnson & Associates', 'sarah.johnson@acme.com', '555-555-1225', '2022-01-14'),
        (15, 'Michael Smith', 'T', 'Smith Travel Group', 'michael.smith@travelagency.com', '555-555-1226', '2022-01-15'),
        (16, 'Jessica Williams', 'I', 'Williams & Partners', 'jessica.williams@gmail.com', '555-555-1227', '2022-01-16'),
        (17, 'Robert Brown', 'C', 'Brown Inc.', 'robert.brown@acme.com', '555-555-1228', '2022-01-17'),
        (18, 'Emily Davis', 'T', 'Davis Travel Co.', 'emily.davis@travelagency.com', '555-555-1229', '2022-01-18'),
        (19, 'Jason Thompson', 'I', 'Thompson Enterprises', 'jason.thompson@gmail.com', '555-555-1230', '2022-01-19'),
        (20, 'Sarah Johnson', 'C', 'Johnson & Co.', 'sarah.johnson@acme.com', '555-555-1231', '2022-01-20')
SET IDENTITY_INSERT Users.users OFF
SELECT * FROM Users.users

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


SET IDENTITY_INSERT Hotel.hotels ON;
INSERT INTO Hotel.Hotels (hotel_id, hotel_name, hotel_description, hotel_phonenumber, hotel_modified_date, hotel_addr_id)
VALUES (1, 'Marriott Hotel', 'Luxurious hotel in the heart of the city', '555-555-5555', '2022-01-01', 10),
       (2, 'Hilton Hotel', 'Elegant hotel with stunning views', '555-555-5556', '2022-01-02', 15),
       (3, 'Sheraton Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5557', '2022-01-03', 7),
       (4, 'Hyatt Hotel', 'Luxurious hotel with a rooftop pool', '555-555-5558', '2022-01-04', 12),
       (5, 'W Hotel', 'Luxurious hotel with a rooftop bar and lounge', '555-555-5559', '2022-01-05', 8),
       (6, 'Four Seasons Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5560', '2022-01-06', 3),
       (7, 'Ritz Carlton Hotel', 'Luxurious hotel with a rooftop pool and bar', '555-555-5561', '2022-01-07', 6),
       (8, 'Fairmont Hotel', 'Luxurious hotel with stunning views and a spa', '555-555-5562', '2022-01-08', 4),
       (9, 'St. Regis Hotel', 'Luxurious hotel with a rooftop pool and bar', '555-555-5563', '2022-01-09', 1),
       (10, 'InterContinental Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5564', '2022-01-10', 9),
       (11, 'Mandarin Oriental Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5565', '2022-01-11', 20),
       (12, 'Conrad Hotel', 'Luxurious hotel with a rooftop pool and bar', '555-555-5566', '2022-01-12', 17),
       (13, 'Park Hyatt Hotel', 'Luxurious hotel with stunning views and a spa', '555-555-5567', '2022-01-13', 2),
       (14, 'Westin Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5568', '2022-01-14', 19),
       (15, 'Renaissance Hotel', 'Luxurious hotel with a rooftop pool and bar', '555-555-5569', '2022-01-15', 14),
       (16, 'Mercedes Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5570', '2022-01-16', 18),
       (17, 'JW Marriott Hotel', 'Luxurious hotel with stunning views and a spa', '555-555-5571', '2022-01-17', 16),
       (18, 'Radisson Hotel', 'Luxurious hotel with a rooftop pool and bar', '555-555-5572', '2022-01-18', 13),
       (19, 'Crowne Plaza Hotel', 'Luxurious hotel with a spa and fitness center', '555-555-5573', '2022-01-19', 11),
       (20, 'DoubleTree Hotel', 'Luxurious hotel with stunning views and a spa', '555-555-5574', '2022-01-20', 5);
SET IDENTITY_INSERT Hotel.hotels OFF;
SELECT*FROM Hotel.hotels
ORDER BY hotel_id ASC
UPDATE Hotel.Hotels
SET hotel_rating_star = 4
WHERE hotel_id IN (1, 3, 5, 7, 9, 11, 13, 15, 17, 19);

UPDATE Hotel.Hotels
SET hotel_rating_star = 5
WHERE hotel_id IN (2, 4, 6, 8, 10, 12, 14, 16, 18, 20);


SET IDENTITY_INSERT Hotel.facilities ON
-- Insert rows into the table
INSERT INTO Hotel.facilities (faci_id, faci_name,faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_high_price, faci_rate_price, faci_hotel_id, faci_cagro_id)
VALUES (1, 'Pool', 101, '2022-01-01', '2022-12-31', 50, 100, 75, 1,1),
       (2, 'Gym', 102, '2022-01-01', '2022-12-31', 20, 40, 30,2,2),
       (3, 'Spa', 103, '2022-01-01', '2022-12-31', 80, 120, 100,3,3),
       (4, 'Restaurant', 104, '2022-01-01', '2022-12-31', 30, 60, 45,4,4),
       (5, 'Bar', 105, '2022-01-01', '2022-12-31', 20, 40, 30,5,5),
       (6, 'Conference Room', 106, '2022-01-01', '2022-12-31', 100, 200, 150,6,6),
       (7, 'Business Center', 107, '2022-01-01', '2022-12-31', 50, 100, 75,7,7),
       (8, 'Laundry Service', 108, '2022-01-01', '2022-12-31', 30, 60, 45,8,1),
       (9, 'Childcare Services', 109, '2022-01-01', '2022-12-31', 20, 40, 30,9,2),
       (10, 'Car Rental', 110, '2022-01-01', '2022-12-31', 50, 100, 75,10,3),
       (11, 'Airport Shuttle', 111, '2022-01-01', '2022-12-31', 30, 60, 45,11,4),
       (12, 'Currency Exchange', 112, '2022-01-01', '2022-12-31', 20, 40, 30,12,5),
       (13, 'Tour Desk', 113, '2022-01-01', '2022-12-31', 50, 100, 75,13,6),
       (14, 'Babysitting Services', 114, '2022-01-01', '2022-12-31', 30, 60, 45,14,7),
       (15, 'Concierge Services', 115, '2022-01-01', '2022-12-31', 20, 40, 30,15,1),
       (16, 'Dry Cleaning Services', 116, '2022-01-01', '2022-12-31', 50, 100, 75,16,2),
       (17, 'Gift Shop', 117, '2022-01-01', '2022-12-31', 30, 60, 45,17,3),
       (18, 'Luggage Storage', 118, '2022-01-01', '2022-12-31', 20, 40, 30,18,4),
       (19, 'Meeting Rooms', 119, '2022-01-01', '2022-12-31', 50, 100, 75,19,5),
       (20, 'Parking', 120, '2022-01-01', '2022-12-31', 30, 60, 45,20,6);
-- Turn off the identity insert
SET IDENTITY_INSERT Hotel.facilities OFF
SELECT*FROM Hotel.facilities


SET IDENTITY_INSERT Master.category_group ON
INSERT INTO Master.category_group (cagro_id, cagro_name, cagro_type)
VALUES
  (1, '1', 'category'),
  (2, '2', 'category'),
  (3, '3', 'category'),
  (4, '4', 'category'),
  (5, '5', 'category'),
  (6, '6', 'category'),
  (7, '7', 'category');
SET IDENTITY_INSERT Master.category_group OFF

SET IDENTITY_INSERT Master.price_item OFF
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
SET IDENTITY_INSERT Master.price_item ON
SELECT * FROM Master.price_item

