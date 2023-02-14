USE Hotel_Realta;
GO
--INSERT INTO purchasing.purchase_order_header (pohe_number, pohe_status, pohe_tax, pohe_refund, pohe_arrival_date, pohe_pay_type, pohe_emp_id, pohe_vendor_id)
--VALUES ('PO-006', 1, 150000, 0, GETDATE() + 10, 'CA', 1, 16);
--SELECT DATA_TYPE, COLUMN_NAME FROM information_schema.columns WHERE table_name ='purchase_order_header';
SELECT * from purchasing.purchase_order_header;