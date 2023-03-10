USE Hotel_Realta
GO

-- STORE PROCEDURE MODULE PAYMENT
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Store Procedure for updating Bank
-- =============================================
CREATE PROCEDURE Payment.spUpdateBank 
	-- Add the parameters for the stored procedure here
	@id int,
	@code nvarchar(10),
	@name nvarchar(55)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
		UPDATE [Payment].[bank] 
			 SET [bank_code] = @code,
					 [bank_name] = @name,
					 [bank_modified_date] = GETDATE()
		 WHERE [bank_entity_id] = @id
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Store Procedure for updating PaymentGateway
-- =============================================
CREATE PROCEDURE Payment.spUpdatePaymentGateway
	-- Add the parameters for the stored procedure here
	@id int,
	@code nvarchar(10),
	@name nvarchar(55)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
		UPDATE [Payment].[payment_gateway] 
			 SET [paga_code] = @code,
					 [paga_name] = @name,
					 [paga_modified_date] = GETDATE()
		 WHERE [paga_entity_id] = @id
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 09 January 2023
-- Description:	Stored Procedure for update UserAccount
-- =============================================
CREATE PROCEDURE Payment.spUpdateUserAccount 
	-- Add the parameters for the stored procedure here
	@find_entity_id As int,
	@find_user_id As int
	-- Parameters for update UserAccount
	,@set_entity_id As int
	,@set_user_id As int
	,@account_number As varchar(25)
	,@saldo As money
	,@type As nvarchar(15)
	,@expmonth As tinyint
	,@expyear As smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
		DECLARE @modified As datetime
		SET @modified = GETDATE()
	-- Insert statements for procedure here
		UPDATE [Payment].[user_accounts]
			 SET [usac_entity_id] = @set_entity_id
					,[usac_user_id] = @set_user_id
					,[usac_account_number] = @account_number
					,[usac_saldo] = @saldo
					,[usac_type] = @type
					,[usac_expmonth] = @expmonth
					,[usac_expyear] = @expyear
					,[usac_modified_date] = @modified
		 WHERE usac_entity_id = @find_entity_id AND usac_user_id = @find_user_id
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 9 Januari 2023
-- Description:	Stored procedure for updating payment_transaction 
-- =============================================
CREATE PROCEDURE Payment.spUpdatePaymentTransaction 
	-- Add the parameters for the stored procedure here
	@id int
	,@trx_number nvarchar(55)
	,@debet money
	,@credit money
	,@type nchar(3)
	,@note nvarchar(255)
	,@order_number nvarchar(55)
	,@source_id int
	,@target_id int
	,@trx_number_ref nvarchar(55)
	,@user_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
		UPDATE [Payment].[payment_transaction]
		 SET [patr_trx_number] = @trx_number
				,[patr_debet] = @debet
				,[patr_credit] = @credit
				,[patr_type] = @type
				,[patr_note] = @note
				,[patr_modified_date] = GETDATE()
				,[patr_order_number] = @order_number
				,[patr_source_id] = @source_id
				,[patr_target_id] = @target_id
				,[patr_trx_number_ref] = @trx_number_ref
				,[patr_user_id] = @user_id
	 WHERE [patr_id] = @id
END
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

-- ===========================================================
-- Author:		Riyan
-- Create date: 3 March 2023
-- Description:	Store Procedure for Insert Purchase Order
-- ===========================================================

drop procedure purchasing.spInsertPurchaseOrder;
CREATE PROCEDURE purchasing.spInsertPurchaseOrder
	@pay_type NCHAR(2),
	@cart_id INT
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
			
			DECLARE @vendor_id INT;
			DECLARE @emp_id INT;
			DECLARE @stock_id INT;
			DECLARE @price MONEY;
			DECLARE @order_qty INT;

			SELECT @vendor_id = vp.vepro_vendor_id, 
					@stock_id = vp.venpro_stock_id, 
					@price = vp.vepro_price,
					@order_qty = c.cart_order_qty,
					@emp_id = c.cart_emp_id
			FROM purchasing.cart AS c 
			JOIN purchasing.vendor_product as vp ON vp.vepro_id = c.cart_vepro_id
			WHERE cart_id = @cart_id;

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
			WHERE pohe_vendor_id = @vendor_id
			AND pohe_status = 1;

			IF @pohe_id IS NOT NULL
			BEGIN 
				-- Vendor has an active PO, check if stock exists in PO
				SELECT @pode_id = pode_id
				FROM purchasing.purchase_order_detail
				WHERE pode_pohe_id = @pohe_id
				AND pode_stock_id = @stock_id;

				IF @pode_id IS NOT NULL
				BEGIN
					-- Stock exists in PO, update order quantity
					UPDATE purchasing.purchase_order_detail
					SET pode_order_qty = pode_order_qty + @order_qty
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
						@order_qty,
						@price,
						@stock_id,
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
					@emp_id,
					@vendor_id,
					@pay_type
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
					@order_qty,
					@price,
					@stock_id,
					@pode_rejected_qty,
					@pode_received_qty
				);
			END
			DELETE FROM purchasing.cart WHERE cart_id = @cart_id;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
		THROW;
	END CATCH
