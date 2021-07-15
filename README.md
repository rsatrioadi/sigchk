## Requirements

- Ruby ~> 2.1
- Origami ~> 2.1

    ```console
    $ gem install origami
    ```

## sigcmpcsv

Memeriksa posisi ttd di file PDF terhadap file referensi. Nama file PDF harus mengandung NIM yang dimaksud.  
Cara pakai:

```console
$ ./sigcmpcsv.rb [nama-file-referensi.csv] [nama-file-yang-dicek.pdf]
```
File referensi berupa CSV dengan format baris:

```
NIM,kode-prodi(,nomor-halaman,x1,y1,x2,y2)*
```

e.g.
|          |     |   |     |     |     |     |   |     |     |     |     |   |     |     |     |     |   |     |     |     |     | 
|----------|-----|---|-----|-----|-----|-----|---|-----|-----|-----|-----|---|-----|-----|-----|-----|---|-----|-----|-----|-----| 
| 101XXYYY | 101 | 3 | 318 | 157 | 431 | 214 | 4 | 318 | 157 | 431 | 214 | 2 | 174 | 111 | 299 | 167 | 1 | 174 | 111 | 299 | 167 | 
| 101XXYYZ | 101 | 3 | 318 | 157 | 431 | 214 | 4 | 318 | 157 | 431 | 214 | 2 | 174 | 111 | 299 | 167 | 1 | 174 | 111 | 299 | 167 | 
| 101XXYZZ | 101 | 3 | 318 | 166 | 431 | 223 | 4 | 318 | 157 | 431 | 214 | 2 | 174 | 111 | 299 | 167 | 1 | 174 | 111 | 299 | 167 | 


Output berupa satu line untuk setiap file PDF yang diperiksa. Setiap line merupakan tuple `<NIM>,<hasil pemeriksaan>`

Contoh pemanggilan & output:

```console
$ ./sigcmpcsv.rb ref.csv 12345678.pdf 23456789.pdf
12345678,OK
23456789,4 extra 
```

## csvprep

File referensi posisi tandatangan dapat dibuat dengan `csvprep.rb`:

```console
$ ./csvprep.rb [csv-per-wisudawan] [csv-per-penandatangan] [dekan|rektor|tera]
```

Dengan csv-per-wisudawan terdiri atas:

```csv
nim,no_ps,pos_x_transkrip_id,pos_y_transkrip_id,pos_x_transkrip_en,pos_y_transkrip_en
```

e.g.

| nim      | no_ps | pos_x_transkrip_id | pos_y_transkrip_id | pos_x_transkrip_en | pos_y_transkrip_en | 
|----------|-------|--------------------|--------------------|--------------------|--------------------| 
| 101XXYYY | 101   | 112.10875939819299 | 220.12189505645415 | 112.10875939819299 | 220.12190041930518 | 
| 101XXYYZ | 101   | 112.10875939819299 | 220.12189505645415 | 112.10875939819299 | 220.12190041930518 | 
| 101XXYZZ | 101   | 112.10875939819299 | 216.78303228130517 | 112.10875939819299 | 220.1219057821562  | 


dan csv-per-penandatangan terdiri atas:

```csv
no_prodi,six_signee,page,lower_left_x,lower_left_y,upper_right_x,upper_right_y
```

e.g.

| no_prodi | six_signee          | page | lower_left_x | lower_left_y | upper_right_x | upper_right_y | 
|----------|---------------------|------|--------------|--------------|---------------|---------------| 
| 101      | rxxxxxxk@itb.ac.id  | 2    | 528          | 108          | 683           | 163           | 
| 101      | rxxxxxx@itb.ac.id  | 1    | 528          | 108          | 683           | 163           | 
| 101      | sxxxxxxxx@itb.ac.id | 2    | 174          | 111          | 299           | 167           | 
| 101      | sxxxxxxxx@itb.ac.id | 1    | 174          | 111          | 299           | 167           | 


Untuk memeriksa tandatangan digital di ijazah cukup pakai dua script tersebut. Di bawah ini penjelasan komponen-komponen yang lebih primitif:

## sigchk

Mencetak nama file, jumlah signature di dalam file tsb, dan info tentang field signature yang ada di file tsb:

- `:page_id` adalah nomor halaman di mana field tsb berada.
- `:label` adalah label field signature tsb.
- `:rect` adalah bounding box field tsb.

Cara pakai:

```console
$ ./sigchk.rb [nama-file-pdf]
```

Contoh pemanggilan & output:

```console
$ ./sigchk.rb 10116008_2.pdf
10116008_2.pdf: 6 signatures
  {:page_id=>1, :label=>"Signature2", :rect=>[172, 108, 303, 163]}
  {:page_id=>1, :label=>"Signature6", :rect=>[528, 108, 683, 163]}
  {:page_id=>2, :label=>"Signature1", :rect=>[172, 108, 303, 163]}
  {:page_id=>2, :label=>"Signature5", :rect=>[528, 108, 683, 163]}
  {:page_id=>3, :label=>"Signature3", :rect=>[318, 166, 431, 223]}
  {:page_id=>4, :label=>"Signature4", :rect=>[318, 166, 431, 223]}
```

## sigcmp

Menerima dua file: file referensi dan file yang hendak dicek. Mencetak nama file yang dicek dan jumlah signature di file tsb. Selanjutnya jika field signature di kedua file tsb berbeda, mencetak perbedaan fieldnya.

Cara pakai:

```console
$ ./sigcmp.rb [nama-file-referensi] [nama-file-yang-dicek]
```

Contoh pemanggilan & output:

```console
$ ./sigcmp.rb 10116008_2.pdf 29018025.pdf
29018025.pdf: 7 signatures
  5 present but not expected:
    {:page_id=>1, :label=>"Signature2", :rect=>[152, 108, 322, 164]}
    {:page_id=>1, :label=>"Signature7", :rect=>[443, 101, 563, 218]}
    {:page_id=>2, :label=>"Signature1", :rect=>[152, 108, 322, 164]}
    {:page_id=>3, :label=>"Signature3", :rect=>[318, 331, 431, 387]}
    {:page_id=>4, :label=>"Signature4", :rect=>[318, 331, 431, 387]}
  4 expected but not present:
    {:page_id=>1, :label=>"Signature2", :rect=>[172, 108, 303, 163]}
    {:page_id=>2, :label=>"Signature1", :rect=>[172, 108, 303, 163]}
    {:page_id=>3, :label=>"Signature3", :rect=>[318, 166, 431, 223]}
    {:page_id=>4, :label=>"Signature4", :rect=>[318, 166, 431, 223]}
```

## sigcsv

Sama seperti sigcmp, tapi output dalam bentuk CSV dengan format baris:

```
nama-file,placeholder-prodi,[nomor-halaman,x1,y1,x2,y2]*
```

Cara pakai:

```console
$ ./sigcmp.rb [nama-file-pdf]
```

Contoh pemanggilan & output:

```console
$ ./sigcmp.rb 10116008_2.pdf
10116008_2.pdf,101,2,172,108,303,163,1,172,108,303,163,Signature3,3,318,166,431,223,4,318,166,431,223,2,528,108,683,163,1,528,108,683,163
```


Semuanya bisa pakai wildcard, contoh:

```console
$ ./sigchk.rb *.pdf

$ ./sigcmp.rb referensi.pdf *.pdf
```
