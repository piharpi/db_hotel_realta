create TABLE purchasing.stock_detail (
    stod_stock_id int,
    stod_id int identity,
    stod_barcode_number nvarchar (255),
    stod_status nchar(2) default 1,
    stod_notes nvarchar(1024),
    stod_faci_id int,
    stod_pohe_id int,

    CONSTRAINT pk_stod_id primary key (stod_id),
    CONSTRAINT fk_stod_stock_id foreign key (stod_stock_id) references purchasing.stocks(stock_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_stod_pohe_id foreign key (stod_pohe_id) references purchasing.purchase_order_header(pohe_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_stod_faci_id foreign key (stod_faci_id) references hotel.facility(hofa_faci_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_stod_barcode_number unique (stod_barcode_number)
)