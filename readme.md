# HotelRealtaDB 

1. Clone `git@github.com:piharpi/db_hotel_realta.git`
2. Checkout `[namabranch]`  sesuai dengan module masing-masing
    - terdapat 4 files (`hotel_realta.sql`, `store_procedure.sql`, `trigger.sql`, `insert.sql`) :
    - File `hotel_realta.sql` digunakan untuk mendefinisikan DDL.
    - File `store_procedure.sql` digunakan untuk mendefinisikan kumpulan procedures(_routines_).
    - File `trigger.sql` digunakan untuk mendefinisikan kumpulan trigger. 
    - File `insert.sql` digunakan untuk inisiasi data awal.
3. Jika memiliki perubahan pada project silahkan push di branch masing-masing dan pull request. 

_***)**_ Sebelum Pull Request pastikan tidak mengganggu fitur module lain. 

## Eksekusi
Untuk mengeksekusi harus berurutan dari :
1. `hotel_realta.sql` 
2. `store_procedure.sql`
3. `trigger.sql`
4. `insert.sql`