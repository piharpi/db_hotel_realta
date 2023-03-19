USE Hotel_Realta;
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
-- Description:	Stored procedure for create payment_transaction (UNUSED)
-- =============================================
CREATE PROCEDURE Payment.spCreatePaymentTransaction
	-- Add the parameters for the stored procedure here
    @debet money
    ,@credit money
    ,@type nchar(3)
    ,@note nvarchar(255)
    ,@order_number nvarchar(55)
    ,@source_id nvarchar(55)
    ,@target_id nvarchar(55)
    ,@trx_number_ref nvarchar(55)
    ,@user_id int
AS
BEGIN
    -- Generate transaction number
    DECLARE @trx_number nvarchar(55);
    SET @trx_number = CONCAT(TRIM(@type),'#',
                     CONVERT(varchar, GETDATE(), 12),'-',
                      RIGHT('0000' + CAST(IDENT_CURRENT('Payment.[payment_transaction]') AS NVARCHAR(4)), 4));

    -- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRANSACTION
        INSERT INTO [Payment].[payment_transaction](
                    patr_trx_number, patr_debet, patr_credit, patr_type, patr_note,
                    patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
            VALUES (@trx_number, @debet, @credit, @type, @note, @order_number, @source_id, @target_id, @trx_number_ref, @user_id)
    COMMIT TRANSACTION
    -- Insert statements for procedure here
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 9 Januari 2023
-- Description:	Stored procedure for updating payment_transaction (UNUSED)
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

CREATE PROCEDURE purchasing.spInsertPurchaseOrder
	@pay_type NCHAR(2),
	@cart_id INT
AS
BEGIN
	SET NOCOUNT ON;

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
end;
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 Februari 2023
-- Description:	User Defined Function, getAllPaymentType
-- =============================================
CREATE OR ALTER FUNCTION Payment.fnGetAllPaymentType()
    RETURNS TABLE
     AS
        RETURN
            SELECT en.entity_id Id,
                   CONCAT(ba.bank_code, pg.paga_code) Code,
                   CONCAT(bank_name, paga_name) Name
            FROM Payment.entity en
            LEFT JOIN Payment.bank ba
                ON en.entity_id = ba.bank_entity_id
            LEFT JOIN Payment.payment_gateway pg
                ON en.entity_id = pg.paga_entity_id
            WHERE pg.paga_code IS NOT NULL OR ba.bank_code IS NOT NULL;
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 Februari 2023
-- Description:	User Defined Function, getUserBalance
-- =============================================
CREATE OR ALTER FUNCTION Payment.fnGetUserBalance(@user_id INT)
    RETURNS TABLE
    AS
        RETURN
            SELECT user_id,
                   user_full_name,
                   usac.usac_type,
                   usac_account_number,
                   usac_saldo,
                   CONCAT(paga.paga_name, ba.bank_name) AS payment_name
            FROM users.users
            RIGHT JOIN payment.user_accounts usac
            ON users.user_id = usac.usac_user_id
            RIGHT JOIN payment.entity ent
            ON usac.usac_entity_id = ent.entity_id
            LEFT JOIN payment.payment_gateway paga
            ON ent.entity_id = paga.paga_entity_id
            LEFT JOIN Payment.bank ba
            ON ba.bank_entity_id = ent.entity_id
            WHERE usac_type IS NOT NULL AND usac_user_id = @user_id
;
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 Februari 2023
-- Description:	User defined function, formattedIdTransaction
-- =============================================
CREATE FUNCTION Payment.fnFormatedTransactionId(@transaction_id INT, @transaction_type NCHAR(5))
    RETURNS VARCHAR(55)
    AS BEGIN
        DECLARE @trx_number VARCHAR(55);
        SET @trx_number = CONCAT(TRIM(@transaction_type),'#',
                      CONVERT(varchar, GETDATE(), 12),'-',
                        RIGHT('0000' + CAST(@transaction_id AS NVARCHAR(4)), 4));
        RETURN @trx_number;
    END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 Februari 2023
-- Description:	User defined function, fnRefundAmount
-- =============================================
CREATE FUNCTION Payment.fnRefundAmount(@amount MONEY, @percentage FLOAT = 50.0)
    RETURNS MONEY
    BEGIN
        DECLARE @refund_amount MONEY
        DECLARE @refund_percentage FLOAT

        SET @refund_percentage = @percentage / 100.0;
        SET @refund_amount = @amount * @refund_percentage;

        RETURN @refund_amount
    END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 Februari 2023
-- Description:	Store Procedure for refund transfer
-- =============================================
CREATE OR ALTER PROCEDURE [Payment].[spRefundTransaction]
    @trx_number AS VARCHAR(50),
    @refund_rate AS FLOAT = 50,
    @total_amount AS MONEY OUTPUT
    AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @source_account VARCHAR(55);
                DECLARE @target_account VARCHAR(55);
                DECLARE @refund_amount MONEY;
                DECLARE @refund_age INT;

                SET @source_account = '131-3456-78';

                SELECT @refund_amount = Payment.fnRefundAmount((patr_credit + patr_debet), @refund_rate),
                       @refund_age = DATEDIFF(day, patr_modified_date, GETDATE()),
                       @target_account = patr_source_id
                FROM Payment.payment_transaction
                WHERE patr_trx_number = @trx_number

--                 IF (@refund_amount > 0.0 AND @refund_age < 7)
--                 BEGIN
                    -- refund from realta bank account to customer user account
                    EXECUTE [Payment].spTranferMoney
                            @source_account
                            ,@target_account
                            ,@refund_amount
--
                    SET @total_amount = @refund_amount;
--                 END
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
        END CATCH
    END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 March 2023
-- Description:	Store Procedure for create transfer repayment
-- =============================================
CREATE OR ALTER PROCEDURE [Payment].[spCreateTransferRepayment]
       @boor_order_number VARCHAR(50)
       ,@boor_card_number VARCHAR(50)
       ,@boor_user_id INT
AS
BEGIN
    INSERT
      INTO Payment.payment_transaction(patr_type, patr_note, patr_order_number, patr_source_id, patr_target_id, patr_user_id)
    VALUES ('RPY', 'Repayment', @boor_order_number, @boor_card_number, '131-3456-78', @boor_user_id);
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 March 2023
-- Description:	Store Procedure for create transfer booking
-- =============================================
CREATE OR ALTER PROCEDURE [Payment].[spCreateTransferTopUp]
   @source_account VARCHAR(50)
   ,@target_account VARCHAR(50)
   ,@boor_user_id INT
   ,@amount AS MONEY
AS
BEGIN
    INSERT
      INTO Payment.payment_transaction(patr_credit, patr_type, patr_note,
                                      patr_source_id, patr_target_id, patr_user_id)
    VALUES (@amount, 'TP', 'Top Up Note', @source_account, @target_account, @boor_user_id);
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 March 2023
-- Description:	Store Procedure for create transfer booking
-- =============================================
CREATE PROCEDURE [Payment].[spCreateTransferBooking]
       @boor_order_number VARCHAR(50)
       ,@boor_card_number VARCHAR(50)
       ,@boor_user_id INT
AS
BEGIN
    INSERT
      INTO Payment.payment_transaction(patr_type, patr_note, patr_order_number, patr_source_id, patr_target_id, patr_user_id)
    VALUES ('TRB', 'Transfer Booking Note', @boor_order_number, @boor_card_number, '131-3456-78', @boor_user_id);
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 March 2023
-- Description:	Store Procedure for create transfer orderMenu
-- =============================================
CREATE PROCEDURE [Payment].[spCreateTransferOrderMenu]
       @orme_order_number VARCHAR(50)
       ,@orme_card_number VARCHAR(50)
       ,@orme_user_id INT
AS
BEGIN
    INSERT
      INTO Payment.payment_transaction(patr_type, patr_note, patr_order_number, patr_source_id, patr_target_id, patr_user_id)
    VALUES ('ORM', 'Transfer Order Menu Note', @orme_order_number, @orme_card_number, '131-3456-78', @orme_user_id);
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 13 March 2023
-- Description:	Store Procedure for create transfer refund money
-- =============================================
CREATE OR ALTER PROCEDURE [Payment].[spCreateTransferRefund]
       @boor_order_number VARCHAR(50)
       ,@boor_user_id INT
AS
BEGIN
    INSERT
      INTO Payment.payment_transaction(patr_type, patr_note, patr_order_number, patr_user_id)
    VALUES ('RF', '*Refund Booking Order', @boor_order_number, @boor_user_id);
END
GO


-- =============================================
-- Author:		Harpi
-- Create date: 13 March 2023
-- Description:	Store Procedure for tranfer money (manipulation)
-- =============================================
CREATE OR ALTER PROCEDURE [Payment].spTranferMoney
    @source_account AS VARCHAR(50),
    @target_account AS VARCHAR(50),
    @amount AS MONEY
  AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            -- from source account
           UPDATE Payment.user_accounts
              SET usac_saldo = usac_saldo - @amount,
                  usac_modified_date = GETDATE()
            WHERE usac_account_number = @source_account;

            -- to target account
            UPDATE Payment.user_accounts
               SET usac_saldo = usac_saldo + @amount,
                   usac_modified_date = GETDATE()
             WHERE usac_account_number = @target_account;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK;
    END CATCH
END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Store Procedure for transfer booking transaction
-- =============================================
CREATE OR ALTER PROC [Payment].[spCalculationTranferBooking]
    @source_account AS NVARCHAR(50),
    @target_account AS NVARCHAR(50),
    @order_number AS NVARCHAR(50),
    @total_amount AS MONEY OUTPUT
    AS
    BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @user_payment_method varchar(10);
                DECLARE @user_current_saldo AS MONEY;
                DECLARE @total_down_payment AS MONEY;
                DECLARE @payment_option AS NCHAR(2);

                SELECT @total_amount = boor_total_ammount,
                       @total_down_payment = boor_down_payment,
                       @payment_option = TRIM(boor_is_paid),
                       @user_payment_method = boor_pay_type
                FROM Booking.booking_orders
                WHERE boor_order_number = @order_number

                -- set value @user_current_saldo
                SELECT @user_current_saldo = usac_saldo
                  FROM Payment.user_accounts
                 WHERE usac_account_number = @source_account

                -- check if the payment method is 'cash' just ignore it
                -- CR = credit_card
                -- D = debet
                -- PG = payment / payment_gateway
                IF (@user_payment_method IN ('D', 'CR', 'PG'))
                BEGIN
                    IF @user_payment_method = 'D' OR @user_payment_method = 'PG'
                    BEGIN
                        -- check if payment option is 'Down Payment'
                        IF (@payment_option = 'DP' AND (@user_current_saldo - @total_down_payment) < 0)
                            ROLLBACK -- TODO : Tambahkan feature untuk pemberitahuan bahwa saldo kurang utk dp!

                        -- check if payment options is 'Paid'
                        IF (@payment_option = 'P' AND (@user_current_saldo - @total_amount) < 0)
                            ROLLBACK -- TODO : Tambahkan feature untuk pemberitahuan bahwa saldo kurang!
                    ELSE
                    -- change total_amount if transaction is 'Down Payment'
                        SET @total_amount = @total_down_payment IF @payment_option = 'DP'

                        -- TODO : check apakah lunas atau tidak , jika lunas status paid jika tidak maka lainya!
                        -- paying booking order from user account to realta hotel account
                        EXECUTE [Payment].spTranferMoney
                                @source_account
                                ,@target_account
                                ,@total_amount
                    END


                END
                        -- IF (@@ROWCOUNT > 0)
--                     BEGIN
--                            UPDATE [Booking].[booking_orders]
--                             SET boor_is_paid = 'P'
--                             WHERE boor_order_number = @order_number;
--
--                            SELECT 'SUCCESS' AS STATUS
--                     END
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
            ROLLBACK
        END CATCH
    END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Store Procedure for transfer repayment transaction
-- =============================================
CREATE OR ALTER PROC [Payment].[spRepaymentTransaction]
    @source_account AS NVARCHAR(50),
    @target_account AS NVARCHAR(50),
    @order_number AS NVARCHAR(50),
    @bill_total AS MONEY OUTPUT
    AS
    BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @user_payment_method varchar(10);
                DECLARE @user_current_saldo AS MONEY;
                DECLARE @payment_option AS NCHAR(2);

                SELECT @bill_total = (boor_total_ammount - boor_down_payment),
                       @payment_option = TRIM(boor_is_paid),
                       @user_payment_method = TRIM(boor_pay_type)
                FROM Booking.booking_orders
                WHERE boor_order_number = @order_number

                -- set value @user_current_saldo
                SELECT @user_current_saldo = usac_saldo
                  FROM Payment.user_accounts
                 WHERE usac_account_number = @source_account

                -- check if the payment method is 'cash' just ignore it
                -- CR = credit_card
                -- D = debet
                -- PG = payment / payment_gateway
                IF (@user_payment_method IN ('D', 'CR', 'PG'))
                BEGIN
                    IF @user_payment_method = 'D' OR @user_payment_method = 'PG'
                    BEGIN
                        -- check if payment option is 'Down Payment'
                        IF (@payment_option != 'DP' OR (@user_current_saldo - @bill_total) < 0)
                            ROLLBACK -- TODO : Tambahkan feature untuk pemberitahuan bahwa saldo kurang utk dp!
                    ELSE
                        -- TODO : check apakah lunas atau tidak , jika lunas status paid jika tidak maka lainya!
                        -- paying booking order from user account to realta hotel account
                        EXECUTE [Payment].spTranferMoney
                                @source_account
                                ,@target_account
                                ,@bill_total
                    END
                END
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
            ROLLBACK
        END CATCH
    END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Store Procedure for transfer booking transaction
-- =============================================
CREATE OR ALTER PROC [Payment].[spCalculationTranferOrderMenu]
    @source_account AS NVARCHAR(50),
    @target_account AS NVARCHAR(50),
    @order_number AS NVARCHAR(50),
    @total_amount AS MONEY OUTPUT
    AS
    BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
            BEGIN TRANSACTION
                DECLARE @user_payment_method varchar(10);
                DECLARE @user_current_saldo AS MONEY;
                DECLARE @payment_option AS NCHAR(2);

                SELECT @total_amount = orme_total_amount,
                       @payment_option = TRIM(orme_is_paid),
                       @user_payment_method = orme_pay_type
                FROM Resto.order_menus
                WHERE orme_order_number = @order_number

                -- set value @user_current_saldo
                SELECT @user_current_saldo = usac_saldo
                  FROM Payment.user_accounts
                 WHERE usac_account_number = @source_account

                -- check if the payment method is 'cash' just ignore it
                -- CR = credit_card
                -- D = debet
                -- PG = payment / payment_gateway
                IF (@user_payment_method IN ('D', 'CR', 'PG'))
                BEGIN
                    IF @user_payment_method = 'D' OR @user_payment_method = 'PG'
                    BEGIN
                        -- check if payment option is 'Down Payment'
--                         IF (@payment_option = 'DP' AND (@user_current_saldo - @total_down_payment) < 0)
--                             ROLLBACK -- TODO : Tambahkan feature untuk pemberitahuan bahwa saldo kurang utk dp!

                        -- check if payment options is 'Paid'
                       IF ((@user_current_saldo - @total_amount) < 0)
                            ROLLBACK

--                         IF (@payment_option = 'P' AND (@user_current_saldo - @total_amount) < 0)
--                             ROLLBACK -- TODO : Tambahkan feature untuk pemberitahuan bahwa saldo kurang!
                    ELSE
                        -- TODO : check apakah lunas atau tidak , jika lunas status paid jika tidak maka lainya!
                        -- paying booking order from user account to realta hotel account
                        EXECUTE [Payment].spTranferMoney
                                @source_account
                                ,@target_account
                                ,@total_amount
                    END
                END
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
            ROLLBACK
        END CATCH
    END
GO

-- =============================================
-- Author:		Harpi
-- Create date: 8 January 2023
-- Description:	Store Procedure for top up transaction
-- =============================================
CREATE PROCEDURE [Payment].[spTopUpTransaction]
	-- Add the parameters for the stored procedure here
	 @source_account As nvarchar(50),
	 @target_account As nvarchar(50),
	 @amount As money = 0
AS
BEGIN
    DECLARE @source_usac_type varchar(50);
    DECLARE @target_usac_type varchar(50);
    DECLARE @usac_current_saldo AS MONEY;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- TOP UP
    BEGIN TRY
        BEGIN TRANSACTION

            -- set value @source_usac_type
            SELECT @source_usac_type = usac_type,
                   @usac_current_saldo = usac_saldo
              FROM Payment.user_accounts
             WHERE usac_account_number = @source_account

            -- set value @target_usac_type
            SELECT @target_usac_type = usac_type
              FROM Payment.user_accounts
             WHERE usac_account_number = @target_account

            -- top up from user bank account
            IF (@source_usac_type = 'debet' OR @source_usac_type = 'credit_card')
            BEGIN
                IF @source_usac_type = 'debet'
                BEGIN
                    IF @usac_current_saldo-@amount < 0
                        ROLLBACK
                ELSE
                    -- to fintech
                    IF (@target_usac_type = 'payment')
                    BEGIN
                        EXECUTE [Payment].spTranferMoney
                            @source_account
                            ,@target_account
                            ,@amount
                    END
                END
            END
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO

-- ===========================================================
-- Author	  :	Alvan Ganteng
-- Create date: 7 March 2023
-- Description:	Store Procedure for SELECT Hotel.Hotels
-- ===========================================================

CREATE PROCEDURE [Hotel].[spSelectHotel]
AS
BEGIN
	SET NOCOUNT	ON;

	SELECT
		hotel_id AS HotelId
		,hotel_name AS HotelName
		,hotel_description AS HotelDescription
		,hotel_status AS HotelStatus
		,hotel_reason_status AS HotelReasonStatus
		,hotel_rating_star AS HotelRatingStar
		,hotel_phonenumber AS HotelPhonenumber
		,hotel_modified_date AS HotelModifiedDate
		,hotel_addr_id AS HotelAddrId
		,hotel_addr_description AS HotelAddrDescription
	FROM Hotel.Hotels
END;
GO

-- =============================================
-- Author:		Hendri Praminiarto
-- Create date: 11 March 2023
-- Description:	Store Procedure Resto Menus
-- =============================================

CREATE PROCEDURE [resto].[create_order_menu_detail]
	@omde_reme_id INT,
	@orme_price MONEY,
	@orme_qty SMALLINT,
	@orme_discount SMALLMONEY,
	@orme_pay_type NCHAR(2),
	@orme_cardnumber NVARCHAR(25),
	@orme_is_paid NCHAR(2),
	@orme_user_id INT,
	@orme_status NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
    BEGIN TRANSACTION;

    -- Check if user_id exists and order status is Open
    IF EXISTS (SELECT 1
		FROM Users.users
		WHERE user_id = @orme_user_id) AND @orme_status = 'Open'
    BEGIN
		DECLARE @orme_id INT;

		-- Get orme_id for reference in omde_orme_id
		SELECT @orme_id = orme_id
		FROM Resto.order_menus
		WHERE orme_user_id = @orme_user_id AND orme_status = 'Open';

		-- Check if omde_reme_id exists in order_menu_detail
		IF EXISTS (SELECT 1
		FROM Resto.order_menu_detail
		WHERE omde_orme_id = @orme_id AND omde_reme_id = @omde_reme_id)
      BEGIN
			-- Update orme_qty if omde_reme_id exists
			UPDATE Resto.order_menu_detail
        SET orme_qty = orme_qty + @orme_qty
        WHERE omde_orme_id = @orme_id AND omde_reme_id = @omde_reme_id;
		END
      ELSE
      BEGIN
			-- Insert new detail if omde_reme_id doesn't exist
			INSERT INTO Resto.order_menu_detail
				(orme_price, orme_qty, orme_discount, omde_orme_id, omde_reme_id)
			VALUES
				(@orme_price, @orme_qty, @orme_discount, @orme_id, @omde_reme_id);
		END
	END
    ELSE
    BEGIN
		DECLARE @orme_order_number NVARCHAR(55), @orme_id_2 INT;

		-- Generate order number
		SELECT @orme_order_number = CONCAT('Menus#', CONVERT(NVARCHAR(10), GETDATE(), 112), '-',
                                          RIGHT('0000' + CAST((SELECT COUNT(*)
			FROM Resto.order_menus) + 1 AS NVARCHAR(4)), 4));

		-- Insert new order_menu record
		INSERT INTO Resto.order_menus
			(orme_order_number, orme_order_date, orme_pay_type, orme_cardnumber,orme_is_paid, orme_user_id, orme_status, orme_invoice)
		VALUES
			(@orme_order_number, GETDATE(), @orme_pay_type, @orme_cardnumber, @orme_is_paid, @orme_user_id, @orme_status,
				CASE WHEN @orme_status = 'ordered' THEN CONCAT('INV-', @orme_order_number, '-001') ELSE NULL END);

		-- Get orme_id for reference in omde_orme_id
		SELECT @orme_id = SCOPE_IDENTITY();

		-- Insert new detail record
		INSERT INTO Resto.order_menu_detail
			(orme_price, orme_qty, orme_discount, omde_orme_id, omde_reme_id)
		VALUES
			(@orme_price, @orme_qty, @orme_discount, @orme_id, @omde_reme_id);
	END


    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END
GO

-- =============================================
-- Author:		Hendri Praminiarto
-- Create date: 11 March 2023
-- Description:	Store Procedure Resto Menus
-- =============================================

CREATE PROCEDURE [resto].[GetOrderMenusWithDetailsById]
	@orme_id INT
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT Resto.order_menus.orme_id, Resto.order_menus.orme_order_number,
		Resto.order_menus.orme_total_amount, Resto.order_menus.orme_total_discount,
		Resto.order_menu_detail.omde_id, Resto.order_menu_detail.orme_price,
		Resto.order_menu_detail.orme_qty, Resto.order_menu_detail.orme_subtotal,
		Resto.order_menu_detail.orme_discount, Resto.order_menu_detail.omde_orme_id,
		Resto.order_menu_detail.omde_reme_id, Resto.resto_menus.reme_name
	FROM Resto.order_menus
		JOIN Resto.order_menu_detail ON Resto.order_menus.orme_id = Resto.order_menu_detail.omde_orme_id
		JOIN Resto.resto_menus ON Resto.order_menu_detail.omde_reme_id = Resto.resto_menus.reme_id
	WHERE Resto.order_menus.orme_id = @orme_id OR @orme_id IS NULL;
END
GO


-- =============================================
-- Author:		Hendri Praminiarto
-- Create date: 11 March 2023
-- Description:	Store Procedure Resto Menus
-- =============================================

CREATE PROCEDURE [Resto].[SpUpdateRestoMenus]
	@reme_id int,
	@reme_name varchar(50),
	@reme_desc varchar(100),
	@reme_price decimal(10,2),
	@reme_status bit,
	@reme_mod datetime
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRANSACTION;
	-- memulai transaction

	BEGIN TRY
        UPDATE Resto.resto_menus
        SET reme_name = @reme_name,
            reme_description = @reme_desc,
            reme_price = @reme_price,
            reme_status = @reme_status,
            reme_modified_date = @reme_mod
        WHERE reme_id = @reme_id;

        COMMIT TRANSACTION; -- commit transaction jika tidak ada error
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION; -- rollback transaction jika terjadi error
        THROW;
    END CATCH
END
GO

-- =============================================
-- Author:		Gabriel
-- Create date: 14 March 2023
-- Description:	Procedure for insert booking_orders
-- =============================================

CREATE OR ALTER procedure booking.sp_insert_booking_orders
	@boor_hotel_id as int,
	@boor_user_id as int,
	@boor_pay_type as nchar(2),
	@boor_is_paid as nchar(2),
	@boor_down_payment as money =0
AS
BEGIN
	-- declare abort on action
	SET XACT_ABORT ON;

	-- declare and retriving latest id,order_date and generate order_number
	DECLARE @boor_order_id INT = IDENT_CURRENT('Booking.booking_orders');
	DECLARE @boor_order_date DATE = GETDATE();
	DECLARE @boor_order_number VARCHAR(50);
	-- generate order number
	SET @boor_order_number =
		CONCAT
		(
			'BO#',
			CONVERT(VARCHAR(10), @boor_order_date, 112),
			'-',
			RIGHT('0000' + CAST(@boor_order_id+1 AS VARCHAR(4)), 4)
		);

	--retrive member type from users
	declare @member_type nvarchar(15) = COALESCE((select usme_memb_name from Users.user_members where usme_user_id=@boor_user_id),'');
	--retrive
	declare @boor_type nvarchar(15) = COALESCE((select user_type from Users.users where user_id=@boor_user_id),'I');

	INSERT INTO
		Booking.booking_orders
		(
			boor_hotel_id,
			boor_user_id,
			boor_order_number,
			boor_order_date,
			boor_pay_type,
			boor_is_paid,
			boor_type,
			boor_member_type
		)
		VALUES
		(
			@boor_hotel_id,
			@boor_user_id,
			@boor_order_number,
			@boor_order_date,
			@boor_pay_type,
			@boor_is_paid,
			@boor_type,
			@member_type
		);
	--insert to booking_orders
	select SCOPE_IDENTITY();

END
GO

-- =====================================================
-- Author:		Gabriel
-- Create date: 14 March 2023
-- Description:	Procedure for insert booking_order_detail
-- ======================================================

CREATE OR ALTER procedure booking.sp_insert_booking_order_detail
	@borde_boor_id int,
	@borde_faci_id int,
	@borde_checkin datetime,
	@borde_checkout datetime,
	@borde_discount smallmoney=NULL
AS
BEGIN
	SET XACT_ABORT ON
	DECLARE @faci_price money = (select faci_low_price from Hotel.facilities where faci_id=@borde_faci_id)
	DECLARE @faci_tax smallmoney = (select faci_tax_rate from Hotel.facilities where faci_id=@borde_faci_id)

	-- insert borde
	INSERT INTO Booking.booking_order_detail
	(
		borde_boor_id,
		borde_faci_id,
		borde_checkin,
		borde_checkout,
		borde_price,
		borde_adults,
		borde_kids,
		borde_extra,
		borde_discount,
		borde_tax
	)
    VALUES
	(
		@borde_boor_id,
		@borde_faci_id,
		@borde_checkin,
		@borde_checkout,
		@faci_price,
		0,--bordeAdults
		0,--bordeKids
		0,--bordeExtra
		0,--bordeDiscount,
		@faci_tax
	);
	-- get borde_id for insertion into booking_order_detail_extra
    select SCOPE_IDENTITY();
END
GO

CREATE OR ALTER procedure booking.sp_insert_booking_order_detail
	@borde_boor_id int,
	@borde_faci_id int,
	@borde_checkin datetime,
	@borde_checkout datetime,
	@borde_discount smallmoney=NULL
AS
BEGIN
	SET XACT_ABORT ON
	DECLARE @faci_price money = (select faci_rate_price from Hotel.facilities where faci_id=@borde_faci_id)
	DECLARE @faci_tax smallmoney = (select faci_tax_rate/faci_rate_price from Hotel.facilities where faci_id=@borde_faci_id)

	-- Insert borde
	INSERT INTO Booking.booking_order_detail
	(
		borde_boor_id,
		borde_faci_id,
		borde_checkin,
		borde_checkout,
		borde_price,
		borde_adults,
		borde_kids,
		borde_extra,
		borde_discount,
		borde_tax
	)
    VALUES
	(
		@borde_boor_id,
		@borde_faci_id,
		@borde_checkin,
		@borde_checkout,
		@faci_price,
		0,--bordeAdults
		0,--bordeKids
		0,--bordeExtra
		0,--bordeDiscount,
		@faci_tax
	);
	-- get borde_id for insertion into booking_order_detail_extra
    select SCOPE_IDENTITY();
END
GO

-- ============================================================
-- Author:		Gabriel
-- Create date: 14 March 2023
-- Description:	Procedure for insert booking_order_detail_extra
-- =============================================================

CREATE OR ALTER PROCEDURE Booking.sp_insert_booking_extra
	@boex_borde_id int,
	@boex_prit_id int,
	@boex_qty smallint,
	@boex_measure_unit nvarchar(50)
AS
BEGIN
	SET XACT_ABORT ON
	DECLARE @prit_price smallmoney=(select prit_price from Master.price_items where prit_id=@boex_prit_id);
	INSERT INTO Booking.booking_order_detail_extra
	(
		boex_borde_id,
		boex_prit_id,
		boex_price,
		boex_qty,
		boex_measure_unit
	)
	VALUES
	(
		@boex_borde_id,
		@boex_prit_id,
		@prit_price,
		@boex_qty,
		@boex_measure_unit
	)
    select SCOPE_IDENTITY();
END
GO

-- =============================================
-- Author:		Hafiz
-- Create date: 14 March 2023
-- Description:	Creata Store Procedure Find Vendor by Id
-- =============================================
Create Procedure [Purchasing].[spFindById]
	@id int
	AS
	BEGIN
	SET NOCOUNT ON;

	BEGIN TRANSACTION;
	-- memulai transaction
	BEGIN TRY
		SELECT
			vendor_entity_id AS VendorEntityId,
			vendor_name AS VendorName,
			vendor_active AS VendorActive,
			vendor_priority AS VendorPriority,
			vendor_register_date AS VendorRegisterDate,
			vendor_weburl AS VendorWeburl,
			vendor_modified_date AS VendorModifiedDate
		From [Purchasing].[vendor]
		WHERE vendor_entity_id = @id;
    COMMIT TRANSACTION; -- commit transaction jika tidak ada error
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; -- rollback transaction jika terjadi error
        THROW;
    END CATCH
END
GO

-- =============================================
-- Author:		Hafiz
-- Create date: 14 March 2023
-- Description:	Creata Store Procedure Delete Vendor by Id
-- =============================================
Create Procedure [Purchasing].[spDeleteVendor]
	@id int
	AS
	BEGIN
	SET NOCOUNT ON;

	BEGIN TRANSACTION;
		BEGIN TRY
			Delete From [Purchasing].[vendor]
			WHERE vendor_entity_id = @id;
		COMMIT TRANSACTION; -- commit transaction jika tidak ada error
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION; -- rollback transaction jika terjadi error
        THROW;
    END CATCH

END
GO