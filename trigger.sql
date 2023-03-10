USE Hotel_Realta;
GO

DROP TRIGGER IF EXISTS purchasing.tr_vendor_modified_date;
DROP TRIGGER IF EXISTS purchasing.tr_stocks_modified_date;
DROP TRIGGER IF EXISTS purchasing.tr_pode_modified_date;
DROP TRIGGER IF EXISTS purchasing.tr_delete_header_if_no_detail;
DROP TRIGGER IF EXISTS purchasing.tr_update_sub_total;
DROP PROCEDURE IF EXISTS purchasing.spUpdateVendor;
DROP PROCEDURE IF EXISTS purchasing.spUpdateStocks;
DROP PROCEDURE IF EXISTS purchasing.spUpdateStockPhoto;
DROP PROCEDURE IF EXISTS purchasing.spUpdatePohe;
DROP PROCEDURE IF EXISTS purchasing.spUpdatePode;
DROP PROCEDURE IF EXISTS purchasing.spInsertPurchaseOrder;
DROP PROCEDURE IF EXISTS purchasing.spDeletePurchaseOrder;
DROP PROCEDURE IF EXISTS purchasing.tr_cart_delete_and_modified_date;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riyan
-- Create date: 6 February 2023
-- Description:	Delete PO Header if haven't Detail
-- =============================================
CREATE TRIGGER purchasing.tr_delete_header_if_no_detail
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

CREATE TRIGGER purchasing.tr_vendor_modified_date
ON purchasing.vendor
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.vendor
  SET vendor_modified_date = GETDATE()
  WHERE vendor_entity_id IN(SELECT vendor_entity_id FROM inserted)
END;
GO

CREATE TRIGGER purchasing.tr_stocks_modified_date
ON purchasing.stocks
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.stocks
  SET stock_modified_date = GETDATE()
  WHERE stock_id IN(SELECT stock_id FROM inserted)
END;
GO

-- =============================================
-- Author:		Riyan
-- Create date: 6 February 2023
-- Description:	Update Modified date
-- =============================================
CREATE TRIGGER purchasing.tr_pode_modified_date
ON purchasing.purchase_order_detail
AFTER UPDATE
AS
BEGIN
  UPDATE purchasing.purchase_order_detail
  SET pode_modified_date = GETDATE()
  WHERE pode_id IN(SELECT pode_id FROM inserted)
END;
GO

CREATE TRIGGER purchasing.tr_update_sub_total
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

-- =============================================
-- Author:		Riyan
-- Create date: 6 February 2023
-- Description:	Update cart_modified_date and delete cart if order qty < 1
-- =============================================
CREATE TRIGGER purchasing.tr_cart_delete_and_modified_date
ON purchasing.cart
FOR DELETE, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  -- hapus baris pada tabel jika cart_order_qty = 0
  DELETE FROM purchasing.cart
  WHERE cart_id IN (SELECT cart_id FROM inserted WHERE cart_order_qty = 0);

  -- perbarui nilai pada kolom cart_modified_date saat ada perubahan pada baris
  UPDATE purchasing.cart
  SET cart_modified_date = GETDATE()
  WHERE cart_id IN (SELECT cart_id FROM inserted);
END;

GO

DROP trigger if exists purchasing.tr_cart_merge_quantity;
GO
-- =============================================
-- Author:		Riyan
-- Create date: 6 February 2023
-- Description:	Check inserted cart
-- =============================================
CREATE TRIGGER purchasing.tr_cart_merge_quantity
ON purchasing.cart
INSTEAD OF INSERT
AS
BEGIN
	-- update kuantitas (qty) jika item vepro sudah ada pada cart
	UPDATE c
	SET cart_order_qty = c.cart_order_qty + i.cart_order_qty,
		cart_modified_date = GETDATE()
	FROM purchasing.cart AS c
	INNER JOIN inserted AS i ON c.cart_vepro_id = i.cart_vepro_id AND c.cart_emp_id = i.cart_emp_id;

	-- tambahkan item baru pada cart jika item vepro belum ada pada cart
	INSERT INTO purchasing.cart (cart_emp_id, cart_vepro_id, cart_order_qty)
	SELECT i.cart_emp_id, i.cart_vepro_id, i.cart_order_qty
	FROM inserted AS i
	WHERE NOT EXISTS (
		SELECT 1
		FROM purchasing.cart AS c
		WHERE c.cart_vepro_id = i.cart_vepro_id AND c.cart_emp_id = i.cart_emp_id
	);
