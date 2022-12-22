USE hotel_realta;

create table purchasing.stocks(
	stock_id int identity (1,1),
	stock_name nvarchar(255) NOT NULL,
	stock_description nvarchar(255),
	stock_quantity smallint not null,
	stock_reorder_point smallint not null,
	stock_used smallint,
	stock_scrap smallint,
	stock_price money not null,
	stock_standar_cost money not null,
	stock_size nvarchar (25),
	stock_color nvarchar (15),
	stock_modified_date datetime,
	constraint pk_department_id primary key (stock_id)
)


/**/