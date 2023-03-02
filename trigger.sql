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
  BEGIN TRY
    BEGIN TRANSACTION

    UPDATE purchasing.vendor
    SET
      vendor_name = @name,
      vendor_active = @active,
      vendor_priority = @priority,
      vendor_modified_date = GETDATE(),
      vendor_weburl = @weburl
    WHERE
      vendor_entity_id = @id;

    COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION
    THROW;
  END CATCH
END
GO

DROP PROCEDURE IF EXISTS spUpdateStocks;
GO

CREATE PROCEDURE purchasing.spUpdateStocks
  @id INT,
  @name NVARCHAR(255),
  @description NVARCHAR(255),
  @size NVARCHAR(25),
  @color NVARCHAR(15)
AS
BEGIN
  SET NOCOUNT ON;

  BEGIN TRY
      BEGIN TRANSACTION
          UPDATE purchasing.stocks
          SET stock_name = @name,
              stock_description = @description,
              stock_size = @size,
              stock_color = @color,
              stock_modified_date = GETDATE()
          WHERE stock_id = @id
      COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION
    THROW;
  END CATCH
END
GO


DROP PROCEDURE IF EXISTS spUpdateStockPhoto;
GO

CREATE PROCEDURE purchasing.spUpdateStockPhoto
  @id INT,
  @thumbnail NVARCHAR(50),
  @photo NVARCHAR(50),
  @primary BIT,
  @url NVARCHAR(255),
  @stockId INT
AS
BEGIN
  SET NOCOUNT ON;

  BEGIN TRY
      BEGIN TRANSACTION
          UPDATE purchasing.stock_photo
          SET spho_thumbnail_filename = @thumbnail,
              spho_photo_filename = @photo,
              spho_primary = @primary,
              spho_url = @url,
              spho_stock_id = @stockId
          WHERE spho_id = @id
      COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION
    THROW;
  END CATCH
END
GO


-----create Store Procedure Update For Table 'Purchase Order Header'

DROP PROCEDURE IF EXISTS SpUpdatePohe;
GO

CREATE PROCEDURE [Purchasing].[spUpdatePohe]
    @ID int,
    @Number nvarchar(20),
    @PoheStatus tinyint,
    @PoheTax decimal(10,2),
    @PoheRefund decimal(10,2),
    @PoheArrivalDate date,
    @PohePayType nchar(2),
    @PoheEmpID int,
    @PoheVendorID int
AS
BEGIN
  SET NOCOUNT ON;
    
    BEGIN TRY
      BEGIN TRANSACTION
        UPDATE purchasing.purchase_order_header
        SET pohe_number = @Number,
            pohe_status = @PoheStatus,
            pohe_tax = @PoheTax,
            pohe_refund = @PoheRefund,
            pohe_arrival_date = @PoheArrivalDate,
            pohe_pay_type = @PohePayType,
            pohe_emp_id = @PoheEmpID,
            pohe_vendor_id = @PoheVendorID
        WHERE pohe_id = @ID
      COMMIT TRANSACTION
    END TRY
      BEGIN CATCH
      IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION
      THROW;
    END CATCH
END
GO


-----create Store Procedure Update For Table 'Purchase Order Detail'

DROP PROCEDURE IF EXISTS spUpdatePode;
GO

CREATE PROCEDURE [Purchasing].[spUpdatePode]
      @PodeId int,
      @podePoheId int, 
      @PodeOrderQty smallint, 
      @PodePrice money,
      @PodeReceivedQty decimal(8,2),
      @PodeRejectedQty decimal (8,2),
      @PodeStockId int
AS
BEGIN
  SET NOCOUNT ON;
		
    BEGIN TRY
      BEGIN TRANSACTION
        UPDATE purchasing.purchase_order_detail
            SET pode_pohe_id = @podePoheId, 
              pode_order_qty = @PodeOrderQty, 
              pode_price = @PodePrice, 
              pode_received_qty = @PodeReceivedQty,
              pode_rejected_qty=@PodeRejectedQty,
              pode_stock_id =@PodeStockId
            WHERE pode_id = @PodeId
      COMMIT TRANSACTION
    END TRY
      BEGIN CATCH
      IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION
      THROW;
    END CATCH
END
GO

--USE Northwind
--GO
--USE Hotel_Realta;
--GO

--DROP PROCEDURE IF EXISTS purchasing.spInsertPurchaseOrder;
--GO

