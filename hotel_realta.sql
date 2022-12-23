-- Create Schema 'Hotel'
CREATE SCHEMA Hotel;
GO

-- Create a new table called 'Hotels' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.Hotels', 'U') IS NOT NULL
DROP TABLE Hotel.Hotels
GO
-- Create the table in the specified schema
CREATE TABLE Hotel.Hotels
(
  hotel_id INT IDENTITY(1,1) NOT NULL CONSTRAINT hotel_id_pk PRIMARY KEY, -- primary key column
  hotel_name NVARCHAR(85) NOT NULL,
  hotel_description NVARCHAR(500) NULL,
  hotel_rating_star SMALLINT NULL,
  hotel_phonenumber NVARCHAR(25) NOT NULL,
  hotel_modified_date DATETIME NULL, 
  -- Primary Key
  hotel_addr_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT hotel_addr_id_fk FOREIGN KEY (hotel_addr_id) REFERENCES Master.Address(addr_id)
);
GO

-- Create a new table called 'Hotel_Reviews' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.Hotel_Reviews', 'U') IS NOT NULL
DROP TABLE Hotel.Hotel_Reviews
GO
-- Create the table in the specified schema
CREATE TABLE Hotel.Hotel_Reviews
(
  hore_id INT IDENTITY(1,1) NOT NULL CONSTRAINT hore_id_pk PRIMARY KEY, -- primary key column
  hore_user_review NVARCHAR(125) NOT NULL,
  hore_rating BIT NOT NULL CHECK(hore_rating IN(1,2,3,4,5)) DEFAULT 5,
  hore_created_on DATETIME NULL,
  -- FOREIGN KEY
  hore_user_id INT NOT NULL,
  hore_hotel_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT hore_user_id_pk FOREIGN KEY (hore_user_id) REFERENCES Users.Users(user_id),
  CONSTRAINT hore_hotel_id_fk FOREIGN KEY (hore_hotel_id) REFERENCES Hotel.Hotels(hotel_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO


-- Create a new table called 'Facilities' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.Facilities', 'U') IS NOT NULL
DROP TABLE Hotel.Facilities
GO
-- Create the table in the specified schema
CREATE TABLE Hotel.Facilities
(
  faci_id INT IDENTITY(1,1) NOT NULL CONSTRAINT faci_id_pk PRIMARY KEY, -- primary key column
  faci_description NVARCHAR(255) NULL,
  faci_max_number INT NULL,
  faci_measure_unit VARCHAR(15) NULL CHECK(faci_measure_unit IN('People','Beds')),
  faci_room_number NVARCHAR(6) NOT NULL,
  faci_startdate DATETIME NOT NULL,
  faci_endate DATETIME NOT NULL,
  faci_low_price MONEY NOT NULL,
  faci_high_price MONEY NOT NULL,
  faci_rate_price MONEY NOT NULL,
  faci_discount SMALLMONEY NULL,
  faci_tax_rate SMALLMONEY NULL,
  faci_modified_date DATETIME NULL,
  --FOREIGN KEY
  faci_cagro_id INTEGER NOT NULL,
  faci_hotel_id INT NOT NULL,
  -- UNIQUE ID
  CONSTRAINT faci_room_number_uq UNIQUE (faci_room_number),
  -- Add this later, on production
  CONSTRAINT faci_cagro_id_fk FOREIGN KEY (faci_cagro_id) REFERENCES Master.Category_Group(cagro_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT faci_hotel_id_fk FOREIGN KEY (faci_cagro_id) REFERENCES Hotel.Hotels(hotel_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create a new table called 'Facility_Price_History' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.Facility_Price_History', 'U') IS NOT NULL
DROP TABLE Hotel.Facility_Price_History
GO
-- Create the table in the specified schema
CREATE TABLE Hotel.Facility_Price_History
(
  faph_id INT IDENTITY(1,1) NOT NULL CONSTRAINT faph_id_pk PRIMARY KEY, -- primary key column
  faph_startdate DATETIME NOT NULL,
  faph_enddate DATETIME NOT NULL,
  faph_low_price MONEY NOT NULL,
  faph_high_price MONEY NOT NULL,
  faph_rate_price MONEY NOT NULL,
  faph_discount SMALLMONEY NOT NULL,
  faph_tax_rate SMALLMONEY NOT NULL,
  faph_modified_date DATETIME,
  -- FOREIGN KEY
  faph_faci_id INT NOT NULL,
  faph_user_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT faph_faci_id_fk FOREIGN KEY (faph_faci_id) REFERENCES Hotel.Facilities(faci_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT faph_user_id_fk FOREIGN KEY (faph_user_id) REFERENCES Users.Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create a new table called 'Facility_Photos' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.Facility_Photos', 'U') IS NOT NULL
DROP TABLE Hotel.Facility_Photos
GO
-- Create the table in the specified schema
CREATE TABLE Hotel.Facility_Photos
(
  fapho_id INT IDENTITY(1,1) NOT NULL CONSTRAINT fapho_id_pk PRIMARY KEY, -- primary key column
  fapho_thumbnail_filename NVARCHAR(50) NULL,
  fapho_photo_filename NVARCHAR(50) NULL,
  fapho_primary BIT NULL CHECK(fapho_primary IN(0,1)),
  fapho_url NVARCHAR(255) NULL,
  fapho_modified_date DATETIME,
  -- FOREIGN KEY
  fapho_faci_id INT NOT NULL,
  CONSTRAINT fapho_faci_id_pk FOREIGN KEY (fapho_faci_id) REFERENCES Hotel.Facilities(faci_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
