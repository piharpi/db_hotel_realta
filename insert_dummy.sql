insert into hotel.facilities (hofa_faci_id) values (1),(2),(3),(4),(5);

select * from information_schema.columns where table_name = 'facilities';

INSERT INTO purchasing.purchase_order_header (pohe_number, pohe_order_date, pohe_tax, pohe_pay_type)
VALUES 
('PO00001', '2021-01-01', 10, 'TR'),
('PO00002', '2021-02-01', 20, 'CA'),
('PO00003', '2021-03-01', 30, 'TR'),
('PO00004', '2021-04-01', 40, 'CA'),
('PO00005', '2021-05-01', 50, 'TR');

INSERT INTO purchasing.purchase_order_detail (pode_pohe_id, pode_order_qty, pode_price, pode_received_qty, pode_rejected_qty, pode_modified_date)
VALUES 
(1, 10, 10, 8, 2, '2021-01-01'),
(2, 20, 20, 15, 5, '2021-02-01'),
(3, 30, 30, 25, 5, '2021-03-01'),
(4, 40, 40, 35, 5, '2021-04-01'),
(5, 50, 50, 45, 5, '2021-05-01');

INSERT INTO purchasing.stocks (stock_name, stock_description, stock_quantity, stock_reorder_point, stock_price, stock_standar_cost, stock_size, stock_color, stock_modified_date)
VALUES
  ('Sprei Hotel', 'Sprei dengan bahan yang nyaman dan tahan lama', 100, 50, 500000, 450000, 'King', 'Putih', GETDATE()),
  ('Bantal Hotel', 'Bantal dengan bahan yang nyaman dan tahan lama', 150, 75, 300000, 270000, 'Standard', 'Putih', GETDATE()),
  ('Handuk Hotel', 'Handuk dengan bahan yang nyaman dan tahan lama', 200, 100, 200000, 180000, 'Standard', 'Putih', GETDATE()),
  ('Gorden Hotel', 'Gorden dengan bahan yang tahan lama dan mudah dicuci', 50, 25, 1000000, 900000, 'Standard', 'Putih', GETDATE()),
  ('Gelas Hotel', 'Gelas dengan bahan yang tahan lama dan mudah dicuci', 250, 125, 50000, 45000, 'Standard', 'Transparan', GETDATE());

  
INSERT INTO purchasing.stock_detail (stod_stock_id, stod_barcode_number, stod_status, stod_notes, stod_faci_id, stod_pohe_id)
VALUES
  (1, 'Barcode Sprei 1', 1, 'Sprei di kamar 101', 1, 1),
  (1, 'Barcode Sprei 2', 1, 'Sprei di kamar 102', 1, 1),
  (1, 'Barcode Sprei 3', 1, 'Sprei di kamar 103', 1, 1),
  (1, 'Barcode Sprei 4', 1, 'Sprei di kamar 104', 1, 1),
  (1, 'Barcode Sprei 5', 1, 'Sprei di kamar 105', 1, 1),
  (2, 'Barcode Bantal 1', 1, 'Bantal di kamar 106', 2, 2),
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


SELECT s.*, sp.*, poh.*, pod.*, v.*
FROM purchasing.stocks s
JOIN purchasing.stock_photo sp ON s.stock_id = sp.spho_stock_id
JOIN purchasing.purchase_order_header poh ON s.stock_id = poh.pohe_id
JOIN purchasing.purchase_order_detail pod ON poh.pohe_id = pod.pode_pohe_id
JOIN purchasing.vendor v ON poh.pohe_vendor_id = v.vendor_id

select * from purchasing.stocks 
union 
select * from purchasing.stock_photo
