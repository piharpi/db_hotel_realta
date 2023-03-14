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
    INSTEAD OF INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

    DECLARE @tar_account As NVARCHAR(50)
    DECLARE @src_account As NVARCHAR(50)
    DECLARE @transaction_type As NVARCHAR(10)
    DECLARE @total_amount AS MONEY
    DECLARE @src_user_id AS INT
    DECLARE @tar_user_id AS INT
    DECLARE @transaction_note AS NVARCHAR(MAX)
	DECLARE @order_number AS VARCHAR(55)
	DECLARE @trx_number_ref AS VARCHAR(55)

	SET @order_number = null;
	SET @trx_number_ref = null;

    -- filling variable
    SELECT @src_account = patr_source_id,
           @tar_account = patr_target_id,
           @src_user_id = patr_user_id,
           @order_number = patr_order_number,
           @trx_number_ref = patr_trx_number_ref,
           @transaction_type = TRIM(patr_type),
           @transaction_note = patr_note
      FROM inserted;

    SELECT @total_amount = boor_total_ammount
    FROM Booking.booking_orders
    WHERE boor_order_number = @order_number

	IF (@transaction_type = 'RF' OR @transaction_type = 'RPY')
    BEGIN
        SELECT @src_account = patr_target_id,
               @tar_account = patr_source_id,
               @total_amount = Payment.fnRefundAmount((patr_credit + patr_debet), default)
        FROM Payment.payment_transaction
        WHERE patr_trx_number = @trx_number_ref
    END

      INSERT INTO [Payment].[payment_transaction](
                    patr_trx_number, patr_debet, patr_credit, patr_type, patr_note,
                    patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
            VALUES (Payment.fnFormatedTransactionId(IDENT_CURRENT('Payment.[payment_transaction]'), @transaction_type), 0,
                    @total_amount, @transaction_type,@transaction_note, @order_number, @src_account, @tar_account, @trx_number_ref, @src_user_id);
-- 	TOP UP
    IF @transaction_type = 'TP'
    BEGIN
        EXECUTE [Payment].[spTopUpTransaction]
             @src_account
            ,@total_amount
    END

    -- TRANSFER BOOKING
    IF @transaction_type = 'TRB'
    BEGIN
        EXECUTE [Payment].[spCalculationTranferBooking]
             @order_number,
             @tar_account
    END

    -- ORDER MENU
--     IF @transaction_type = 'ORM'
--     BEGIN
--         EXECUTE [Payment].[spTransferBookingTransaction]
--              @src_account
--             ,@tar_account
--             ,@total_amount
--     END

    -- REFUND
    IF @transaction_type = 'RF'
    BEGIN
        EXECUTE [Payment].[spRefundTransaction]
            @trx_number_ref,
            default
    END

    SELECT @tar_user_id = usac_user_id
      FROM Payment.user_accounts
     WHERE usac_account_number = @tar_account;

    INSERT INTO [Payment].[payment_transaction](
                patr_trx_number, patr_debet, patr_credit, patr_type, patr_note,
                patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
        VALUES (Payment.fnFormatedTransactionId(IDENT_CURRENT('Payment.[payment_transaction]'), @transaction_type),
                @total_amount, 0, @transaction_type, @transaction_note, @order_number, @src_account, @tar_account, @trx_number_ref, @tar_user_id);


		-- REPAYMENT
-- 		IF @transaction_type = 'RPY'
-- 		BEGIN
-- 			EXECUTE [Payment].[spTopUpTransaction]
-- 				 @source_account = @src_account
-- 				,@target_account = @tar_account
-- 				,@expense = @total_amount
-- 		END

-- 		SELECT patr_id FROM inserted;
END
GO

-- =============================================
-- Author:		Hafiz 
-- Create date: 11 January 2023
-- Description:	Trigger to insert identity into payment.Entity table
			--	and also insert into purchasing.Vendor table
-- =============================================
CREATE TRIGGER Purchasing.InsertVendorEntityId
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

-- =============================================
-- Author:		Hendri Praminiarto
-- Create date: 11 March 2023
-- Description:	TRIGGER Resto Menus
-- -- =============================================

CREATE TRIGGER [Resto].[trg_update_order_menus_total_item]
ON [Resto].[order_menu_detail]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @orme_id int;
	SET @orme_id = (SELECT DISTINCT TOP 1 omde_orme_id
	FROM inserted);
	IF @orme_id IS NOT NULL
    BEGIN
		UPDATE Resto.order_menus
        SET orme_total_item = (SELECT SUM(orme_qty)
		FROM Resto.order_menu_detail
		WHERE omde_orme_id = @orme_id),
            orme_total_discount = (SELECT SUM(orme_discount)
		FROM Resto.order_menu_detail
		WHERE omde_orme_id = @orme_id),
            orme_total_amount = (SELECT SUM(orme_subtotal) - SUM(orme_discount)
		FROM Resto.order_menu_detail
		WHERE omde_orme_id = @orme_id),
            orme_modified_date = GETDATE()
        WHERE orme_id = @orme_id;
	END
END
GO

-- =============================================
-- Author:		Hendri Praminiarto
-- Create date: 11 March 2023
-- Description:	TRIGGER Resto Menus
-- =============================================


CREATE TRIGGER [Resto].[tr_set_remp_primary] ON [Resto].[resto_menu_photos]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	SET NOCOUNT ON;

	-- jika terjadi update atau delete pada table Resto.resto_menu_photos
	IF EXISTS(SELECT *
	FROM deleted)
  BEGIN
		-- update remp_primary = 1 pada record dengan remp_id tertinggi yang memiliki remp_reme_id sama
		UPDATE Resto.resto_menu_photos
    SET remp_primary = 1
    FROM Resto.resto_menu_photos p1
			INNER JOIN (
      SELECT remp_reme_id, MAX(remp_id) AS max_remp_id
			FROM deleted
			GROUP BY remp_reme_id
    ) p2 ON p1.remp_reme_id = p2.remp_reme_id AND p1.remp_id = p2.max_remp_id;

		-- update remp_primary = 0 pada record yang tidak dipilih sebagai record utama
		UPDATE Resto.resto_menu_photos
    SET remp_primary = 0
    WHERE remp_reme_id IN (SELECT remp_reme_id
			FROM deleted)
			AND remp_id NOT IN (SELECT max_remp_id
			FROM (
        SELECT remp_reme_id, MAX(remp_id) AS max_remp_id
				FROM deleted
				GROUP BY remp_reme_id
      ) t)
	END
  ELSE -- jika terjadi insert pada table Resto.resto_menu_photos
  BEGIN
		-- update remp_primary = 1 pada record yang baru di-insert
		UPDATE Resto.resto_menu_photos
    SET remp_primary = 1
    WHERE remp_id IN (SELECT remp_id
		FROM inserted);

		-- update remp_primary = 0 pada record yang lain
		UPDATE Resto.resto_menu_photos
    SET remp_primary = 0
    WHERE remp_reme_id IN (SELECT remp_reme_id
			FROM inserted)
			AND remp_id NOT IN (SELECT remp_id
			FROM inserted);
	END
END;
GO


-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 9 Mei 2023
-- Description:	Trigger to update modified_date into Hotel.Hotels
--				without using field Hotel_rating_star
-- =============================================

CREATE OR ALTER TRIGGER Hotel.Hotel_Modified_Date_Automation
ON Hotel.Hotels
AFTER UPDATE
AS
BEGIN
  IF UPDATE(hotel_name)
	OR UPDATE(hotel_description)
	OR UPDATE(hotel_status)
	OR UPDATE(hotel_reason_status)
	OR UPDATE(hotel_phonenumber)
	OR UPDATE(hotel_addr_id)
	OR UPDATE(hotel_addr_description)
	OR
		NOT EXISTS (
			SELECT * FROM inserted JOIN deleted
			ON inserted.hotel_id = deleted.hotel_id
			WHERE inserted.hotel_rating_star <> deleted.hotel_rating_star)
  BEGIN
    UPDATE Hotel.Hotels
    SET hotel_modified_date = GETDATE()
    WHERE hotel_id IN (SELECT hotel_id FROM inserted)
  END
END;

-- =============================================
-- Author:		Gabi 
-- Create date: GetDate()
-- Description:	Trigger to update totalRoom,totalAmount in Booking_orders
-- =============================================

CREATE OR ALTER TRIGGER Booking.TrToRoomAndTotalAmountUpdate
ON booking.booking_order_detail
AFTER INSERT, DELETE, UPDATE 
AS
BEGIN
	SET XACT_ABORT ON;
  	UPDATE Booking.booking_orders
  	SET 
	-- Update the boor_total_room column for each affected boorId
		boor_total_room = 
		(
			SELECT COUNT(d.borde_id)
			FROM Booking.booking_order_detail d
			WHERE borde_boor_id = boor_id
  		),
	-- Update the boor_total_amount column for each affected boorId
		boor_total_ammount=
		(
			SELECT SUM(d.borde_subtotal)
			FROM Booking.booking_order_detail d
			WHERE borde_boor_id=boor_id
		)
  WHERE boor_id IN (
    SELECT borde_boor_id
    FROM inserted
    UNION
    SELECT borde_boor_id
    FROM deleted
  )
END;