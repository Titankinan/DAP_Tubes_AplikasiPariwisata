program tubs;
uses crt;

const nMax = 100;

type
        fasilitas = record
        jenis : string;
        harga : real;
        objek : string;
        deskripsi : string;
end;

type
        penumpang = record
        id : integer;
        nama : string;
        gender : string;
        telp : string;
end;

type
        tiket = record
        idtiket : integer;
        asal : string;
        tujuan : string;
        jumtiket : integer;
        tabfas : fasilitas;
        tabnum : array [1..nMax] of penumpang;
        nnum : integer                          //Jumlah penumpang dalam satu tiket
end;

type
        semuatiket = record
        tabtiket : array [1..nMax] of tiket;    //Array tiket
        n : integer;                            //Jumlah tiket
end;

var
        awalnum : tiket;
        Ttiket : semuatiket;
        Ttiket2 : semuatiket;                   //untuk temp

        procedure lihattiket(T: semuatiket);
        {I.S. Terdefinisi T yang berisi array tiket dan jumlah tiket
         F.S. Menampilkan seluruh tiket yang berada di dalam array tiket sejumlah jumlah tiket}
        var
                i : integer;
        begin
                i:= 1;
                while i <= T.n do
                   begin
                        writeln();
                        writeln(i,'. Id tiket : ', T.tabtiket[i].idtiket);
                        writeln('   Asal     : ', T.tabtiket[i].asal);
                        writeln('   Tujuan   : ', T.tabtiket[i].tujuan);
                        writeln('   Jenis    : ', T.tabtiket[i].tabfas.jenis);
                        writeln('   Harga    : Rp.', T.tabtiket[i].tabfas.harga:0:2);
                        writeln('   Jumlah tiket tersedia : ', T.tabtiket[i].jumtiket);
                        writeln();
                        writeln('========================================');
                        i:= i + 1;
                   end;
        end;

        procedure lihatfas(T: semuatiket; n: integer);
        {I.S. Terdefinisi T berisi array tiket dan n adalah indeks array tiket yang dipilih
         F.S. Menampilkan fasilitas tiket dengan indeks ke n}
        begin
                writeln();
                writeln('Id tiket     : ', T.tabtiket[n].idtiket);
                writeln('Asal         : ', T.tabtiket[n].asal);
                writeln('Tujuan       : ', T.tabtiket[n].tujuan);
                writeln('Jenis        : ', T.tabtiket[n].tabfas.jenis);
                writeln('Objek wisata : ', T.tabtiket[n].tabfas.objek);
                writeln('Deskripsi    : ', T.tabtiket[n].tabfas.deskripsi);
                writeln();
                write('Tekan enter untuk kembali');
                readln();
        end;

        procedure tambahtiket(var T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Tiket dengan indeks baru terisi sejumlah jumlah tiket}
        var
                lanjut : string;
        begin
                lanjut:= 'y';
                T.n:= T.n + 1;
                while (T.n <= nMax) and (lanjut = 'y') do
                   begin
                        writeln();
                        T.tabtiket[T.n].idtiket:= T.n;
                        write('Asal   : ');
                        readln(T.tabtiket[T.n].asal);
                        write('Tujuan : ');
                        readln(T.tabtiket[T.n].tujuan);
                        write('Harga  : Rp.');
                        readln(T.tabtiket[T.n].tabfas.harga);
                        write('Jumlah tiket : ');
                        readln(T.tabtiket[T.n].jumtiket);
                        writeln();
                        writeln('========================================');
                        repeat
                                write('Lanjut menambahkan tiket (y/n)? ');
                                readln(lanjut);
                        until (lanjut = 'y') or (lanjut = 'n');
                        if lanjut = 'y' then
                                T.n:= T.n + 1;
                   end;
                writeln();
                writeln('Data tiket telah tersimpan, terimakasih');
                readln();
        end;

        procedure editfas(var T: semuatiket; n: integer);
        {I.S. Terdefinisi T berisi array tiket dan n adalah indeks array tiket yang dipilih
         F.S. Fasilitas tiket berisi fasilitas yang baru di inputkan}
        begin
                writeln();
                writeln('Id tiket     : ', T.tabtiket[n].idtiket);
                writeln('Jenis tiket  : ', T.tabtiket[n].tabfas.jenis);
                writeln('Harga tiket  : Rp.', T.tabtiket[n].tabfas.harga:0:2);
                writeln('Objek wisata : ', T.tabtiket[n].tabfas.objek);
                writeln('Deskripsi    : ', T.tabtiket[n].tabfas.deskripsi);
                writeln();
                writeln('========================================');
                writeln();
                writeln('Edit fasilitas');
                writeln();
                write('Jenis tiket  : ');
                readln(T.tabtiket[n].tabfas.jenis);
                write('Harga tiket  : Rp.');
                readln(T.tabtiket[n].tabfas.harga);
                write('Objek wisata : ');
                readln(T.tabtiket[n].tabfas.objek);
                write('Deskripsi    : ');
                readln(T.tabtiket[n].tabfas.deskripsi);
        end;

        procedure tambahfas(var T: semuatiket; n : integer);
        {I.S. Terdefinisi T berisi array tiket dan n adalah indeks array tiket yang dipilih
         F.S. Fasilitas tiket berisi fasilitas yang baru di inputkan}
        begin
                writeln();
                writeln('Tambah fasilitas');
                writeln();
                write('Jenis tiket  : ');
                readln(T.tabtiket[n].tabfas.jenis);
                write('Objek wisata : ');
                readln(T.tabtiket[n].tabfas.objek);
                write('Deskripsi    : ');
                readln(T.tabtiket[n].tabfas.deskripsi);
                writeln();
                writeln('Data fasilitas telah tersimpan, terimakasih');
                readln;
        end;

        procedure pesantiket(var T: semuatiket; n: integer);
        {I.S. Terdefinisi T berisi array tiket dan n adalah indeks array tiket yang dipilih
         F.S. Array penumpang dari tiket yang dipilih terisi}
        var
                i, j, pesen : integer;
                total : real;
        begin
                i:= 1;
                writeln();
                repeat
                        write('Jumlah tiket yang dipesan : ');
                        readln(pesen);
                        if pesen > T.tabtiket[n].jumtiket then
                                writeln('Maaf jumlah tiket yang dipesan melebihi tiket yang tersedia');
                until pesen <= T.tabtiket[n].jumtiket;
                T.tabtiket[n].jumtiket:= T.tabtiket[n].jumtiket - pesen;
                writeln();
                while i <= pesen do
                   begin
                        T.tabtiket[n].nnum:= T.tabtiket[n].nnum + 1;
                        j:= T.tabtiket[n].nnum;
                        T.tabtiket[n].tabnum[j].id:= j;
                        writeln('id tiket           : ',
                                T.tabtiket[n].idtiket, 'ABC0', T.tabtiket[n].tabnum[j].id);
                        write('Nama               : ');
                        readln(T.tabtiket[n].tabnum[j].nama);
                        repeat
                                write('Jenis kelamin(l/p) : ');
                                readln(T.tabtiket[n].tabnum[j].gender);
                        until (T.tabtiket[n].tabnum[j].gender = 'l')
                               or (T.tabtiket[n].tabnum[j].gender = 'p');
                        write('Kontak             : ');
                        readln(T.tabtiket[n].tabnum[j].telp);
                        writeln();
                        i:= i + 1;
                   end;
                total:= T.tabtiket[n].tabfas.harga * pesen;
                writeln('========================================');
                writeln();
                writeln('Total harga : Rp.', total:0:2);
                writeln('Terimakasih telah memesan tiket');
                readln();
        end;

        procedure asctarif(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Array tiket terurut secara selection sort ascending berdasarkan tarif}
        var
                tetap, min, banding : integer;
        begin
                tetap:= 1;
                while tetap <= (T.n - 1) do
                   begin
                        min:= tetap;
                        banding:= tetap + 1;
                        while banding <= T.n do
                           begin
                                if T.tabtiket[min].tabfas.harga > T.tabtiket[banding].tabfas.harga then
                                        min:= banding;
                                banding:= banding + 1;
                           end;
                        Ttiket2.tabtiket[1]:= T.tabtiket[min];
                        T.tabtiket[min]:= T.tabtiket[tetap];
                        T.tabtiket[tetap]:= Ttiket2.tabtiket[1];
                        tetap:= tetap + 1;
                   end;
                lihattiket(T);
        end;

        procedure desctarif(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Array tiket terurut secara insertion sort descending berdasarkan tarif}
        var
                pass, banding : integer;
        begin
                pass:= 1;
                while pass <= (T.n - 1) do
                   begin
                        banding:= pass + 1;
                        Ttiket2.tabtiket[1]:= T.tabtiket[banding];
                        while (banding > 1) and (Ttiket2.tabtiket[1].tabfas.harga > T.tabtiket[banding-1].tabfas.harga) do
                           begin
                                T.tabtiket[banding]:= T.tabtiket[banding-1];
                                banding:= banding - 1;
                           end;
                        T.tabtiket[banding]:= Ttiket2.tabtiket[1];
                        pass:= pass + 1;
                   end;
                lihattiket(T);
        end;

        procedure ascasal(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Array tiket terurut secara insertion sort ascending berdasarkan tempat asal}
        var
                pass, banding : integer;
        begin
                pass:= 1;
                while pass <= (T.n - 1) do
                   begin
                        banding:= pass + 1;
                        Ttiket2.tabtiket[1]:= T.tabtiket[banding];
                        while (banding > 1) and (Ttiket2.tabtiket[1].asal < T.tabtiket[banding-1].asal) do
                           begin
                                T.tabtiket[banding]:= T.tabtiket[banding-1];
                                banding:= banding - 1;
                           end;
                        T.tabtiket[banding]:= Ttiket2.tabtiket[1];
                        pass:= pass + 1;
                   end;
                lihattiket(T);
        end;

        procedure descasal(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Array tiket terurut secara selection sort descending berdasarkan tempat asal}
        var
                tetap, max, banding : integer;
        begin
                tetap:= 1;
                while tetap <= (T.n - 1) do
                   begin
                        max:= tetap;
                        banding:= tetap + 1;
                        while banding <= T.n do
                           begin
                                if T.tabtiket[max].asal < T.tabtiket[banding].asal then
                                        max:= banding;
                                banding:= banding + 1;
                           end;
                        Ttiket2.tabtiket[1]:= T.tabtiket[max];
                        T.tabtiket[max]:= T.tabtiket[tetap];
                        T.tabtiket[tetap]:= Ttiket2.tabtiket[1];
                        tetap:= tetap + 1;
                   end;
                lihattiket(T);
        end;

        procedure asctujuan(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Array tiket terurut secara insertion sort ascending berdasarkan tempat tujuan}
        var
                pass, banding : integer;
        begin
                pass:= 1;
                while pass <= (T.n - 1) do
                   begin
                        banding:= pass + 1;
                        Ttiket2.tabtiket[1]:= T.tabtiket[banding];
                        while (banding > 1) and (Ttiket2.tabtiket[1].tujuan < T.tabtiket[banding-1].tujuan) do
                           begin
                                T.tabtiket[banding]:= T.tabtiket[banding-1];
                                banding:= banding - 1;
                           end;
                        T.tabtiket[banding]:= Ttiket2.tabtiket[1];
                        pass:= pass + 1;
                   end;
                lihattiket(T);
        end;

        procedure desctujuan(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Array tiket terurut secara selection sort descending berdasarkan tempat tujuan}
        var
                tetap, max, banding : integer;
        begin
                tetap:= 1;
                while tetap <= (T.n - 1) do
                   begin
                        max:= tetap;
                        banding:= tetap + 1;
                        while banding <= T.n do
                           begin
                                if T.tabtiket[max].tujuan < T.tabtiket[banding].tujuan then
                                        max:= banding;
                                banding:= banding + 1;
                           end;
                        Ttiket2.tabtiket[1]:= T.tabtiket[max];
                        T.tabtiket[max]:= T.tabtiket[tetap];
                        T.tabtiket[tetap]:= Ttiket2.tabtiket[1];
                        tetap:= tetap + 1;
                   end;
                lihattiket(T);
        end;

        procedure cariasal(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Menampilkan semua tiket dengan tempat asal yang sama jika ditemukan}
        var
                cari : string;
                i, ketemu : integer;
        begin
                i:= 1;
                ketemu:= 0;
                write('Cari tempat asal : ');
                readln(cari);
                while i <= T.n do
                   begin
                        if cari = T.tabtiket[i].asal then
                           begin
                                ketemu:= ketemu + 1;
                                writeln();
                                writeln('Id tiket : ', T.tabtiket[i].idtiket);
                                writeln('Asal     : ', T.tabtiket[i].asal);
                                writeln('Tujuan   : ', T.tabtiket[i].tujuan);
                                writeln('Jenis    : ', T.tabtiket[i].tabfas.jenis);
                                writeln('Harga    : Rp.', T.tabtiket[i].tabfas.harga:0:2);
                                writeln('Jumlah tiket tersedia : ', T.tabtiket[i].jumtiket);
                                writeln();
                                writeln('========================================');
                           end;
                        i:= i + 1;
                   end;
                if ketemu = 0 then
                   begin
                        writeln();
                        writeln('Mohon maaf, tiket dengan tempat asal yang dicari tidak tersedia');
                   end
                else
                   begin
                        writeln();
                        writeln('Terdapat ', ketemu, ' tiket dengan tempat asal yang sama');
                   end;
                readln();
        end;

        procedure caritujuan(T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Menampilkan semua tiket dengan tempat tujuan yang sama jika ditemukan}
        var
                cari : string;
                i, ketemu : integer;
        begin
                i:= 1;
                ketemu:= 0;
                write('Cari tempat tujuan : ');
                readln(cari);
                while i <= T.n do
                   begin
                        if cari = T.tabtiket[i].tujuan then
                           begin
                                ketemu:= ketemu + 1;
                                writeln();
                                writeln('Id tiket : ', T.tabtiket[i].idtiket);
                                writeln('Asal     : ', T.tabtiket[i].asal);
                                writeln('Tujuan   : ', T.tabtiket[i].tujuan);
                                writeln('Jenis    : ', T.tabtiket[i].tabfas.jenis);
                                writeln('Harga    : Rp.', T.tabtiket[i].tabfas.harga:0:2);
                                writeln('Jumlah tiket tersedia : ', T.tabtiket[i].jumtiket);
                                writeln();
                                writeln('========================================');
                           end;
                        i:= i + 1;
                   end;
                if ketemu = 0 then
                   begin
                        writeln();
                        writeln('Mohon maaf, tiket dengan tempat tujuan yang dicari tidak tersedia');
                   end
                else
                   begin
                        writeln();
                        writeln('Terdapat ', ketemu, ' tiket dengan tempat tujuan yang sama');
                   end;
                readln;
        end;

        procedure hapustiket(var T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Indeks array tiket yang dipilih akan digeser dan jumlah tiket berkurang}
        var
                pil : integer;
        begin
                repeat
                        write('Hapus tiket nomer : ');
                        readln(pil);
                        if pil > T.n then
                                writeln('Maaf nomer tiket salah');
                until pil <= T.n;
                while pil < (T.n + 1) do
                   begin
                        T.tabtiket[pil]:= T.tabtiket[pil+1];
                        pil:= pil + 1;
                   end;
                T.n:= T.n - 1;
                writeln('Data tiket telah terhapus, terimakasih');
                readln;
        end;

        procedure pilihanmenu(var T: semuatiket; pil : string);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket dan pil adalah pilihan menu
         F.S. Menjalankan submenu sesuai pil dan kembali ke menu utama}
        var
                jawab : integer;
        begin
                if pil = '1' then
                   begin
                        clrscr;
                        writeln('Menu utama >> Tambah tiket');
                        tambahtiket(Ttiket);
                   end;
                if (pil <> '1') and (T.n = 0) then
                   begin
                        clrscr;
                        writeln('Mohon maaf data belum tersedia');
                        readln();
                   end
                else
                   begin
                        if pil = '2' then
                           begin
                                clrscr;
                                writeln('Menu utama >> Tambah fasilitas');
                                lihattiket(Ttiket);
                                repeat
                                        writeln();
                                        write('pilih tiket yang akan ditambahkan fasilitas : ');
                                        readln(jawab);
                                until (jawab > 0) and (jawab <= T.n);
                                clrscr;
                                writeln('Menu utama >> Tambahfasilitas >> tiket ke-',jawab);
                                tambahfas(Ttiket, jawab);
                           end
                        else if pil = '3' then
                           begin
                                clrscr;
                                writeln('Menu utama >> Lihat fasilitas');
                                lihattiket(Ttiket);
                                repeat
                                        writeln();
                                        write('pilih tiket yang akan dilihat : ');
                                        readln(jawab);
                                until (jawab > 0) and (jawab <= T.n);
                                clrscr;
                                writeln('Menu utama >> Lihat fasilitas >> Tiket ke-', jawab);
                                lihatfas(Ttiket, jawab);
                           end
                        else if pil = '4' then
                           begin
                                clrscr;
                                writeln('Menu utama >> Booking tiket');
                                lihattiket(Ttiket);
                                repeat
                                        writeln();
                                        write('pilih tiket yang akan di booking : ');
                                        readln(jawab);
                                until (jawab > 0) and (jawab <= T.n);
                                clrscr;
                                writeln('Menu utama >> Booking tiket >> Isi identitas');
                                pesantiket(Ttiket, jawab);
                           end
                        else if pil = '5' then
                           begin
                                repeat
                                        clrscr;
                                        writeln('Menu utama >> Urutkan tiket');
                                        writeln();
                                        writeln('Urutkan tiket berdasarkan : ');
                                        writeln('1. Tarif terendah');
                                        writeln('2. Tarif tertinggi');
                                        writeln('3. Asal (A-Z)');
                                        writeln('4. Asal (Z-A)');
                                        writeln('5. Tujuan (A-Z)');
                                        writeln('6. Tujuan (Z-A)');
                                        writeln('7. Kembali ke menu utama');
                                        writeln();
                                        repeat
                                                write('pilih pengurutan : ');
                                                readln(jawab);
                                        until (jawab = 1) or (jawab = 2) or (jawab = 3) or
                                              (jawab = 4) or (jawab = 5) or (jawab = 6) or
                                              (jawab = 7);
                                        if jawab = 1 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Urutkan tiket >> Tarif terendah');
                                                asctarif(Ttiket);
                                                write('Tekan enter untuk kembali');
                                                readln();
                                           end
                                        else if jawab = 2 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Urutkan tiket >> Tarif terginggi');
                                                desctarif(Ttiket);
                                                write('Tekan enter untuk kembali');
                                                readln();
                                           end
                                        else if jawab = 3 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Urutkan tiket >> Asal (A-Z)');
                                                ascasal(Ttiket);
                                                write('Tekan enter untuk kembali');
                                                readln();
                                           end
                                        else if jawab = 4 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Urutkan tiket >> Asal (Z-A)');
                                                descasal(Ttiket);
                                                write('Tekan enter untuk kembali');
                                                readln();
                                           end
                                        else if jawab = 5 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Urutkan tiket >> Tujuan (A-Z)');
                                                asctujuan(Ttiket);
                                                write('Tekan enter untuk kembali');
                                                readln();
                                           end
                                        else if jawab = 6 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Urutkan tiket >> Tujuan (Z-A)');
                                                desctujuan(Ttiket);
                                                write('Tekan enter untuk kembali');
                                                readln();
                                           end
                                        else if jawab = 7 then
                                                writeln();
                                until jawab = 7;
                           end
                        else if pil = '6' then
                           begin
                                repeat
                                        clrscr;
                                        writeln('Menu utama >> Cari tiket');
                                        writeln();
                                        writeln('Cari tiket berdasarkan : ');
                                        writeln('1. Asal');
                                        writeln('2. Tujuan');
                                        writeln('3. Kembali ke menu utama');
                                        writeln();
                                        repeat
                                                write('pilih : ');
                                                readln(jawab);
                                        until (jawab = 1) or (jawab = 2) or (jawab = 3);
                                        if jawab = 1 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Cari tiket >> Berdasarkan asal');
                                                writeln();
                                                cariasal(Ttiket);
                                           end
                                        else if jawab = 2 then
                                           begin
                                                clrscr;
                                                writeln('Menu utama >> Cari tiket >> Berdasarkan tujuan');
                                                writeln();
                                                caritujuan(Ttiket);
                                           end
                                        else if jawab = 3 then
                                                writeln();
                                until jawab = 3;
                           end
                        else if pil = '7' then
                           begin
                                clrscr;
                                writeln('Menu utama >> Edit fasilitas');
                                lihattiket(Ttiket);
                                repeat
                                        write('pilih tiket yang akan di edit fasilitas : ');
                                        readln(jawab);
                                until (jawab > 0) and (jawab <= T.n);
                                clrscr;
                                writeln('Menu utama >> Edit fasilitas >> Tiket ke-', jawab);
                                editfas(Ttiket, jawab);
                           end
                        else if pil = '8' then
                           begin
                                clrscr;
                                writeln('Menu utama >> Hapus tiket');
                                lihattiket(Ttiket);
                                hapustiket(Ttiket);
                           end;
                   end;
        end;

        procedure menu(var T: semuatiket);
        {I.S. Terdefinisi T berisi array tiket dan jumlah tiket
         F.S. Menampilkan submenu yang tersedia}
        var
                pil : string;
        begin
                repeat
                        clrscr;
                        writeln('========================================');
                        writeln('      DEMO APLIKASI AGEN PARIWISATA     ');
                        writeln('========================================');
                        writeln();
                        writeln('Menu utama');
                        writeln();
                        writeln('1. Tambah tiket');
                        writeln('2. Tambah fasilitas');
                        writeln('3. Lihat fasilitas');
                        writeln('4. Booking tiket');
                        writeln('5. Urutkan tiket');
                        writeln('6. Cari tiket');
                        writeln('7. Edit tiket');
                        writeln('8. Hapus tiket');
                        writeln('9. Keluar');
                        writeln();
                        write('Pilihan : ');
                        readln(pil);
                until (pil = '1') or (pil = '2') or (pil = '3') or (pil = '4') or
                      (pil = '5') or (pil = '6') or (pil = '7') or (pil = '8') or
                      (pil = '9');
                if pil = '9' then
                   begin
                        clrscr;
                        writeln('================================================');
                        writeln('  Terima kasih telah menggunakan demo aplikasi');
                        writeln('================================================');
                        readln();
                   end
                else
                   begin
                        pilihanmenu(Ttiket, pil);
                        menu(Ttiket);
                   end;
        end;

begin
        //Ttiket.n:= 0;
        //awalnum.nnum:= 0;
        menu(Ttiket);

end.
