Pastikan versi Ruby minimal 2.1.

## Requirement

Origami:

```
$ gem install origami
```

## sigchk

Mencetak nama file dan field signature yang ada di file tsb.

- `:page_id` adalah ID halaman di mana field tsb berada.
- `:rect` adalah bounding box field tsb.

Cara pakai:

```
$ ruby sigchk.rb <nama-file-pdf>
```

Contoh pemanggilan & output:

```
$ ruby sigchk.rb 10116008_2.pdf
10116008_2.pdf
{:page_id=>31, :rect=>[172, 108, 303, 163]}
{:page_id=>4, :rect=>[172, 108, 303, 163]}
{:page_id=>60, :rect=>[318, 166, 431, 223]}
{:page_id=>82, :rect=>[318, 166, 431, 223]}
{:page_id=>31, :rect=>[528, 108, 683, 163]}
{:page_id=>4, :rect=>[528, 108, 683, 163]}
```

## sigcmp

Menerima dua file: file referensi dan file yang hendak dicek. Jika field signature di kedua file tsb berbeda, mencetak nama file yang dicek dan perbedaan fieldnya.

Cara pakai:

```console
$ ruby sigcmp.rb <nama-file-referensi> <nama-file-yang-dicek>
```

Contoh pemanggilan & output:

```console
$ ruby sigcmp.rb 10116008_2.pdf 29318096.pdf
29318096.pdf
present but not expected:
{:page_id=>31, :rect=>[152, 108, 322, 164]}
{:page_id=>4, :rect=>[152, 108, 322, 164]}
{:page_id=>60, :rect=>[318, 306, 431, 362]}
{:page_id=>82, :rect=>[318, 306, 431, 362]}
{:page_id=>4, :rect=>[443, 101, 563, 218]}
expected but not present:
{:page_id=>31, :rect=>[172, 108, 303, 163]}
{:page_id=>4, :rect=>[172, 108, 303, 163]}
{:page_id=>60, :rect=>[318, 166, 431, 223]}
{:page_id=>82, :rect=>[318, 166, 431, 223]}
```

Keduanya bisa pakai wildcard, contoh:

```console
$ ruby sigchk.rb *.pdf

$ ruby sigcmp.rb referensi.pdf *.pdf
```
