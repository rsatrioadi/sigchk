## Requirements

- Ruby ~> 2.1
- Origami ~> 2.1

    ```console
    $ gem install origami
    ```

## sigchk

Mencetak nama file dan info tentang field signature yang ada di file tsb:

- `:page_id` adalah nomor halaman di mana field tsb berada.
- `:rect` adalah bounding box field tsb.

Cara pakai:

```console
$ ./sigchk.rb [nama-file-pdf]
```

Contoh pemanggilan & output:

```console
$ ./sigchk.rb 10116008_2.pdf
10116008_2.pdf
{:page_id=>1, :rect=>[172, 108, 303, 163]}
{:page_id=>1, :rect=>[528, 108, 683, 163]}
{:page_id=>2, :rect=>[172, 108, 303, 163]}
{:page_id=>2, :rect=>[528, 108, 683, 163]}
{:page_id=>3, :rect=>[318, 166, 431, 223]}
{:page_id=>4, :rect=>[318, 166, 431, 223]}
```

## sigcmp

Menerima dua file: file referensi dan file yang hendak dicek. Jika field signature di kedua file tsb berbeda, mencetak nama file yang dicek dan perbedaan fieldnya. Jika field signature kedua file sama persis, tidak mencetak apa-apa.

Cara pakai:

```console
$ ./sigcmp.rb [nama-file-referensi] [nama-file-yang-dicek]
```

Contoh pemanggilan & output:

```console
$ ./sigcmp.rb 10116008_2.pdf 29318096.pdf
29318096.pdf
5 present but not expected:
{:page_id=>1, :rect=>[152, 108, 322, 164]}
{:page_id=>1, :rect=>[443, 101, 563, 218]}
{:page_id=>2, :rect=>[152, 108, 322, 164]}
{:page_id=>3, :rect=>[318, 306, 431, 362]}
{:page_id=>4, :rect=>[318, 306, 431, 362]}
4 expected but not present:
{:page_id=>1, :rect=>[172, 108, 303, 163]}
{:page_id=>2, :rect=>[172, 108, 303, 163]}
{:page_id=>3, :rect=>[318, 166, 431, 223]}
{:page_id=>4, :rect=>[318, 166, 431, 223]}
```

Keduanya bisa pakai wildcard, contoh:

```console
$ ./sigchk.rb *.pdf

$ ./sigcmp.rb referensi.pdf *.pdf
```
