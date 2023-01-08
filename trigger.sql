USE Hotel_Realta;
GO
-- DROP TRIGGER purchasing.tr_vendor_modified_date;
-- DROP TRIGGER purchasing.tr_stocks_modified_date;
-- DROP TRIGGER purchasing.tr_pode_modified_date;
-- GO

CREATE TRIGGER tr_vendor_modified_date
ON purchasing.vendor
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.vendor
  SET vendor_modified_date = GETDATE()
  WHERE vendor_id IN(SELECT vendor_id FROM inserted)
END;
GO

CREATE TRIGGER tr_stocks_modified_date
ON purchasing.stocks
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.stocks
  SET stock_modified_date = GETDATE()
  WHERE stock_id IN(SELECT stock_id FROM inserted)
END;
GO

CREATE TRIGGER tr_pode_modified_date
ON purchasing.purchase_order_detail
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.purchase_order_detail
  SET pode_modified_date = GETDATE()
  WHERE pode_id IN(SELECT pode_id FROM inserted)
END;
GO

CREATE TRIGGER tr_update_sub_total
ON purchasing.purchase_order_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE purchasing.purchase_order_header
    SET pohe_subtotal = 
      (SELECT SUM(pode_line_total) 
        FROM purchasing.purchase_order_detail 
        WHERE pode_pohe_id = pohe_id)
    WHERE pohe_id IN 
      (SELECT pode_pohe_id FROM inserted) 
    OR pohe_id IN (SELECT pode_pohe_id FROM deleted);
END;
GO

-- TRIGGER STOCKS
-- DROP TRIGGER purchasing.tr_update_stock_scrap;

CREATE TRIGGER tr_update_stock_scrap
ON purchasing.stock_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_scrap = 
    (SELECT COUNT(*)
     FROM purchasing.stock_detail sd
     WHERE sd.stod_status IN (2, 3) AND s.stock_id = sd.stod_stock_id)
  FROM purchasing.stocks s;
END;
GO

-- DROP TRIGGER purchasing.tr_update_stock_used;

CREATE TRIGGER tr_update_stock_used
ON purchasing.stock_detail
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_used = 
    (SELECT COUNT(*)
     FROM purchasing.stock_detail sd
     WHERE sd.stod_status = 4 AND s.stock_id = sd.stod_stock_id)
  FROM purchasing.stocks s;
END;
GO

-- DROP TRIGGER purchasing.tr_update_stock_quantity;

CREATE TRIGGER tr_update_stock_quantity
ON purchasing.purchase_order_header
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  -- Update data di tabel stocks
  UPDATE s
  SET s.stock_quantity = 
    (SELECT SUM(pod.pode_stocked_qty)
     FROM purchasing.purchase_order_detail pod
     JOIN purchasing.purchase_order_header poh ON poh.pohe_id = pod.pode_pohe_id
     WHERE s.stock_id = pod.pode_stock_id and poh.pohe_status = 4)
  FROM purchasing.stocks s;
END;
GO

DROP PROCEDURE IF EXISTS spUpdateVendor;
GO

CREATE PROCEDURE purchasing.spUpdateVendor
(
  @id INT,
  @name NVARCHAR(55),
  @active BIT,
  @priority BIT,
  @weburl NVARCHAR(1025)
)
AS
BEGIN
  UPDATE purchasing.vendor
  SET
    vendor_name = @name,
    vendor_active = @active,
    vendor_priority = @priority,
    vendor_modified_date = GETDATE(),
    vendor_weburl = @weburl
  WHERE
    vendor_id = @id;
END
GO

-- purchasing.spUpdateVendor @id = 15, @name = "abcde", @active = false, @priority = true, @weburl = NULL
-- GO

-- select * from purchasing.vendor

USE tempdb;
GO