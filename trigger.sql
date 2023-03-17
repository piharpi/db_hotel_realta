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
            ,@src_account As NVARCHAR(50)
            ,@transaction_type As NVARCHAR(10)
            ,@total_amount AS MONEY
            ,@src_user_id AS INT
            ,@tar_user_id AS INT
            ,@transaction_note AS NVARCHAR(MAX)
	        ,@order_number AS VARCHAR(55)
	        ,@trx_number AS VARCHAR(55)
	        ,@pay_method AS NCHAR(5) = null

	SET @order_number = null;
	SET @trx_number = null;

    -- filling variable
    SELECT @src_account = patr_source_id,
           @tar_account = patr_target_id,
           @total_amount = patr_credit,
           @src_user_id = patr_user_id,
           @order_number = patr_order_number,
           @transaction_type = TRIM(patr_type),
           @transaction_note = patr_note
      FROM inserted;

    IF (@transaction_type = 'TRB')
    BEGIN
        SELECT @total_amount = boor_total_ammount,
               @pay_method = boor_pay_type
        FROM Booking.booking_orders
        WHERE boor_order_number = @order_number
    END

    IF (@transaction_type = 'ORM')
    BEGIN
        SELECT @total_amount = orme_total_amount,
               @pay_method = orme_pay_type
        FROM Resto.order_menus
        WHERE orme_order_number = @order_number
    END

    -- check if the payment method is 'cash' just ignore it
    -- CR = credit_card
    -- D = debet
    -- PG = payment / payment_gateway
    IF (@pay_method IN ('D', 'CR', 'PG')
            OR @transaction_type = 'RF'
            OR @transaction_type = 'RPY'
            OR @transaction_type = 'TP')
    BEGIN

        IF (@transaction_type = 'RF')
        BEGIN
            SELECT TOP 1 @src_account = patr_target_id,
                       @tar_account = patr_source_id,
                       @trx_number = patr_trx_number
              FROM Payment.payment_transaction
             WHERE patr_order_number = @order_number AND patr_user_id = @src_user_id;

               SET @order_number = null;
        END

        IF (@transaction_type = 'RPY')
        BEGIN
            SELECT TOP 1 @trx_number = patr_trx_number
              FROM Payment.payment_transaction
             WHERE patr_order_number = @order_number AND patr_user_id = @src_user_id;
        END

        -- 	TOP UP
        IF @transaction_type = 'TP'
        BEGIN
            EXECUTE [Payment].[spTopUpTransaction]
                 @src_account
                ,@tar_account
                ,@total_amount
        END

        -- TRANSFER BOOKING
        IF @transaction_type = 'TRB'
        BEGIN
            EXEC [Payment].[spCalculationTranferBooking]
                @src_account,
                @tar_account,
                @order_number,
                @total_amount OUTPUT
        END

        -- ORDER MENU
        IF @transaction_type = 'ORM'
        BEGIN
            EXECUTE [Payment].[spCalculationTranferOrderMenu]
                @src_account,
                @tar_account,
                @order_number,
                @total_amount OUTPUT
        END

        -- REFUND
        IF @transaction_type = 'RF'
        BEGIN
            EXECUTE [Payment].[spRefundTransaction]
                @trx_number,
                default,
                @total_amount OUTPUT
        END

        -- REPAYMENT
        IF @transaction_type = 'RPY'
        BEGIN
            EXECUTE [Payment].[spRepaymentTransaction]
                @src_account,
                @tar_account,
                @order_number,
                @total_amount OUTPUT
        END

        SELECT @src_user_id = usac_user_id
          FROM Payment.user_accounts
         WHERE usac_account_number = @src_account

        -- insert credit transaction
        INSERT INTO [Payment].[payment_transaction](
                    patr_trx_number, patr_debet, patr_credit, patr_type, patr_note,
                    patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
             VALUES (Payment.fnFormatedTransactionId(IDENT_CURRENT('Payment.[payment_transaction]'), @transaction_type), 0,
                    @total_amount, @transaction_type,@transaction_note, @order_number, @src_account, @tar_account, @trx_number, @src_user_id);

        SELECT @tar_user_id = usac_user_id
          FROM Payment.user_accounts
         WHERE usac_account_number = @tar_account;

        -- insert debet transaction
        INSERT INTO [Payment].[payment_transaction](
                    patr_trx_number, patr_debet, patr_credit, patr_type, patr_note,
                    patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
            VALUES (Payment.fnFormatedTransactionId(IDENT_CURRENT('Payment.[payment_transaction]'), @transaction_type),
                    @total_amount, 0, @transaction_type, @transaction_note, @order_number, @src_account, @tar_account, @trx_number, @tar_user_id);

    -- 		SELECT patr_id FROM inserted;
    END
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

CREATE OR ALTER TRIGGER Hotel.tr_Hotels_ModifiedDate
ON Hotel.Hotels
AFTER INSERT, UPDATE 
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT UPDATE(hotel_rating_star)
    BEGIN
        UPDATE Hotel.Hotels 
        SET hotel_modified_date = GETDATE()
        FROM inserted
        WHERE Hotels.hotel_id = inserted.hotel_id
    END
END;
GO


-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger for update hotel_rating_star into Hotel.Hotels
--				from insert, update, delete from Hotel.Hotel_Reviews
-- =============================================

CREATE OR ALTER TRIGGER Hotel.tr_Hotel_Reviews_Rating_Star
ON Hotel.Hotel_Reviews
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @hotel_id INT

    IF EXISTS(SELECT 1 FROM inserted)
        SET @hotel_id = (SELECT TOP 1 hore_hotel_id FROM inserted)
    ELSE IF EXISTS(SELECT 1 FROM deleted)
        SET @hotel_id = (SELECT TOP 1 hore_hotel_id FROM deleted)
    ELSE
        RETURN;

    UPDATE Hotel.Hotels
    SET hotel_rating_star = (
        SELECT CAST(FORMAT(AVG(cast(hore_rating AS numeric(2,1))), 'N1') AS numeric (2,1))
        FROM Hotel.Hotel_Reviews
        WHERE hore_hotel_id = @hotel_id )
    WHERE hotel_id = @hotel_id;
END;
GO


-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger for validate input only type 'user' or 'guest'
--				in table Hotel.Hotel_Reviews
-- =============================================

-- DROP TRIGGER Hotel.Hotel_Reviews_insert_validation
CREATE OR ALTER TRIGGER Hotel.Hotel_Reviews_insert_validation
ON Hotel.Hotel_Reviews
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @hore_user_id INT

    SELECT @hore_user_id = hore_user_id
    FROM inserted

    IF NOT EXISTS (SELECT 1 FROM Users.user_roles WHERE usro_user_id = @hore_user_id AND usro_role_id IN (1, 5))
    BEGIN
        PRINT('User does not exist or you do not have permission');
        RETURN;
    END

    INSERT INTO Hotel.Hotel_Reviews (hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id)
    SELECT hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id
    FROM inserted;
END;
GO


-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger to validate input only 'admin' or 'manager'
--				handle faci_rate_price and checker for input price
--				also insert for table Hotel.Facilities
-- =============================================

CREATE OR ALTER TRIGGER Hotel.Facilities_insert_validation
ON Hotel.Facilities
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @faci_user_id INT
    DECLARE @faci_hotel_id INT
    DECLARE @faci_rate_price MONEY
    DECLARE @faci_low_price MONEY
    DECLARE @faci_high_price MONEY

    SELECT 
        @faci_user_id = faci_user_id,
        @faci_hotel_id = faci_hotel_id,
        @faci_low_price = faci_low_price,
        @faci_high_price = faci_high_price,
        @faci_rate_price = 
        (
		CASE
			WHEN faci_discount IS NULL AND faci_tax_rate IS NULL THEN (faci_high_price + faci_low_price) / 2
			WHEN faci_discount IS NULL THEN (((faci_high_price + faci_low_price) / 2) + (((faci_high_price + faci_low_price) / 2) * (faci_tax_rate/100)))
			WHEN faci_tax_rate IS NULL THEN (((faci_high_price + faci_low_price) / 2) - (((faci_high_price + faci_low_price) / 2) * (faci_discount/100)))
			ELSE (((faci_high_price + faci_low_price) / 2) - (((faci_high_price + faci_low_price) / 2) * faci_discount/100)) + (((faci_high_price + faci_low_price) / 2) - (((faci_high_price + faci_low_price) / 2) * faci_discount/100)) * (faci_tax_rate/100)
		END
	)
    FROM inserted   

    IF NOT EXISTS (SELECT 1 FROM Hotel.Hotels WHERE hotel_id = @faci_hotel_id)
    BEGIN
        RAISERROR ('Hotel does not exist or you do not have permission', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
    
    IF NOT EXISTS (SELECT 1 FROM Users.user_roles WHERE usro_user_id = @faci_user_id AND usro_role_id IN (2, 4))
    BEGIN
        RAISERROR ('User does not exist or you do not have permission', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
    
    IF EXISTS (SELECT faci_low_price, faci_high_price 
               FROM inserted 
               WHERE faci_high_price < faci_low_price) 
    BEGIN 
        RAISERROR ('High price cannot be lower than low price', 16, 1) 
        ROLLBACK TRANSACTION
        RETURN;
    END 

    IF (@faci_rate_price > @faci_high_price OR @faci_rate_price < @faci_low_price) 
    BEGIN 
        RAISERROR ('Rate price cannot be lower than low price OR cannot be higher than high price', 16, 1) 
        ROLLBACK TRANSACTION
        RETURN;
    END 


    BEGIN TRY
        INSERT INTO Hotel.Facilities (faci_name, faci_description, faci_max_number, faci_measure_unit,										faci_room_number, faci_startdate, faci_enddate, faci_low_price,											faci_high_price, faci_rate_price, faci_discount, faci_tax_rate,
									  faci_modified_date, faci_cagro_id, faci_hotel_id, faci_user_id,
									  faci_expose_price) 
        SELECT 
            i.faci_name, 
            i.faci_description, 
            i.faci_max_number,
            i.faci_measure_unit,
            i.faci_room_number,
            i.faci_startdate,
            i.faci_enddate,
            i.faci_low_price, 
            i.faci_high_price, 
            @faci_rate_price,
            i.faci_discount,
            i.faci_tax_rate,
            GETDATE(),
            i.faci_cagro_id,
            i.faci_hotel_id,
            i.faci_user_id,
            i.faci_expose_price
        FROM inserted i
    END TRY
    
BEGIN CATCH
        ROLLBACK TRANSACTION
    -- Handle the exception here, for example by logging the error
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;
		
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
END;
GO


-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger to validate update into Hotel.Facilities
--				with auto insert into Hotel.Facility_Price_History
-- =============================================

CREATE OR ALTER TRIGGER Hotel.Facilities_update_validation
ON Hotel.Facilities
AFTER UPDATE 
AS
BEGIN
    DECLARE @faci_id INT;
    DECLARE @faci_user_id INT;
    DECLARE @faci_hotel_id INT;
	DECLARE @faci_startdate DATETIME;
	DECLARE @faci_enddate DATETIME;
	DECLARE @faci_discount SMALLMONEY;
	DECLARE @faci_tax_rate SMALLMONEY;
    DECLARE @faci_low_price MONEY;
    DECLARE @faci_high_price MONEY;
    DECLARE @faci_rate_price MONEY;

    SELECT 
        @faci_id = faci_id,
        @faci_user_id = faci_user_id,
        @faci_hotel_id = faci_hotel_id,
        @faci_startdate = faci_startdate,
        @faci_enddate = faci_enddate,
        @faci_discount = faci_discount,
        @faci_tax_rate = faci_tax_rate,
        @faci_low_price = faci_low_price,
        @faci_high_price = faci_high_price,
        @faci_rate_price = 
        (
		CASE
			WHEN faci_discount IS NULL AND faci_tax_rate IS NULL THEN (faci_high_price + faci_low_price) / 2
			WHEN faci_discount IS NULL THEN (((faci_high_price + faci_low_price) / 2) + (((faci_high_price + faci_low_price) / 2) * (faci_tax_rate/100)))
			WHEN faci_tax_rate IS NULL THEN (((faci_high_price + faci_low_price) / 2) - (((faci_high_price + faci_low_price) / 2) * (faci_discount/100)))
			ELSE (((faci_high_price + faci_low_price) / 2) - (((faci_high_price + faci_low_price) / 2) * faci_discount/100)) + (((faci_high_price + faci_low_price) / 2) - (((faci_high_price + faci_low_price) / 2) * faci_discount/100)) * (faci_tax_rate/100)
		END
	)
    FROM inserted   

    IF NOT EXISTS (SELECT 1 FROM Hotel.Hotels WHERE hotel_id = @faci_hotel_id)
    BEGIN
        RAISERROR ('Hotel does not exist or you do not have permission', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
    
    IF NOT EXISTS (SELECT 1 FROM Users.user_roles WHERE usro_user_id = @faci_user_id AND usro_role_id IN (2, 4))
    BEGIN
        RAISERROR ('User does not exist or you do not have permission', 16, 1)
        ROLLBACK TRANSACTION
        RETURN;
    END
    
    IF EXISTS (SELECT faci_low_price, faci_high_price 
               FROM inserted 
               WHERE faci_high_price < faci_low_price) 
    BEGIN 
        RAISERROR ('High price cannot be lower than low price', 16, 1) 
        ROLLBACK TRANSACTION
        RETURN;
    END 

    IF (@faci_rate_price > @faci_high_price OR @faci_rate_price < @faci_low_price) 
    BEGIN 
        RAISERROR ('Rate price cannot be lower than low price OR cannot be higher than high price', 16, 1) 
        ROLLBACK TRANSACTION
        RETURN;
    END 
    

    IF UPDATE(faci_startdate)
		OR UPDATE(faci_enddate)
		OR UPDATE(faci_low_price)
		OR UPDATE(faci_high_price) 
		OR UPDATE(faci_rate_price) 
		OR UPDATE(faci_discount) 
		OR UPDATE(faci_tax_rate)
    BEGIN
        BEGIN TRANSACTION
			UPDATE Hotel.Facilities 
			SET 
				faci_rate_price = @faci_rate_price
			WHERE 
				faci_id = @faci_id

			INSERT INTO Hotel.Facility_Price_History (faph_startdate, faph_enddate, faph_low_price, faph_high_price, faph_rate_price, faph_discount, faph_tax_rate, faph_modified_date, faph_faci_id, faph_user_id)
			VALUES (@faci_startdate, @faci_enddate, @faci_low_price, @faci_high_price, @faci_rate_price, @faci_discount, @faci_tax_rate, GETDATE(), @faci_id, @faci_user_id);
        COMMIT TRANSACTION
    END
END;
GO

-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger for auto insert 
--				into table Hotel.Facility_Price_History 
-- =============================================

CREATE OR ALTER TRIGGER Hotel.tr_hotel_facilities_price_history
ON Hotel.Facilities
AFTER INSERT 
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @faph_startdate DATETIME
  DECLARE @faph_enddate DATETIME  
  DECLARE @faph_modified_date DATETIME
  DECLARE @faph_low_price MONEY;
  DECLARE @faph_high_price MONEY;
  DECLARE @faph_rate_price MONEY;
  DECLARE @faph_discount SMALLMONEY;
  DECLARE @faph_tax_rate SMALLMONEY;
  DECLARE @faph_faci_id INT;
  DECLARE @faph_user_id INT;

  SELECT @faph_startdate = faci_startdate, @faph_enddate = faci_enddate, @faph_low_price = faci_low_price, 
  @faph_high_price = faci_high_price, @faph_rate_price = faci_rate_price, @faph_discount = faci_discount, 
  @faph_modified_date = faci_modified_date, @faph_tax_rate = faci_tax_rate, @faph_faci_id = faci_id, @faph_user_id = faci_user_id 
  FROM inserted;

  INSERT INTO Hotel.Facility_Price_History (faph_startdate, faph_enddate, faph_low_price, faph_high_price, faph_rate_price, faph_discount, faph_tax_rate, faph_modified_date, faph_faci_id, faph_user_id)
  VALUES (@faph_startdate, @faph_enddate, @faph_low_price, @faph_high_price, @faph_rate_price, @faph_discount, @faph_tax_rate, @faph_modified_date, @faph_faci_id, @faph_user_id);
END;
GO

-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger to validate facility must have inserted
--				and validate insert for Hotel.Facility Photos
-- =============================================

CREATE OR ALTER TRIGGER Hotel.Hotel_Facility_Photos_insert_validation
ON Hotel.Facility_Photos
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @fapho_faci_id INT

    SELECT 
        @fapho_faci_id = fapho_faci_id
    FROM inserted

    IF NOT EXISTS (SELECT 1 FROM Hotel.Facilities WHERE faci_id = @fapho_faci_id)
    BEGIN
        RAISERROR ('Facility does not exist!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Hotel.Facility_Photos (fapho_photo_filename, fapho_thumbnail_filename, fapho_original_filename, fapho_file_size, fapho_file_type, fapho_primary, fapho_url, fapho_modified_date, fapho_faci_id)
		SELECT fapho_photo_filename, fapho_thumbnail_filename, fapho_original_filename, fapho_file_size, fapho_file_type, fapho_primary, fapho_url, fapho_modified_date, fapho_faci_id
	    FROM inserted;
    END
END;
GO


-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 14 Mei 2023
-- Description:	Trigger for checker while update and delete
--				primary must to have 1 record for value fapho_primary = 1
-- =============================================

CREATE OR ALTER TRIGGER Hotel.Hotel_Facility_Photos_update_primary_validation
ON Hotel.Facility_Photos
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fapho_faci_id INT
    DECLARE @fapho_primary INT

    SELECT 
        @fapho_faci_id = fapho_faci_id,
        @fapho_primary =  fapho_primary
    FROM inserted

    IF (@fapho_primary = 1)
        BEGIN
			-- update other records with the same fapho_faci_id to have fapho_primary = 0
			UPDATE p
			SET fapho_primary = 0
			FROM Hotel.Facility_Photos p
			JOIN inserted i ON p.fapho_faci_id = i.fapho_faci_id
			WHERE p.fapho_id <> i.fapho_id
			AND (i.fapho_primary = 1 OR (i.fapho_primary IS NULL AND p.fapho_primary = 1));

			-- set inserted records with fapho_primary = 1
			UPDATE p
			SET fapho_primary = 1
			FROM Hotel.Facility_Photos p
			JOIN inserted i ON p.fapho_id = i.fapho_id
			WHERE i.fapho_primary = 1
			AND (p.fapho_primary IS NULL OR p.fapho_primary = 0);
        END

    IF NOT EXISTS (SELECT * FROM inserted WHERE fapho_primary = 1 AND fapho_faci_id = @fapho_faci_id) 
        BEGIN
            UPDATE Hotel.Facility_Photos
            SET fapho_primary = 1
            WHERE fapho_id = (
            SELECT MIN(fapho_id) FROM hotel.Facility_Photos
            WHERE fapho_faci_id = @fapho_faci_id )
        END
END;
GO

-- =============================================
-- Author	  :	Alvan Ganteng
-- Create date: 9 Mei 2023
-- Description:	Trigger for checker insert for fapho_primary
--				the value will be '1' if it first record 
-- =============================================

CREATE OR ALTER TRIGGER Hotel.tr_facility_photos_fapho_primary
ON Hotel.Facility_Photos
AFTER INSERT 
AS
BEGIN
  SET NOCOUNT ON;

  BEGIN TRY
    -- Start transaction
    BEGIN TRANSACTION
    DECLARE @fapho_faci_id INT
    DECLARE @fapho_id INT
    DECLARE @fapho_primary INT

    SELECT 
        @fapho_id = fapho_id,
        @fapho_faci_id = fapho_faci_id,
        @fapho_primary = fapho_primary
    FROM inserted

    -- If any row is updated, check if the value of fapho_primary is changed to 1
    IF NOT EXISTS (SELECT TOP 1 * 
				   FROM Hotel.Facility_Photos 
				   WHERE fapho_primary = 1 
					AND fapho_faci_id = @fapho_faci_id) 
				   AND (@fapho_primary = 0)
    BEGIN
      -- Only allow one record with fapho_primary = 1 for each faci_id
      UPDATE Hotel.Facility_Photos
      SET 
        fapho_primary = 1
      WHERE fapho_id = @fapho_id
    END

    -- Commit transaction
    COMMIT TRANSACTION

  END TRY

  BEGIN CATCH
    -- Rollback transaction in case of any errors
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;
  END CATCH;
END;
GO
GO
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
GO