-- File insert 

INSERT INTO special_offers (spof_id, spof_name, spof_description, spof_type, spof_discount, spof_start_date, spof_end_date, spof_min_qty, spof_max_qty, spof_modified_date)
VALUES (1, 'Winter Sale', 'Get 20% off your stay when you book a room during the winter months', 'T', 20, '2022-12-01', '2022-03-31', 1, NULL, '2022-11-27'),
       (2, 'Weekend Getaway Deal', 'Stay two nights on the weekend and get the third night free', 'C', 100, '2022-12-01', '2022-03-31', 3, NULL, '2022-11-27'),
       (3, 'Early Bird Special', 'Book at least 30 days in advance and save 15% on your stay', 'I', 15, '2022-12-01', '2022-03-31', 1, NULL, '2022-11-27'),
       (4, 'Family Fun Package', 'Book a family room and get free breakfast for the kids', 'T', 0, '2022-12-01', '2022-03-31', 4, NULL, '2022-11-27'),
       (5, 'Romance Package', 'Book a romantic getaway for two and get a bottle of champagne upon arrival', 'C', 0, '2022-12-01', '2022-03-31', 2, NULL, '2022-11-27'),
       (6, 'Last Minute Deal', 'Book within 48 hours of arrival and save 20% on your stay', 'I', 20, '2022-12-01', '2022-03-31', 1, NULL, '2022-11-27'),
       (7, 'AAA/CAA Discount', 'Show your AAA or CAA membership card and get 10% off your stay', 'T', 10, '2022-12-01', '2022-03-31', 1, NULL, '2022-11-27'),
       (8, 'Senior Discount', 'Guests 65 and over receive 10% off their stay', 'C', 10, '2022-12-01', '2022-03-31', 1, NULL, '2022-11-27'),
       (9, 'Military Discount', 'Active duty military personnel receive 15% off their stay', 'I', 15, '2022-12-01', '2022-03-31', 1, NULL, '2022-11-27')

INSERT INTO booking_orders (boor_id, boor_order_number, boor_order_date, boor_pay_type, boor_is_paid, boor_type, boor_user_id, boor_hotel_id)
VALUES (1, 'BO#20221127-0001', '2022-11-27', 'CR', 'DP', 'T', 1, 1),
       (2, 'BO#20221127-0002', '2022-11-27', 'C', 'P', 'C', 2, 2),
       (3, 'BO#20221127-0003', '2022-11-27', 'D', 'R', 'I', 3, 3),
       (4, 'BO#20221127-0004', '2022-11-27', 'PG', 'DP', 'T', 4, 4),
       (5, 'BO#20221127-0005', '2022-11-27', 'CR', 'P', 'C', 5, 5),
       (6, 'BO#20221127-0006', '2022-11-27', 'C', 'R', 'I', 6, 6),
       (7, 'BO#20221127-0007', '2022-11-27', 'D', 'DP', 'T', 7, 7),
       (8, 'BO#20221127-0008', '2022-11-27', 'PG', 'P', 'C', 8, 8),
       (9, 'BO#20221127-0009', '2022-11-27', 'CR', 'R', 'I', 9, 9),
       (10, 'BO#20221127-0010', '2022-11-27', 'C', 'DP', 'T', 10, 10),
       (11, 'BO#20221127-0011', '2022-11-27', 'D', 'P', 'C', 11, 11),
       (12, 'BO#20221127-0012', '2022-11-27', 'PG', 'R', 'I', 12, 12),
       (13, 'BO#20221127-0013', '2022-11-27', 'CR', 'DP', 'T', 13, 13),
       (14, 'BO#20221127-0014', '2022-11-27', 'C', 'P', 'C', 14, 14),
       (15, 'BO#20221127-0015', '2022-11-27', 'D', 'R', 'I', 15, 15),
       (16, 'BO#20221127-0016', '2022-11-27', 'PG', 'DP', 'T', 16, 16),
       (17, 'BO#20221127-0017', '2022-11-27', 'CR', 'P', 'C', 17, 17)

INSERT INTO booking_order_detail (borde_boor_id, borde_id, borde_checkin, borde_checkout, borde_adults, borde_kids, borde_price, borde_extra, borde_discount, borde_tax, borde_subtotal, borde_faci_id)
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


INSERT INTO booking_order_detail_extra (boex_id, boex_price, boex_qty, boex_subtotal, boex_measure_unit, boex_borde_id, boex_prit_id)
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
       (11, 60, 12, 720, 'unit', 11, 11),
       (12, 65, 13, 845, 'kg', 12, 12),
       (13, 70, 14, 980, 'people', 13, 13),
       (14, 75, 15, 1125, 'unit', 14, 14),
       (15, 80, 16, 1280, 'kg', 15, 15),
       (16, 85, 17, 1445, 'people', 16, 16),
       (17, 90, 18, 1620, 'unit', 17, 17),
       (18, 95, 19, 1805, 'kg', 18, 18),
       (19, 100, 20, 2000, 'people', 19, 19),
       (20, 105, 21, 2155, 'unit', 20, 20)
                     
INSERT INTO special_offer_coupons (soco_id, soco_borde_id, soco_spof_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5),
       (6, 6, 6),
       (7, 7, 7),
       (8, 8, 8),
       (9, 9, 9),
       (10, 10, 10)

INSERT INTO user_breakfast (usbr_borde_id, usbr_modified_date, usbr_total_vacant)
SELECT borde_id, '2022-11-27', SUM(borde_adults + borde_kids)
FROM booking_order_detail
GROUP BY borde_id