END;
GO

-- TRIGGER MODULE PAYMENT


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
    OUTPUT INSERTED.bank_entity_id
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
    OUTPUT INSERTED.paga_entity_id
		VALUES (SCOPE_IDENTITY(), @paga_code, @paga_name, GETDATE())
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Create identity in Entity table and insert payment
-- =============================================
CREATE TRIGGER [Payment].[CalculateUserAccountCredit]
   ON  [Payment].[payment_transaction]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
		DECLARE @tar_account As nvarchar(50)
		DECLARE @src_account As nvarchar(50)
		DECLARE @transaction_type As nvarchar(10)
		DECLARE @xpse As Money

		SELECT @src_account = patr_source_id FROM inserted;
		SELECT @tar_account = patr_target_id FROM inserted;
		SELECT @transaction_type = patr_type FROM inserted;
		SELECT @xpse = (patr_credit + patr_debet) FROM inserted

    -- Insert statements for trigger here
		-- TOP UP
		IF @transaction_type = 'TP'
		BEGIN
			EXECUTE [Payment].[spTopUpTransaction]
				 @source_account = @src_account
				,@target_account = @tar_account
				,@expense = @xpse
		END

		-- TRANSFER BOOKING
		IF @transaction_type = 'TRB'
		BEGIN
			EXECUTE [Payment].[spTopUpTransaction]
				 @source_account = @src_account
				,@target_account = @tar_account
				,@expense = @xpse
		END

		-- REPAYMENT
		IF @transaction_type = 'RPY'
		BEGIN
			EXECUTE [Payment].[spTopUpTransaction]
				 @source_account = @src_account
				,@target_account = @tar_account
				,@expense = @xpse
		END

		-- REFUND
		IF @transaction_type = 'RF'
		BEGIN
			EXECUTE [Payment].[spTopUpTransaction]
				 @source_account = @tar_account
				,@target_account = @src_account
				,@expense =  @xpse
		END

		-- ORDER MENU
		IF @transaction_type = 'ORM'
		BEGIN
			EXECUTE [Payment].[spTopUpTransaction]
				 @source_account = @src_account
				,@target_account = @tar_account
				,@expense = @xpse
		END

		SELECT patr_id FROM inserted;
END
GO

-- =============================================
-- Author:		Hafiz 
-- Create date: 11 January 2023
-- Description:	Trigger to insert identity into payment.Entity table
			--	and also insert into purchasing.Vendor table
-- =============================================
CREATE TRIGGER Purchasing.InsertPaymentEntityId
   ON  Purchasing.Vendor
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		SET NOCOUNT ON

		DECLARE @vendorName nvarchar (55)
		DECLARE @vendorActive bit
		DECLARE @vendorPriority bit
		DECLARE @vendorWebURL nvarchar(1025)

		SELECT @vendorName = vendor_name FROM inserted;
		SELECT @vendorActive = vendor_active FROM inserted;
		SELECT @vendorPriority = vendor_priority FROM inserted;
		SELECT @vendorWebURL = vendor_weburl FROM inserted;

	-- Insert statements to Payment.Entity
		 INSERT 
			 INTO Payment.entity 
		DEFAULT VALUES

	-- Insert statements to Purchasing.Vendor
		INSERT 
			INTO Purchasing.Vendor(vendor_entity_id, vendor_name, vendor_active, vendor_priority, vendor_weburl) 
    OUTPUT INSERTED.vendor_entity_id
		VALUES (SCOPE_IDENTITY(), @vendorName, @vendorActive, @vendorPriority, @vendorWebURL)

END
GO