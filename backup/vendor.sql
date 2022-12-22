

create table purchasing.vendor(
	vendor_id int identity (1,1),
	vendor_name nvarchar(55) not null,
	vendor_active bit default 1 CHECK (vendor_active in (0,1)),
	vendor_priority bit default 0 CHECK (vendor_priority in (0,1)),
	vendor_register_date datetime not null,
	vendor_weburl nvarchar(1025),
	vendor_modifier_date datetime,
	constraint pk_vendor_id primary key (vendor_id)
);



