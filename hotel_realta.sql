CREATE DATABASE Hotel_Realta

USE Hotel_Realta

GO
CREATE SCHEMA [master] ;
GO

create table Master.regions(
region_code int identity(1,1),
region_name nvarchar(35) unique not null,
constraint pk_region_code primary key(region_code)
);
create table Master.country(
country_id int identity(1,1),
country_name nvarchar (55) unique not null,
country_region_id int,
constraint pk_country_id primary key (country_id),
constraint fk_country_region_id foreign key(country_region_id) references Master.regions(region_code) on delete cascade on update cascade

);

create table Master.provinces(
prov_id int identity (1,1),
prov_name nvarchar (85) not null,
prov_country_id int
constraint pk_prov_id primary key(prov_id),
constraint fk_prov_country_name foreign key(prov_country_id) references Master.country(country_id) on delete cascade on update cascade
);

create table Master.address(
addr_id int identity(1,1),
addr_line1 nvarchar(255) not null,
addr_line2 nvarchar(255),
addr_postal_code nvarchar(5),
addr_spatial_location geography,
addr_prov_id int,
constraint pk_addr_id primary key(addr_id),
constraint fk_addr_prov_id foreign key(addr_prov_id) references Master.provinces(prov_id) on delete cascade on update cascade
);

create table master.category_group(
cagro_id int identity(1,1),
cagro_name nvarchar(25) unique not null check (cagro_name in ('1','2','3 ','4','5','6','7')),
cagro_description nvarchar(255),
cagro_type nvarchar(25) not null check (cagro_type in('category','service','facility')),
cagro_icon nvarchar(255),
cagro_icon_url nvarchar(255),
constraint pk_cagro_id primary key(cagro_id)
);
-- DROP TABLE master.category_group


create table master.policy(
poli_id int identity(1,1),
poli_name nvarchar(55) not null,
poli_description nvarchar(255),
constraint pk_poli_id primary key(poli_id)
);

create table master.policy_category_group(
poca_poli_id int  not null,
poca_cagro_id int not null,
constraint fk_poca_poli_id foreign key(poca_poli_id)references Master.policy(poli_id) on delete cascade on update cascade,
constraint fk_poca_cagro_id foreign key(poca_cagro_id)references Master.category_group(cagro_id) on delete cascade on update cascade
);
-- DROP TABLE master.policy_category_group

create table master.price_item(
prit_id int identity(1,1),
prit_name nvarchar(55) unique not null,
prit_price money not null,
prit_description nvarchar(255),
prit_type nvarchar(15) not null check (prit_type in ('SNACK','FACILITY','SOFTDRINK','FOOD','SERVICE')),
prit_modified_date datetime,
constraint pk_prit_id primary key(prit_id)
);
-- DROP TABLE master.price_item

create table master.service_task(
seta_id int identity(1,1),
seta_name nvarchar(85) unique not null,
seta_seq smallint
constraint pk_set_id primary key(seta_id) 
);

create table master.members(
memb_name nvarchar(15) not null,
memb_description nvarchar(100),
constraint pk_memb_name primary key(memb_description)
);
