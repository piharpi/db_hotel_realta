USE Hotel_Realta;
GO

DELETE Users.Users;
DELETE Booking.BookingOrders;
DELETE Resto.OrderMenus;
DELETE Payment.Entity;
DELETE Payment.PaymentGateway;
DELETE Payment.Bank;
DELETE Payment.PaymentTransaction;

-- dummy users
SET IDENTITY_INSERT Users.Users ON
INSERT 
  INTO Users.Users(user_id) 
VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
SET IDENTITY_INSERT Users.Users OFF

-- dummy bookings
SET IDENTITY_INSERT Booking.BookingOrders ON
INSERT 
  INTO Booking.BookingOrders(boor_id, boor_order_number) 
VALUES  (1, 'BO#20221127-0001'),
        (2, 'BO#20221127-0002'),
        (3, 'BO#20221127-0003'),
        (4, 'BO#20221127-0004'),
        (5, 'BO#20221127-0005'),
        (6, 'BO#20221127-0006'),
        (7, 'BO#20221127-0007'),
        (8, 'BO#20221127-0008');
SET IDENTITY_INSERT Booking.BookingOrders OFF

-- dummy resto
SET IDENTITY_INSERT Resto.OrderMenus ON
INSERT 
  INTO Resto.OrderMenus(orme_id, orme_order_number)
VALUES (1, 'MENUS#20221127-0001'),
       (2, 'MENUS#20221127-0002'),
       (3, 'MENUS#20221127-0003'),
       (4, 'MENUS#20221127-0004'),
       (5, 'MENUS#20221127-0005'),
       (6, 'MENUS#20221127-0006'),
       (7, 'MENUS#20221127-0007');
SET IDENTITY_INSERT Resto.OrderMenus OFF

-- insert entity
SET IDENTITY_INSERT Payment.Entity ON
INSERT 
  INTO Payment.Entity(entity_id) 
VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15);
SET IDENTITY_INSERT Payment.Entity OFF

-- insert bank
INSERT 
  INTO Payment.Bank (bank_entity_id, bank_code, bank_name, bank_modified_date)
VALUES (1, 'BRI', 'PT BANK RAKYAT INDONESIA (PERSERO) Tbk', CURRENT_TIMESTAMP),
       (2, 'BNI', 'PT BANK NEGARA INDONESIA (PERSERO) Tbk', CURRENT_TIMESTAMP),
       (3, 'BCA', 'PT BANK CENTRAL ASIA Tbk', CURRENT_TIMESTAMP),
       (4, 'BSI', 'PT BANK SYARIAH INDONESIA Tbk ', CURRENT_TIMESTAMP),
       (5, 'BTN', 'PT BANK TABUNGAN NEGARA (PERSERO) Tbk', CURRENT_TIMESTAMP),
       (6, 'MANDIRI', 'PT BANK MANDIRI (PERSERO) Tbk', CURRENT_TIMESTAMP),
       (7, 'MUAMALAT', 'PT BANK MUAMALAT INDONESIA Tbk', CURRENT_TIMESTAMP);

-- insert payment_gateway
INSERT 
  INTO Payment.PaymentGateway(paga_entity_id, paga_code, paga_name, paga_modified_date)
VALUES (8, 'GOPAY', 'PT. Dompet Anak Bangsa', CURRENT_TIMESTAMP),
       (9, 'OVO', 'PT. Visionet Internasional', CURRENT_TIMESTAMP),
       (10, 'DANA', 'PT. Espay Debit Indonesia', CURRENT_TIMESTAMP),
       (11, 'SHOPEEPAY', 'Shopee', CURRENT_TIMESTAMP),
       (12, 'FLIP', 'Fintek Karya Nusantara', CURRENT_TIMESTAMP),
       (13, 'JENIUS', 'PT. Bank BTPN Tbk', CURRENT_TIMESTAMP),
       (14, 'JAGO', 'PT. Bank Jago Tbk', CURRENT_TIMESTAMP),
       (15, 'SAKUKU', 'PT. Bank Central Asia Tbk', CURRENT_TIMESTAMP);
       
-- user_accounts
INSERT
  INTO Payment.UserAccounts(usac_entity_id, usac_user_id, usac_account_number, usac_saldo, usac_type, usac_expmonth, usac_expyear, usac_modified_date)
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

-- payment_transactions
SET IDENTITY_INSERT Payment.PaymentTransaction ON
INSERT
  INTO Payment.PaymentTransaction(patr_id, patr_trx_number, patr_debet, patr_credit, patr_type, patr_note, patr_modified_date, 
                                  patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
VALUES (1, 'TRB#20221127-0001', 150000, 150000, 'TRB', NULL, CURRENT_TIMESTAMP, 'BO#20221127-0001', 1, 2, 'TRB#20221127-0001', 1),
       (2, 'TRB#20221127-0002', 150000, 150000, 'ORM', NULL, CURRENT_TIMESTAMP, 'MENUS#20221127-0001', 2, 1, 'TRB#20221127-0002', 2);
SET IDENTITY_INSERT Payment.PaymentTransaction OFF

select * from Users.Users
select * from Booking.BookingOrders
select * from Resto.OrderMenus
select * from Payment.Entity
select * from Payment.Bank
select * from Payment.PaymentGateway
select * from Payment.UserAccounts
select * from Payment.PaymentTransaction

-- USE tempdb;