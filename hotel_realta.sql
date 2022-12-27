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

-- dummy schema master
CREATE SCHEMA Master;
GO

-- dummy table master.members
CREATE TABLE master.members (
	memb_name NVARCHAR(15) NOT NULL,
	CONSTRAINT pk_memb_name PRIMARY KEY(memb_name)
);

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
	CONSTRAINT fk_usme_user_id FOREIGN KEY (usme_user_id) REFERENCES users.users (user_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_usme_memb_name FOREIGN KEY (usme_memb_name) REFERENCES master.members (memb_name)
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

--- dummy table master.address
CREATE TABLE master.address (
	addr_id INT IDENTITY(1,1),
	CONSTRAINT pk_addr_id PRIMARY KEY(addr_id)
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
