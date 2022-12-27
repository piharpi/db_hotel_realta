-- Create Schema 'Hotel'
CREATE SCHEMA Hotel;

GO -- Create a new table called 'hotels' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.hotels', 'U') IS NOT NULL DROP TABLE Hotel.hotels GO -- Create the table in the specified schema
CREATE TABLE Hotel.hotels (
  hotel_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_hotel_id PRIMARY KEY,
  -- primary key column
  hotel_name NVARCHAR(85) NOT NULL,
  hotel_description NVARCHAR(500) NULL,
  hotel_rating_star SMALLINT NULL,
  hotel_phonenumber NVARCHAR(25) NOT NULL,
  hotel_modified_date DATETIME NULL,
  -- Primary Key
  hotel_addr_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT fk_hotel_addr_id FOREIGN KEY (hotel_addr_id) REFERENCES Master.address(addr_id)
);

GO -- Create a new table called 'hotel_reviews' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.hotel_reviews', 'U') IS NOT NULL DROP TABLE Hotel.hotel_reviews GO -- Create the table in the specified schema
CREATE TABLE Hotel.hotel_reviews (
  hore_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_hore_id PRIMARY KEY,
  -- primary key column
  hore_user_review NVARCHAR(125) NOT NULL,
  hore_rating BIT NOT NULL CHECK(hore_rating IN(1, 2, 3, 4, 5)) DEFAULT 5,
  hore_created_on DATETIME NULL,
  -- FOREIGN KEY
  hore_user_id INT NOT NULL,
  hore_hotel_id INT NOT NULL,
  -- Add this later, on production
  CONSTRAINT pk_hore_user_id FOREIGN KEY (hore_user_id) REFERENCES Users.users(user_id),
  CONSTRAINT fk_hore_hotel_id FOREIGN KEY (hore_hotel_id) REFERENCES Hotel.hotels(hotel_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE
);

GO -- Create a new table called 'facilities' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.facilities', 'U') IS NOT NULL DROP TABLE Hotel.facilities GO -- Create the table in the specified schema
CREATE TABLE Hotel.facilities (
  faci_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_faci_id PRIMARY KEY,
  -- primary key column
  faci_description NVARCHAR(255) NULL,
  faci_max_number INT NULL,
  faci_measure_unit VARCHAR(15) NULL CHECK(faci_measure_unit IN('People', 'Beds')),
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
  CONSTRAINT uq_faci_room_number UNIQUE (faci_room_number),
  -- Add this later, on production
  CONSTRAINT fk_faci_cagro_id FOREIGN KEY (faci_cagro_id) REFERENCES Master.category_group(cagro_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE,
    CONSTRAINT fk_faci_hotel_id FOREIGN KEY (faci_cagro_id) REFERENCES Hotel.hotels(hotel_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE
);

GO -- Create a new table called 'facility_price_history' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.facility_price_history', 'U') IS NOT NULL DROP TABLE Hotel.facility_price_history GO -- Create the table in the specified schema
CREATE TABLE Hotel.facility_price_history (
  faph_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_faph_id PRIMARY KEY,
  -- primary key column
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
  CONSTRAINT fk_faph_faci_id FOREIGN KEY (faph_faci_id) REFERENCES Hotel.facilities(faci_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE,
    CONSTRAINT fk_faph_user_id FOREIGN KEY (faph_user_id) REFERENCES Users.users(user_id) ON DELETE CASCADE ON
  UPDATE
    CASCADE
);

GO -- Create a new table called 'facility_photos' in schema 'Hotel'
-- Drop the table if it already exists
IF OBJECT_ID('Hotel.facility_photos', 'U') IS NOT NULL DROP TABLE Hotel.facility_photos GO -- Create the table in the specified schema
CREATE TABLE Hotel.facility_photos (
  fapho_id INT IDENTITY(1, 1) NOT NULL CONSTRAINT pk_fapho_id PRIMARY KEY,
  -- primary key column
  fapho_thumbnail_filename NVARCHAR(50) NULL,
  fapho_photo_filename NVARCHAR(50) NULL,
  fapho_primary BIT NULL CHECK(fapho_primary IN(0, 1)),
  fapho_url NVARCHAR(255) NULL,
  fapho_modified_date DATETIME,
  -- FOREIGN KEY
  fapho_faci_id INT NOT NULL,
  CONSTRAINT pk_fapho_faci_id FOREIGN KEY (fapho_faci_id) REFERENCES Hotel.facilities(faci_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

GO