import 'package:flutter/material.dart';
// import 'package:uas_luthfi_2042401/screen/Data_Matkul.dart';

// import 'package:uas_wibi/screen/Login_Screen.dart';
import 'package:uas_wibi/edit_screen/edit_dataobat.dart';
import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/crud_dataobat.dart';
import 'package:uas_wibi/screnn/Detail_Obat.dart';


class Data_Obat extends StatefulWidget {
  const Data_Obat({Key? key}) : super(key: key);
  final appTitle = 'Data Obat';

  @override
  _Data_Obat createState() => _Data_Obat();
}

class _Data_Obat extends State<Data_Obat> {
  List<Kontak> listKontak = [];
  DbObat db = DbObat();

  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Data Obat',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Kontak kontak = listKontak[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.accessibility_new,
                  size: 50,
                ),
                title: Text('${kontak.NamaObat}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Merk Obat: ${kontak.MerkObat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Jenis Obat: ${kontak.JenisObat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Stock Obat: ${kontak.StockObat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Harga Obat: ${kontak.HargaObat}"),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(kontak);
                          },
                          icon: Icon(Icons.edit),
                          ),
                     IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${kontak.NamaObat}"
                                  )
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteKontak() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteKontak(kontak, index);
                                  },
                                  child: Text("Ya")
                              ),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                },
                              ),
                            ],
                          );
                          showDialog(context: context, builder: (context) => hapus);
                        },
                      ),
                        IconButton(
                          onPressed: () {
                            _openFormLook(kontak);
                          },
                          icon: Icon(Icons.visibility),
                          color: Color(0xff00aec4),
                          ),
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllKontak() async {
    //list menampung data dari database
    var list = await db.getAllKontak();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listKontak.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((kontak) {
        //masukan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  //menghapus data Kontak
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormKontak()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }

  Future<void> _openFormLook(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => LookKontak(kontak: kontak)));
    if (result == 'back') {
      await _getAllKontak();
    }
  }
}
