USE Northwind
GO

USE Hotel_Realta;
GO
DROP TRIGGER IF EXISTS purchasing.tr_vendor_modified_date;
DROP TRIGGER IF EXISTS purchasing.tr_stocks_modified_date;
DROP TRIGGER IF EXISTS purchasing.tr_pode_modified_date;
DROP TRIGGER IF EXISTS purchasing.tr_delete_header_if_no_detail;
--DROP TRIGGER IF EXISTS purchasing.tr_update_stock_quantity;
--DROP TRIGGER IF EXISTS purchasing.tr_update_stock_scrap;
--DROP TRIGGER IF EXISTS purchasing.tr_update_stock_used;
DROP TRIGGER IF EXISTS purchasing.tr_update_sub_total;
DROP PROCEDURE IF EXISTS purchasing.spUpdateVendor;
DROP PROCEDURE IF EXISTS purchasing.spUpdateStocks;
DROP PROCEDURE IF EXISTS purchasing.spUpdateStockPhoto;
DROP PROCEDURE IF EXISTS purchasing.spUpdatePohe;
DROP PROCEDURE IF EXISTS purchasing.spUpdatePode;
DROP PROCEDURE IF EXISTS purchasing.spInsertPurchaseOrder;
DROP PROCEDURE IF EXISTS purchasing.spDeletePurchaseOrder;
GO

CREATE TRIGGER tr_delete_header_if_no_detail
ON purchasing.purchase_order_detail
AFTER DELETE
AS
BEGIN
    DECLARE @pode_pohe_id INT;
    
    SELECT @pode_pohe_id = pode_pohe_id FROM deleted;
    
    IF NOT EXISTS (SELECT 1 FROM purchasing.purchase_order_detail WHERE pode_pohe_id = @pode_pohe_id)
    BEGIN
        DELETE FROM purchasing.purchase_order_header WHERE pohe_id = @pode_pohe_id;
    END
END
GO

CREATE TRIGGER tr_vendor_modified_date
ON purchasing.vendor
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.vendor
  SET vendor_modified_date = GETDATE()
  WHERE vendor_entity_id IN(SELECT vendor_entity_id FROM inserted)
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

--CREATE TRIGGER tr_update_stock_scrap
--ON purchasing.stock_detail
--AFTER INSERT, UPDATE, DELETE
--AS
--BEGIN
--  -- Update data di tabel stocks
--  UPDATE s
--  SET s.stock_scrap = 
--    (SELECT COUNT(*)
--     FROM purchasing.stock_detail sd
--     WHERE sd.stod_status IN (2, 3) AND s.stock_id = sd.stod_stock_id)
--  FROM purchasing.stocks s;
--END;
--GO

-- DROP TRIGGER purchasing.tr_update_stock_used;

--CREATE TRIGGER tr_update_stock_used
--ON purchasing.stock_detail
--AFTER INSERT, UPDATE, DELETE
--AS
--BEGIN
--  -- Update data di tabel stocks
--  UPDATE s
--  SET s.stock_used = 
--    (SELECT COUNT(*)
--     FROM purchasing.stock_detail sd
--     WHERE sd.stod_status = 4 AND s.stock_id = sd.stod_stock_id)
--  FROM purchasing.stocks s;
--END;
--GO

-- DROP TRIGGER purchasing.tr_update_stock_quantity;

--CREATE TRIGGER tr_update_stock_quantity
--ON purchasing.purchase_order_header
--AFTER INSERT, UPDATE, DELETE
--AS
--BEGIN
--  -- Update data di tabel stocks
--  UPDATE s
--  SET s.stock_quantity = ISNULL((SELECT SUM(pod.pode_stocked_qty) 
--                                FROM purchasing.purchase_order_detail pod
--                                JOIN purchasing.purchase_order_header poh ON poh.pohe_id = pod.pode_pohe_id
--                                WHERE s.stock_id = pod.pode_stock_id and poh.pohe_status = 4), 0)
--  FROM purchasing.stocks s;
--END;
--GO

-- TRIGGER MODULE PAYMENT
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Create identity in Entity table and insert bank 
-- =============================================
CREATE TRIGGER Payment.InsertBankEntityId
   ON  Payment.bank 
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
		DECLARE @bank_code As nvarchar(10)
		DECLARE @bank_name As nvarchar(55)

		SELECT @bank_code = bank_code FROM inserted;
		SELECT @bank_name = bank_name FROM inserted;

    -- Insert statements for trigger here
		 INSERT 
			 INTO Payment.entity 
		DEFAULT VALUES

		INSERT 
			INTO Payment.bank (bank_entity_id, bank_code, bank_name, bank_modified_date) 
		VALUES (SCOPE_IDENTITY(), @bank_code, @bank_name, GETDATE())  
END
GO  

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Create identity in Entity table and insert payment 
-- =============================================
CREATE TRIGGER Payment.InsertPaymentEntityId
   ON  Payment.payment_gateway 
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
		DECLARE @paga_code As nvarchar(10)
		DECLARE @paga_name As nvarchar(55)

		SELECT @paga_code = paga_code FROM inserted;
		SELECT @paga_name = paga_name FROM inserted;

    -- Insert statements for trigger here
		 INSERT 
			 INTO Payment.entity 
		DEFAULT VALUES

		INSERT 
			INTO Payment.payment_gateway (paga_entity_id, paga_code, paga_name, paga_modified_date) 
		VALUES (SCOPE_IDENTITY(), @paga_code, @paga_name, GETDATE())
END
GO
