-- membuat database
USE tempdb;
GO

DROP DATABASE IF EXISTS Hotel_Realta;
GO

CREATE DATABASE Hotel_Realta;
GO

-- menggunakan db hotel_realta
USE Hotel_Realta;
GO

CREATE SCHEMA Master;
GO

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
  cagro_name nvarchar(25) UNIQUE NOT NULL,
  cagro_description nvarchar(255),
  cagro_type nvarchar(25) NOT NULL CHECK (cagro_type IN('category', 'service', 'facility')),
  cagro_icon nvarchar(255),
  cagro_icon_url nvarchar(255),
  CONSTRAINT pk_cagro_id PRIMARY KEY(cagro_id)
);

-- DROP TABLE master.category_group
CREATE TABLE Master.policy (
  poli_id int IDENTITY(1, 1),
  poli_name nvarchar(55) NOT NULL,
  poli_description nvarchar(255),
  CONSTRAINT pk_poli_id PRIMARY KEY(poli_id)
);

CREATE TABLE Master.policy_category_group (
  poca_poli_id int NOT NULL,
  poca_cagro_id int NOT NULL,
  CONSTRAINT fk_poca_poli_id FOREIGN KEY(poca_poli_id) REFERENCES Master.policy(poli_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT fk_poca_cagro_id FOREIGN KEY(poca_cagro_id) REFERENCES Master.category_group(cagro_id) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);
-- DROP TABLE master.policy_category_group

CREATE TABLE Master.price_item (
  prit_id int IDENTITY(1, 1),
  prit_name nvarchar(55) UNIQUE NOT NULL,
  prit_price money NOT NULL,
  prit_description nvarchar(255),
  prit_type nvarchar(15) NOT NULL CHECK (prit_type IN ('SNACK', 'FACILITY', 'SOFTDRINK', 'FOOD', 'SERVICE')),
  prit_modified_date datetime,
  CONSTRAINT pk_prit_id PRIMARY KEY(prit_id)
);

-- DROP TABLE master.price_item
CREATE TABLE Master.service_task (
  seta_id int IDENTITY(1, 1),
  seta_name nvarchar(85) UNIQUE NOT NULL,
  seta_seq smallint CONSTRAINT pk_set_id PRIMARY KEY(seta_id)
);

CREATE TABLE Master.members (
  memb_name nvarchar(15) NOT NULL,
  memb_description nvarchar(200),
  CONSTRAINT pk_memb_name PRIMARY KEY(memb_description)
);
