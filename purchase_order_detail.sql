CREATE TABLE purchasing.purchase_order_detail(
    pode_pohe_id INT,
    pode_id int IDENTITY (1,1),
    pode_order_qty smallint not NULL,
    pode_price money not null,
    pode_line_total money not null,
    pode_received_qty decimal(8,2),
    pode_rejected_qty decimal (8,2),
    pode_stocked_qty decimal (9,2),
    pode_modified_date datetime,
    pode_stock_id int,

    CONSTRAINT pk_pode_id PRIMARY KEY (pode_id),
    CONSTRAINT fk_pode_pohe_id FOREIGN KEY (pode_pohe_id) REFERENCES purchasing.purchase_order_header(pohe_id) ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_pode_stock_id FOREIGN KEY (pode_stock_id) REFERENCES purchasing.stocks(stock_id) ON DELETE CASCADE ON UPDATE CASCADE 

);