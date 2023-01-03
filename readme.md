# PURCHASING MODULE

![table structure](purchasing_module.jpeg)

## Daftar Tabel
- stocks
- stock_photo
- stock_detail
- purchase_order_header
- purchase_order_detail
- vendor

<!-- **### Clustered Primary **Key**
- stock_detail : stod_stock_id
- purchase_order_detail : pode_pohe_id** -->

### Trigger 
- [x] pohe_subtotal: Kolom ini harus dihitung secara otomatis berdasarkan jumlah total harga produk yang dipesan.
- [ ] pohe_tax: Kolom ini harus dihitung secara otomatis berdasarkan tarif pajak yang berlaku.
- [x] stock_quantity: Kolom ini harus dihitung secara otomatis berdasarkan total stod_stocked_qty dimana stod_stock_id = stock_id
- [x] stock_used: Kolom ini harus dihitung secara otomatis berdasarkan total item dengan stod_status = 4 (used)
- [x] stock_scrap: Kolom ini harus dihitung secara otomatis berdasarkan total item dengan stod_status = 2 (expired) | 3 (broken)

### Computed
- [x] pohe_total_amount: Kolom ini harus dihitung secara otomatis berdasarkan pohe_subtotal ditambah pohe_tax.
- [x] pode_line_total: Kolom ini harus dihitung secara otomatis berdasarkan pode_order_qty dikali pode_price. 
- [x] pode_stocked_qty: Kolom ini harus dihitung secara otomatis berdasarkan pode_received_qty dikurangi pode_rejected_qty. 