CREATE PROCEDURE purchasing.spInsertPurchaseOrder
    @pohe_emp_id INT,
    @pohe_vendor_id INT,
	@pohe_pay_type NCHAR(2),
    @pode_order_qty SMALLINT,
    @pode_price MONEY,
    @pode_stock_id INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @pohe_id INT;
			DECLARE @pode_id INT;
			DECLARE @pohe_status TINYINT;
	
			DECLARE @pode_rejected_qty INT = 0;
			DECLARE @pode_received_qty INT = 0;

			--DECLARE @pohe_number NVARCHAR(20);
			DECLARE @pohe_number NVARCHAR(20) = 'PO-' + CONVERT(NVARCHAR(8), GETDATE(), 112) + '-001';

			IF EXISTS (
				SELECT TOP 1 1
				FROM purchasing.purchase_order_header
				WHERE pohe_number LIKE 'PO-' + CONVERT(NVARCHAR(8), GETDATE(), 112) + '-%'
				ORDER BY pohe_number DESC
			)
			BEGIN
				SELECT TOP 1 @pohe_number = 'PO-' + CONVERT(NVARCHAR(8), GETDATE(), 112) + '-' + RIGHT('000' + CAST(CAST(RIGHT(pohe_number, 3) AS INT) + 1 AS NVARCHAR(3)), 3)
				FROM purchasing.purchase_order_header
				WHERE pohe_number LIKE 'PO-' + CONVERT(NVARCHAR(8), GETDATE(), 112) + '-%'
				ORDER BY pohe_number DESC;
			END

			-- Check if the vendor exists and has an active PO
			SELECT @pohe_id = pohe_id, @pohe_status = pohe_status
			FROM purchasing.purchase_order_header
			WHERE pohe_vendor_id = @pohe_vendor_id
			AND pohe_status = 1;

			IF @pohe_id IS NOT NULL
			BEGIN 
				-- Vendor has an active PO, check if stock exists in PO
				SELECT @pode_id = pode_id
				FROM purchasing.purchase_order_detail
				WHERE pode_pohe_id = @pohe_id
				AND pode_stock_id = @pode_stock_id;

				IF @pode_id IS NOT NULL
				BEGIN
					-- Stock exists in PO, update order quantity
					UPDATE purchasing.purchase_order_detail
					SET pode_order_qty = pode_order_qty + @pode_order_qty
					WHERE pode_id = @pode_id;
				END
				ELSE
				BEGIN
					-- Stock does not exist in PO, insert new detail
					INSERT INTO purchasing.purchase_order_detail (
						pode_pohe_id,
						pode_order_qty,
						pode_price,
						pode_stock_id,
						pode_rejected_qty,
						pode_received_qty
					)
					VALUES (
						@pohe_id,
						@pode_order_qty,
						@pode_price,
						@pode_stock_id,
						@pode_rejected_qty,
						@pode_received_qty
					);
				END
			END
			ELSE
			BEGIN
				-- Vendor does not have an active PO, create new PO
				INSERT INTO purchasing.purchase_order_header (
					pohe_number,
					pohe_emp_id,
					pohe_vendor_id,
					pohe_pay_type
				)
				VALUES (
					@pohe_number,
					@pohe_emp_id,
					@pohe_vendor_id,
					@pohe_pay_type
				);

				SET @pohe_id = SCOPE_IDENTITY();

				-- Insert detail
				INSERT INTO purchasing.purchase_order_detail (
					pode_pohe_id,
					pode_order_qty,
					pode_price,
					pode_stock_id,
					pode_rejected_qty,
					pode_received_qty
				)
				VALUES (
					@pohe_id,
					@pode_order_qty,
					@pode_price,
					@pode_stock_id,
					@pode_rejected_qty,
					@pode_received_qty
				);
			END
		COMMIT TRANSACTION
	END TRY
    BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
		THROW;
    END CATCH
END
GO

CREATE PROCEDURE purchasing.spDeletePurchaseOrder
    @pohe_number NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION
        
        DECLARE @pohe_id INT
        
        -- Get pohe_id from pohe_number
        SELECT @pohe_id = pohe_id
        FROM purchasing.purchase_order_header
        WHERE pohe_number = @pohe_number
        
        IF @pohe_id IS NOT NULL
        BEGIN
            -- Delete detail records
            DELETE FROM purchasing.purchase_order_detail
            WHERE pode_pohe_id = @pohe_id
            
            -- Delete header record
            DELETE FROM purchasing.purchase_order_header
            WHERE pohe_id = @pohe_id
        END
        
        COMMIT TRANSACTION
    END TRY
    
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        -- Throw error message
        THROW;
    END CATCH
END
GO



-- purchasing.spUpdateVendor @id = 15, @name = "abcde", @active = false, @priority = true, @weburl = NULL
-- GO
-- purchasing.spUpdateStocks @id = 6, @name = "abcde", @description = "abc", @size = "abc", @color = "abc"
-- GO

-- select * from purchasing.vendor
-- select * from purchasing.stocks
-- select * from purchasing.stock_photo

--SELECT * from INFORMATION_SCHEMA.columns where table_name = 'stock_photo'
-- USE Northwind;
-- GO