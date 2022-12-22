CREATE DATABASE Hotel_Realta
USE Hotel_Realta
go
create SCHEMA booking;
go


CREATE TABLE booking.special_offers
(
    spof_id int IDENTITY(1,1) NOT NULL,
    spof_name NVARCHAR(55) NOT NULL,
    spof_description NVARCHAR(255) NOT NULL,
    spof_type NCHAR(5) NOT NULL check (spof_type in ('T','C','I')),
    spof_discount SMALLMONEY NOT NULL,
    spof_start_date DATETIME NOT NULL,
    spof_end_date DATETIME NOT NULL,
    spof_min_qty INT,
    spof_max_qty INT,
    spof_modified_date DATETIME
    constraint pk_spof_id PRIMARY KEY(spof_id)
)
create table booking.booking_order(
	boor_id int	IDENTITY (1,1),
	boor_order_number nvarchar(20) NOT NULL,
	boor_order_date DATETIME NOT NULL,
	boor_arrival_date DATETIME,
	boor_total_room SMALLINT,
	boor_total_guest SMALLINT,
	boor_discount SMALLMONEY,
	boor_total_tax SMALLMONEY,
	boor_total_ammount MONEY,
	boor_down_payment MONEY,
	boor_pay_type NCHAR(2) NOT NULL check (boor_pay_type in ('CR','C','D ','PG')),
	boor_is_paid NCHAR(2) NOT NULL check (boor_is_paid in ('DP','P','R ')),
	boor_type NVARCHAR(15) NOT NULL check (boor_type in ('T','C','I')),
	boor_cardnumber NVARCHAR(25),
	boor_member_type NVARCHAR(15),
	boor_status NVARCHAR(15) check (boor_status in ('BOOKING','CHECKIN','CHECKOUT','CLEANING','CANCELED')),
	boor_user_id INTEGER,
	boor_hotel_id INT
	CONSTRAINT pk_boor_id PRIMARY KEY (boor_id),
	CONSTRAINT unique_boor_order_number UNIQUE (boor_order_number),
	CONSTRAINT fk_boor_user_id FOREIGN KEY (boor_user_id) REFERENCES users.users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_boor_hotel_id FOREIGN KEY (boor_hotel_id) REFERENCES hotel.hotels (hotel_id) ON DELETE CASCADE ON UPDATE CASCADE
	
)

CREATE TABLE booking.booking_order_detail(
	borde_boor_id INTEGER,
	borde_id Int IDENTITY (1,1),
	borde_checkin DATETIME NOT NULL,
	borde_checkout DATETIME NOT NULL,
	borde_adults INTEGER,
	borde_kids INTEGER,
	borde_price MONEY,
	borde_extra MONEY,
	borde_discount SMALLMONEY,
	borde_tax SMALLMONEY,
	borde_subtotal MONEY,
	borde_faci_id INTEGER
	CONSTRAINT pk_borde_id_boor_id PRIMARY KEY (borde_id),
	CONSTRAINT fk_borde_boor_id Foreign key (borde_boor_id) REFERENCES booking.booking_order(boor_id)  ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_borde_faci_id FOREIGN KEY (borde_faci_id) REFERENCES hotel.facilities(faci_id) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE booking.booking_order_detail_extra(
	boex_id Int IDENTITY (1,1),
	boex_price MONEY,
	boex_qty SMALLINT,
	boex_subtotal MONEY,
	boex_measure_unit NVARCHAR (50), check(boex_measure_unit in ('people','unit','kg')),
	boex_borde_id int,
	boex_prit_id int
	CONSTRAINT pk_boex_id PRIMARY KEY (boex_id),
	CONSTRAINT fk_boex_borde_id FOREIGN KEY (boex_borde_id) REFERENCES booking.booking_order_detail (borde_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_boex_prit_id FOREIGN KEY (boex_prit_id) REFERENCES master.price_items (prit_id) ON DELETE CASCADE ON UPDATE CASCADE
)


CREATE TABLE booking.special_offer_coupons
(
    soco_id INT IDENTITY(1,1),
    soco_borde_id INT,
    soco_spof_id INT,
    CONSTRAINT pk_soco_id PRIMARY KEY(soco_id),
    CONSTRAINT fk_soco_borde_id FOREIGN KEY(soco_borde_id) REFERENCES booking.booking_order_detail(borde_id) on DELETE CASCADE on UPDATE CASCADE,
    CONSTRAINT fk_soco_spof_id FOREIGN KEY(soco_spof_id) REFERENCES booking.special_offers(spof_id) on DELETE CASCADE on UPDATE CASCADE
)
create table booking.user_breakfast
(
    usbr_borde_id INT,
    usbr_modified_date DATETIME,
    usbr_total_vacant SMALLINT NOT NULL,
    CONSTRAINT pk_usbr_borde_id_usbr_modified_date PRIMARY KEY(usbr_borde_id,usbr_modified_date),
    CONSTRAINT fk_usbr_borde_id FOREIGN KEY(usbr_borde_id) REFERENCES booking.booking_order_detail(borde_id) ON DELETE CASCADE ON UPDATE CASCADE
)
