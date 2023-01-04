CREATE SCHEMA Users;
GO

CREATE SCHEMA Master;
GO

CREATE SCHEMA Hotel;
GO 

CREATE SCHEMA HR;
GO

CREATE SCHEMA Booking;
GO

CREATE SCHEMA Resto;

GO

CREATE SCHEMA Payment;
GO

CREATE SCHEMA Purchasing;
GO

-- MODULE MASTERS --
CREATE TABLE Master.regions (
  region_code int IDENTITY(1, 1),
  region_name nvarchar(35) UNIQUE NOT NULL,
  CONSTRAINT pk_region_code PRIMARY KEY(region_code)
);

CREATE TABLE Master.country (
  country_id int IDENTITY(1, 1),
  country_name nvarchar(55) UNIQUE NOT NULL,
  country_region_id int,
  CONSTRAINT pk_country_id PRIMARY KEY (country_id),
  CONSTRAINT fk_country_region_id FOREIGN KEY(country_region_id) REFERENCES Master.regions(region_code) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.provinces (
  prov_id int IDENTITY (1, 1),
  prov_name nvarchar(85) NOT NULL,
  prov_country_id int CONSTRAINT pk_prov_id PRIMARY KEY(prov_id),
  CONSTRAINT fk_prov_country_name FOREIGN KEY(prov_country_id) REFERENCES Master.country(country_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.address (
  addr_id int IDENTITY(1, 1),
  addr_line1 nvarchar(255) NOT NULL,
  addr_line2 nvarchar(255),
  addr_postal_code nvarchar(5),
  addr_spatial_location geography,
  addr_prov_id int,
  CONSTRAINT pk_addr_id PRIMARY KEY(addr_id),
  CONSTRAINT fk_addr_prov_id FOREIGN KEY(addr_prov_id) REFERENCES Master.provinces(prov_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Master.category_group (
  cagro_id int IDENTITY(1, 1),
  cagro_name nvarchar(25) UNIQUE NOT NULL CHECK (cagro_name IN ('Room', 'Restaurant', 'Meeting Room', 'Gym', 'Aula', 'Swimming Pool','Balroom')),
  cagro_description nvarchar(255),
  cagro_type nvarchar(25) NOT NULL CHECK (cagro_type IN('category', 'service', 'facility')),
  cagro_icon nvarchar(255),
    cagro_icon_url nvarchar(255),
  CONSTRAINT pk_cagro_id PRIMARY KEY(cagro_id)
);

CREATE TABLE Master.price_item (
  prit_id int IDENTITY(1, 1),
  prit_name nvarchar(55) UNIQUE NOT NULL,
  prit_price money NOT NULL,
  prit_description nvarchar(255),
  prit_type nvarchar(15) NOT NULL CHECK (prit_type IN ('SNACK', 'FACILITY', 'SOFTDRINK', 'FOOD', 'SERVICE')),
  prit_modified_date datetime,
  CONSTRAINT pk_prit_id PRIMARY KEY(prit_id)
);

CREATE TABLE Users.users (
  user_id int IDENTITY(1,1) NOT NULL,
  user_full_name nvarchar (55) DEFAULT 'guest' NOT NULL,
  user_type nvarchar (15) CHECK(user_type IN('T','C','I')),
  user_company_name nvarchar (255),
  user_email nvarchar(256),
  user_phone_number nvarchar (25) UNIQUE NOT NULL,
  user_modified_date datetime,
	CONSTRAINT pk_user_id PRIMARY KEY(user_id)
);

CREATE TABLE Hotel.hotels (
  hotel_id int IDENTITY(1, 1) NOT NULL CONSTRAINT pk_hotel_id PRIMARY KEY,
  hotel_name nvarchar(85) NOT NULL,
  hotel_description nvarchar(500) NULL,
  hotel_rating_star smallint NULL,
  hotel_phonenumber nvarchar(25) NOT NULL,
  hotel_modified_date datetime NULL,
  hotel_addr_id int NOT NULL,
  CONSTRAINT fk_hotel_addr_id FOREIGN KEY (hotel_addr_id) REFERENCES Master.address(addr_id)
);

CREATE TABLE Hotel.facilities (
  faci_id int IDENTITY(1, 1) NOT NULL CONSTRAINT pk_faci_id PRIMARY KEY,
  faci_name NVARCHAR(125) NOT NULL,
  faci_description nvarchar(255) NULL,
  faci_max_number int NULL,
  faci_measure_unit varchar(15) NULL CHECK(faci_measure_unit IN('People', 'Beds')),
  faci_room_number nvarchar(6) NOT NULL,
  faci_startdate datetime NOT NULL,
  faci_endate datetime NOT NULL,
  faci_low_price money NOT NULL,
  faci_high_price money NOT NULL,
  faci_rate_price money NOT NULL,
  faci_discount smallint NULL,
  faci_tax_rate smallint NULL,
  faci_modified_date datetime NULL,
  faci_cagro_id int NOT NULL,
  faci_hotel_id int NOT NULL,
  CONSTRAINT uq_faci_room_number UNIQUE (faci_room_number),
  CONSTRAINT fk_faci_cagro_id FOREIGN KEY (faci_cagro_id) REFERENCES Master.category_group(cagro_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT fk_faci_hotel_id FOREIGN KEY (faci_cagro_id) REFERENCES Hotel.hotels(hotel_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Booking.special_offers(
    spof_id int IDENTITY(1,1) NOT NULL,
    spof_name nvarchar(55) NOT NULL,
    spof_description nvarchar(255) NOT NULL,
    spof_type nchar(5) NOT NULL CHECK (spof_type IN ('T','C','I')),
    spof_discount smallmoney NOT NULL,
    spof_start_date datetime NOT NULL,
    spof_end_date datetime NOT NULL,
    spof_min_qty int,
    spof_max_qty int,
    spof_modified_date datetime
    CONSTRAINT pk_spof_id PRIMARY KEY(spof_id)
);

CREATE TABLE Booking.booking_orders(
	boor_id int	IDENTITY (1,1),
	boor_order_number nvarchar(55) NOT NULL,
	boor_order_date datetime NOT NULL,
	boor_arrival_date datetime,
	boor_total_room smallint,
	boor_total_guest smallint,
	boor_discount smallmoney,
	boor_total_tax smallmoney,
	boor_total_ammount money,
	boor_down_payment money,
	boor_pay_type nchar(2) NOT NULL,
	boor_is_paid nchar(2) NOT NULL CHECK (boor_is_paid IN ('DP','P','R ')),
	boor_type nvarchar(15) NOT NULL CHECK (boor_type IN ('T','C','I')),
	boor_cardnumber nvarchar(25),
	boor_member_type nvarchar(15),
	boor_status nvarchar(15) CHECK (boor_status IN ('BOOKING','CHECKIN','CHECKOUT','CLEANING','CANCELED')),
	boor_user_id int,
	boor_hotel_id int
	CONSTRAINT pk_boor_id PRIMARY KEY (boor_id),
	CONSTRAINT unique_boor_order_number UNIQUE (boor_order_number),
	CONSTRAINT fk_boor_user_id FOREIGN KEY (boor_user_id) REFERENCES Users.users (user_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
	CONSTRAINT fk_boor_hotel_id FOREIGN KEY (boor_hotel_id) REFERENCES Hotel.hotels (hotel_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT chk_boor_cardnumber CHECK (
    (boor_pay_type IN ('CR', 'PG') AND boor_cardnumber IS NOT NULL) OR
    (boor_pay_type NOT IN ('C', 'D') AND boor_cardnumber IS NULL))
);
-- ALTER TABLE Booking.booking_orders
-- ADD CONSTRAINT chk_boor_down_payment
-- CHECK (boor_is_paid = 'DP' AND boor_down_payment IS NOT NULL);


ALTER TABLE Booking.booking_orders
DROP CONSTRAINT chk_boor_cardnumber

ALTER TABLE Booking.booking_orders
ADD CONSTRAINT chk_boor_cardnumber
CHECK ((boor_pay_type IN ('C', 'D') AND boor_cardnumber IS NULL) OR
(boor_pay_type IN ('CR', 'PG') AND boor_cardnumber IS NOT NULL))

ALTER TABLE Booking.booking_orders
ALTER COLUMN boor_discount float;

ALTER TABLE Booking.booking_order_detail
ALTER COLUMN borde_discount float;

ALTER TABLE Booking.special_offers
ALTER COLUMN spof_discount float;


CREATE TABLE Booking.booking_order_detail(
	borde_boor_id integer,
	borde_id int IDENTITY (1,1) UNIQUE NOT NULL,
	borde_checkin datetime NOT NULL,
	borde_checkout datetime NOT NULL,
	borde_adults integer,
	borde_kids integer,
	borde_price money,
	borde_extra money,
	borde_discount smallmoney,
	borde_tax smallmoney,
	borde_subtotal money,
	borde_faci_id integer,
	CONSTRAINT pk_borde_id_boor_id PRIMARY KEY (borde_id, borde_boor_id),
	CONSTRAINT fk_border_boor_id FOREIGN KEY(borde_boor_id)	REFERENCES Booking.booking_orders(boor_id),
	CONSTRAINT fk_borde_faci_id FOREIGN KEY(borde_faci_id) REFERENCES Hotel.facilities(faci_id) 
		ON DELETE CASCADE 
    ON UPDATE CASCADE 
);

CREATE TABLE Booking.booking_order_detail_extra(
	boex_id int IDENTITY (1,1),
	boex_price money,
	boex_qty smallint,
	boex_subtotal money,
	boex_measure_unit nvarchar (50), CHECK(boex_measure_unit IN ('people','unit','kg')),
	boex_borde_id int,
	boex_prit_id int
	CONSTRAINT pk_boex_id PRIMARY KEY (boex_id),
	CONSTRAINT fk_boex_borde_id FOREIGN KEY (boex_borde_id) REFERENCES Booking.booking_order_detail (borde_id) 
		ON DELETE CASCADE 
    ON UPDATE CASCADE,
	CONSTRAINT fk_boex_prit_id FOREIGN KEY (boex_prit_id) REFERENCES Master.price_item(prit_id) 
		ON DELETE CASCADE 
    ON UPDATE CASCADE
)


CREATE TABLE Booking.special_offer_coupons(
    soco_id int IDENTITY(1,1),
    soco_borde_id int,
    soco_spof_id int,
    CONSTRAINT pk_soco_id PRIMARY KEY(soco_id),
    CONSTRAINT fk_soco_borde_id FOREIGN KEY(soco_borde_id) REFERENCES Booking.booking_order_detail(borde_id) 
      ON DELETE CASCADE 
      ON UPDATE CASCADE,
    CONSTRAINT fk_soco_spof_id FOREIGN KEY(soco_spof_id) REFERENCES Booking.special_offers(spof_id) 
		  ON DELETE CASCADE 
      ON UPDATE CASCADE
);

CREATE TABLE Booking.user_breakfast(
    usbr_borde_id int,
    usbr_modified_date datetime,
    usbr_total_vacant smallint NOT NULL,
    CONSTRAINT pk_usbr_borde_id_usbr_modified_date PRIMARY KEY(usbr_borde_id,usbr_modified_date),
    CONSTRAINT fk_usbr_borde_id FOREIGN KEY(usbr_borde_id) 
		REFERENCES Booking.booking_order_detail(borde_id) 
		ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Booking.booking_orders
ALTER COLUMN boor_total_tax DECIMAL(5,2);

ALTER TABLE Booking.booking_orders
ADD CONSTRAINT boor_default_tot_tax DEFAULT 0.11 FOR boor_total_tax

ALTER TABLE Booking.booking_order_detail
ALTER COLUMN borde_discount DECIMAL(5,2);

ALTER TABLE Booking.booking_orders
ALTER COLUMN boor_discount DECIMAL(5,2);

ALTER TABLE Booking.booking_order_detail
ALTER COLUMN borde_tax DECIMAL(5,2);

ALTER TABLE Booking.booking_order_detail
ADD CONSTRAINT borde_default_tax DEFAULT 0.11 FOR borde_tax