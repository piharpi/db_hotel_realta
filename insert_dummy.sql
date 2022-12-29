-- ALTER TABLE hotel.facilities RENAME COLUMN hofa_faci_id TO faci_id;

insert into hotel.facilities (hofa_faci_id) values (1),(2),(3),(4),(5);
insert into hr.employee (emp_id) values (1),(2),(3),(4),(5);


select * from information_schema.columns where table_name = 'employee';

INSERT INTO purchasing.purchase_order_header (pohe_number, pohe_status, pohe_order_date, pohe_tax, pohe_refund, pohe_arrival_date, pohe_pay_type, pohe_emp_id, pohe_vendor_id)
VALUES
  ('PO-001', 1, GETDATE(), 150000, 0, GETDATE() + 10, 'CA', 1, 1),
  ('PO-002', 1, GETDATE(), 300000, 0, GETDATE() + 15, 'CA', 1, 2),
  ('PO-003', 1, GETDATE(), 450000, 0, GETDATE() + 20, 'TR', 1, 3),
  ('PO-004', 1, GETDATE(), 600000, 0, GETDATE() + 25, 'TR', 1, 4),
  ('PO-005', 1, GETDATE(), 750000, 0, GETDATE() + 30, 'CA', 1, 5);

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
