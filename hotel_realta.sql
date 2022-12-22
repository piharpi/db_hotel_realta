CREATE DATABASE Hotel_Realta
USE Hotel_Realta

CREATE SCHEMA [resto]

GO

CREATE TABLE resto.facilities
(
    faci_id INT IDENTITY(1,1)
        CONSTRAINT pk_faci_id PRIMARY KEY (faci_id)

);

CREATE TABLE resto.resto_menus
(
    reme_faci_id INT,
    reme_id INT IDENTITY(1,1),
    reme_name NVARCHAR(55) NOT NULL,
    reme_description NVARCHAR(255),
    reme_price MONEY NOT NULL,
    reme_status NVARCHAR(15) NOT NULL,
    reme_modified_date DATETIME,
    CONSTRAINT pk_reme_faci_id PRIMARY KEY (reme_id),
    CONSTRAINT reme_faci_id FOREIGN KEY (reme_faci_id) REFERENCES resto.facilities(faci_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE resto.users
(
    user_id INTEGER
        CONSTRAINT pk_user_id PRIMARY KEY (user_id),
);

CREATE TABLE resto.order_menus
(
    orme_id INT IDENTITY,
    orme_order_number NVARCHAR (20) NOT NULL,
    orme_order_date DATETIME NOT NULL,
    orme_total_item SMALLINT,
    orme_total_discount SMALLMONEY,
    orme_total_amount MONEY,
    orme_pay_type NCHAR(2) NOT NULL,
    orme_cardnumber NVARCHAR(25),
    orme_is_paid nchar(2),
    orme_modified_date DATETIME,
    orme_user_id INTEGER,
    CONSTRAINT pk_orme_id PRIMARY KEY (orme_id),
    CONSTRAINT fk_orme_user_id FOREIGN KEY (orme_user_id) REFERENCES resto.users(user_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE resto.order_menu_detail
(
    omde_id INT IDENTITY,
    orme_price MONEY NOT NULL,
    orme_qty SMALLINT NOT NULL,
    orme_subtotal MONEY NOT NULL,
    orme_discount SMALLMONEY,
    omde_orme_id INTEGER,
    omde_reme_id INTEGER,
    CONSTRAINT pk_omme_id PRIMARY KEY (omde_id),
    CONSTRAINT fk_omde_orme_id FOREIGN KEY (omde_orme_id) REFERENCES resto.order_menus(orme_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_omde_reme_id FOREIGN KEY (omde_reme_id) REFERENCES resto.resto_menus(reme_id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE resto.resto_menu_photos
(
    remp_id INT IDENTITY,
    remp_thumbnial_filname NVARCHAR (50),
    remp_photo_filename NVARCHAR (50),
    remp_primary BIT,
    remp_url NVARCHAR (255),
    remp_reme_id INT,
    CONSTRAINT pk_remp_id PRIMARY KEY (remp_id),
    CONSTRAINT fk_remp_reme_id FOREIGN KEY (remp_reme_id) REFERENCES resto.resto_menus(reme_id)
);



