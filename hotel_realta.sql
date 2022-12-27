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

CREATE SCHEMA Users;
GO

CREATE SCHEMA Master;
GO


-- MODULE MASTER

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
  cagro_name nvarchar(25) UNIQUE NOT NULL CHECK (cagro_name IN ('1', '2', '3 ', '4', '5', '6', '7')),
  cagro_description nvarchar(255),
  cagro_type nvarchar(25) NOT NULL CHECK (cagro_type IN('category', 'service', 'facility')),
  cagro_icon nvarchar(255),
  cagro_icon_url nvarchar(255),
  CONSTRAINT pk_cagro_id PRIMARY KEY(cagro_id)
);

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

CREATE TABLE Master.price_item (
  prit_id int IDENTITY(1, 1),
  prit_name nvarchar(55) UNIQUE NOT NULL,
  prit_price money NOT NULL,
  prit_description nvarchar(255),
  prit_type nvarchar(15) NOT NULL CHECK (prit_type IN ('SNACK', 'FACILITY', 'SOFTDRINK', 'FOOD', 'SERVICE')),
  prit_modified_date datetime,
  CONSTRAINT pk_prit_id PRIMARY KEY(prit_id)
);

CREATE TABLE Master.service_task (
  seta_id int IDENTITY(1, 1),
  seta_name nvarchar(85) UNIQUE NOT NULL,
  seta_seq smallint CONSTRAINT pk_set_id PRIMARY KEY(seta_id)
);

CREATE TABLE Master.members (
  memb_name nvarchar(15) NOT NULL,
  memb_description nvarchar(100),
  CONSTRAINT pk_memb_name PRIMARY KEY(memb_name)
);

-- MODULE USERS

CREATE TABLE users.users (
    user_id INT IDENTITY(1,1) NOT NULL,
    user_full_name NVARCHAR (55) DEFAULT 'guest' NOT NULL,
    user_type NVARCHAR (15) CHECK(user_type IN('T','C','I')),
    user_company_name NVARCHAR (255),
    user_email NVARCHAR(256),
    user_phone_number NVARCHAR (25) UNIQUE NOT NULL,
    user_modified_date DATETIME,
	CONSTRAINT pk_user_id PRIMARY KEY(user_id)
);

CREATE TABLE users.user_members (
    usme_user_id INT,
    usme_memb_name NVARCHAR (15) CHECK(usme_memb_name IN('Silver','Gold','VIP','Wizard')),
    usme_promote_date DATETIME,
    usme_points SMALLINT,
    usme_type NVARCHAR(15) DEFAULT 'Expired',
	CONSTRAINT pk_usme_user_id PRIMARY KEY(usme_user_id),
	CONSTRAINT fk_usme_user_id FOREIGN KEY(usme_user_id) REFERENCES users.users (user_id)
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	CONSTRAINT fk_usme_memb_name FOREIGN KEY (usme_memb_name) REFERENCES master.members(memb_name)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.roles (
    role_id INT IDENTITY(1,1),
    role_name NVARCHAR (35) NOT NULL,
	CONSTRAINT pk_role_id PRIMARY KEY(role_id)
);

CREATE TABLE users.user_roles (
    usro_user_id INT,
    usro_role_id INT,
	CONSTRAINT pk_usro_user_id PRIMARY KEY(usro_user_id),
	CONSTRAINT fk_usro_user_id FOREIGN KEY (usro_user_id) REFERENCES users.users (user_id) 
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_usro_role_id FOREIGN KEY (usro_role_id) REFERENCES users.roles (role_id) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.user_profiles (
    uspro_id INT IDENTITY(1,1),
    uspro_national_id NVARCHAR (20) NOT NULL,
    uspro_birth_date DATE NOT NULL,
    uspro_job_title NVARCHAR (50),
    uspro_marital_status NCHAR(1) CHECK(uspro_marital_status IN('M','S')),
    uspro_gender NCHAR(1) CHECK(uspro_gender IN('M','F')),
    uspro_addr_id INT,
    uspro_user_id INT,
	CONSTRAINT pk_usro_id PRIMARY KEY(uspro_id),
	CONSTRAINT fk_uspro_user_id FOREIGN KEY (uspro_user_id) REFERENCES users.users (user_id) 
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_uspro_addr_id FOREIGN KEY (uspro_addr_id) REFERENCES master.address (addr_id) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.bonus_points (
    ubpo_id INT IDENTITY(1,1),
    ubpo_user_id INT,
    ubpo_total_points SMALLINT,
    ubpo_bonus_type NCHAR (1),
    ubpo_created_on DATETIME,
	CONSTRAINT pk_ubpo_id PRIMARY KEY(ubpo_id),
	CONSTRAINT fk_ubpo_user_id FOREIGN KEY (ubpo_user_id) REFERENCES users.users (user_id) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE users.user_password (
    uspa_user_id INT IDENTITY(1,1),
    uspa_passwordHash VARCHAR (128),
    uspa_passwordSalt VARCHAR (10),
	CONSTRAINT pk_uspa_user_id PRIMARY KEY(uspa_user_id),
	CONSTRAINT fk_uspa_user_id FOREIGN KEY (uspa_user_id) REFERENCES users.users (user_id) 
);