USE Hotel_Realta;
GO

-- DROP TRIGGER purchasing.tr_purchase_order_detail;
-- GO

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

