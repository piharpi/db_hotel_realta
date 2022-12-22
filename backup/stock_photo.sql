/*drop table purchasing.stock_photo;
*/

create table purchasing.stock_photo(
	spho_id int identity (1,1),
	spho_thumbnail_filename nvarchar (50),
	spho_photo_filename nvarchar (50),
	spho_primary bit DEFAULT 0 CHECK (spho_primary IN (0,1)),
	spho_url nvarchar(355),
	spho_stock_id int,
	constraint pk_spho_id primary key (spho_id),
	constraint fk_spho_stock_id foreign key (spho_stock_id) references purchasing.stocks(stock_id) ON DELETE CASCADE on UPDATE CASCADE
)