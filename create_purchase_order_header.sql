CREATE TABLE purchasing.purchase_order_header(
    pohe_id INT IDENTITY(1,1) NOT NULL,
    pohe_number NVARCHAR(20),
    pohe_status TINYINT DEFAULT 1 CHECK (pohe_status IN(1, 2, 3, 4)),
    pohe_order_date DATETIME,
    pohe_subtotal MONEY,
    pohe_tax MONEY,
    pohe_total_amount MONEY,
    pohe_refund MONEY,
    pohe_arrival_date DATETIME,
    pohe_pay_type NCHAR(2) NOT NULL CHECK (pohe_pay_type IN('TR', 'CA')),
    pohe_emp_id INT,
    pohe_vendor_id INT

    CONSTRAINT pk_pohe_id PRIMARY KEY(pohe_id),
    CONSTRAINT fk_pohe_emp_id FOREIGN KEY (pohe_emp_id) REFERENCES hr.employee(emp_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pohe_vendor_id FOREIGN KEY (pohe_vendor_id) REFERENCES purchasing.vendor(vendor_id) ON DELETE CASCADE ON UPDATE CASCADE
);
