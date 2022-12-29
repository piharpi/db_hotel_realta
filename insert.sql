-- File insert 
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