END
GO



-- ===========================================================
-- Author:		Riyan
-- Create date: 3 March 2023
-- Description:	Store Procedure for Delete Purchase Order
-- ===========================================================

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

-- =============================================
-- Author:		Muh Fadel marzuki
-- Create date: 3 March 2023
-- Description:	Store Procedure Generate Barcode
-- =============================================
create or alter  procedure Purchasing.GenerateBarcode
(
-- Add the parameters for the stored procedure here
	@PodeId int,
	@PodeQyt int,
	@PodeReceivedQty int,
	@PodeRejectQty int
) as
	declare @i int = 1;
	declare @stockID int;
	declare @poheStatus int;
	declare @OldpodeReceivedQty decimal;
begin
	-- Declare status Purchasing.purchase_order_header and declare Purchasing.purchase_order_detail
	select @poheStatus=po.pohe_status, @OldpodeReceivedQty=FLOOR(pd.pode_received_qty) from Purchasing.purchase_order_detail pd 
	inner join Purchasing.purchase_order_header po on pd.pode_pohe_id=po.pohe_id
	where pd.pode_id = @PodeId
	begin try
		begin transaction
		-- Generate must check this all condition
		IF @PodeReceivedQty > 0 and @poheStatus = 4 
			and @PodeReceivedQty > @OldpodeReceivedQty 
			and @PodeQyt > @PodeReceivedQty
			and (@PodeReceivedQty + @PodeRejectQty) = @PodeQyt
		Begin
		-- loop insert statement procedure Here
			While @i <= @PodeReceivedQty
			Begin
				INSERT INTO purchasing.stock_detail (stod_stock_id, stod_barcode_number,
				 stod_pohe_id) select pode_stock_id, 
				CONCAT('BC' ,  substring(replace(convert(nvarchar(100), NEWID()), '-', ''), 1, 10) ),
				pode_pohe_id from Purchasing.purchase_order_detail where pode_id = @PodeId;
				set @i = @i +1;
			End
			begin
				-- declare stock id
				select @stockID=pode_stock_id from Purchasing.purchase_order_detail where pode_id = @PodeId;

				-- update after insert statement
				update Purchasing.stocks
					set 
						stock_quantity = (select count(stod_id) 
							from Purchasing.stock_detail where stod_stock_id =@stockID),
						stock_used = (select count(case when stod_status = N'2' then 1 else null end) 
							from Purchasing.stock_detail where stod_stock_id =@stockID),
						stock_scrap = (select count(case when stod_status = N'3' then 1 else null end) 
							from Purchasing.stock_detail where stod_stock_id =@stockID)
					where stock_id = @stockID;
			end
		End
		Print 'Generate Barcode successfully';
		commit transaction
	end try
	begin catch
		rollback;
		print 'Generate Barcode Is Failed';
		throw;
	end catch 
end
go 

-- =============================================
-- Author:		Muh Fadel marzuki
-- Create date: 3 March 2023
-- Description:	Store Procedure Update Stock Detail
-- =============================================
create or alter procedure [Purchasing].[spUpdateStockDetail]
(
	-- Add the parameters for the stored procedure here
	@stodId int,
	@stodStockId int, 
	@stodStatus nchar,
	@stodNotes text,
	@stodFaciId int
) as
	declare @updateStatus int;
	declare @stockID int;
begin
	begin try
		begin transaction
			-- updates statement 1 for procedure here
			begin
				UPDATE purchasing.stock_detail SET 
				stod_stock_id=@stodStockId, stod_status=@stodStatus, 
				stod_notes=@stodNotes, stod_faci_id=@stodFaciId 
				WHERE stod_id=@stodId;
			end

			begin
				select @stockID=stod_stock_id from Purchasing.stock_detail where stod_id = @stodId;
				-- updates statement 2 for procedure here
				update Purchasing.stocks
					set 
						stock_quantity = (select count(stod_id) 
							from Purchasing.stock_detail where stod_stock_id =@stockID),
						stock_used = (select count(case when stod_status = N'2' then 1 else null end) 
							from Purchasing.stock_detail where stod_stock_id =@stockID),
						stock_scrap = (select count(case when stod_status = N'3' then 1 else null end) 
							from Purchasing.stock_detail where stod_stock_id =@stockID)
				where stock_id = @stockID;
			end
			Print 'Update status for stod_id = '+ cast(@stodId as nvarchar(25))+' successfully';
		commit transaction
	end try
	begin catch
		rollback;
		print 'Transaction Rollback for stod_id = ' + cast(@stodId as nvarchar(25));
		throw;
	end catch 
end
