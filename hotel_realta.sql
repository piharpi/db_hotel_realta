CREATE DATABASE Hotel_Realta
USE Hotel_Realta
CREATE TABLE Booking.users(
	user_id INTEGER
	CONSTRAINT pk_user_id PRIMARY KEY(user_id)
)

CREATE TABLE Booking.hotels(
	hotel_id INT IDENTITY(1,1)
	CONSTRAINT pk_hotel_id PRIMARY KEY(hotel_id)
)

CREATE TABLE Booking.facilities(
	faci_id INT IDENTITY(1,1)
	CONSTRAINT pk_faci_id PRIMARY KEY(faci_id)
)

CREATE TABLE Booking.price_items(
	prit_id INTEGER
	CONSTRAINT pk_prit_id PRIMARY KEY(prit_id)
)

CREATE TABLE Booking.special_offers
(
    spof_id int IDENTITY(1,1) NOT NULL,
    spof_name NVARCHAR(55) NOT NULL,
    spof_description NVARCHAR(255) NOT NULL,
    spof_type NCHAR(5) NOT NULL,
    spof_discount SMALLMONEY NOT NULL,
    spof_start_date DATETIME NOT NULL,
    spof_end_date DATETIME NOT NULL,
    spof_min_qty INT,
    spof_max_qty INT,
    spof_modified_date DATETIME
    constraint pk_spof_id PRIMARY KEY(spof_id)
)
create table Booking.booking_order(
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
	boor_pay_type NCHAR(2) NOT NULL,
	boor_is_paid NCHAR(2) NOT NULL,
	boor_type NVARCHAR(15) NOT NULL,
	boor_cardnumber NVARCHAR(25),
	boor_member_type NVARCHAR(15),
	boor_status NVARCHAR(15),
	boor_user_id INTEGER,
	boor_hotel_id INT
	CONSTRAINT pk_boor_id PRIMARY KEY (boor_id),
	CONSTRAINT unique_boor_order_number UNIQUE (boor_order_number),
	CONSTRAINT fk_boor_user_id FOREIGN KEY (boor_user_id) REFERENCES Booking.users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_boor_hotel_id FOREIGN KEY (boor_hotel_id) REFERENCES Booking.hotels (hotel_id) ON DELETE CASCADE ON UPDATE CASCADE
	
)

CREATE TABLE Booking.Booking_order_detail(
	borde_boor_id INTEGER,
	borde_id Int IDENTITY (1,1),
	borde_checkin DATETIME,
	borde_checkout DATETIME,
	borde_adult INTEGER,
	borde_kids INTEGER,
	borde_price MONEY,
	borde_extra MONEY,
	borde_discount SMALLMONEY,
	borde_tax SMALLMONEY,
	borde_subtotal MONEY,
	borde_faci_id INTEGER
	CONSTRAINT pk_borde_id_boor_id PRIMARY KEY (borde_id),
	CONSTRAINT fk_borde_boor_id Foreign key (borde_boor_id) references Booking.Booking_order(boor_id)  ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_borde_faci_id FOREIGN KEY (borde_faci_id) REFERENCES Booking.facilities(faci_id) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Booking.Booking_order_detail_extra(
	boex_id Int IDENTITY (1,1),
	boex_price MONEY,
	boex_qty SMALLINT,
	boex_subtotal MONEY,
	boex_measure_int NVARCHAR (50), --[people]unit[kg]
	boex_borde_id int,
	boex_prit_id int
	CONSTRAINT pk_boex_id PRIMARY KEY (boex_id),
	CONSTRAINT fk_boex_borde_id FOREIGN KEY (boex_borde_id) REFERENCES Booking.Booking_order_detail (borde_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_boex_prit_id FOREIGN KEY (boex_prit_id) REFERENCES Booking.price_items (prit_id) ON DELETE CASCADE ON UPDATE CASCADE
)


CREATE TABLE Booking.special_offer_coupons
(
    soco_id int IDENTITY(1,1),
    soco_borde_id INT,
    soco_spof_id int,
    CONSTRAINT pk_soco_id PRIMARY KEY(soco_id),
    CONSTRAINT fk_soco_borde_id FOREIGN KEY(soco_borde_id) REFERENCES Booking.booking_order_detail(borde_id) on DELETE CASCADE on UPDATE CASCADE,
    CONSTRAINT fk_soco_spof_id FOREIGN KEY(soco_spof_id) REFERENCES Booking.special_offers(spof_id) on DELETE CASCADE on UPDATE CASCADE
)
create table Booking.user_breakfast
(
    usbr_borde_id INT,
    usbr_modified_date DATETIME,
    usbr_total_vacant SMALLINT NOT NULL,
    CONSTRAINT pk_usbr_borde_id_usbr_modified_date PRIMARY KEY(usbr_borde_id,usbr_modified_date),
    CONSTRAINT fk_usbr_borde_id FOREIGN KEY(usbr_borde_id) REFERENCES Booking.booking_order_detail(borde_id) ON DELETE CASCADE ON UPDATE CASCADE
)
