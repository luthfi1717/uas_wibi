import 'package:flutter/material.dart';

import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/dataobat.dart';
import 'package:uas_wibi/pages/kasir_page.dart';

class DetailPage extends StatefulWidget {
  final Obat? obat;

  DetailPage({this.obat});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DbObat db = DbObat();

  TextEditingController? NamaObat;
  TextEditingController? MerkObat;
  TextEditingController? JenisObat;
  TextEditingController? StockObat;
  TextEditingController? HargaObat;

  @override
  void initState() {
    NamaObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.NamaObat);

    MerkObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.MerkObat);

    JenisObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.JenisObat);

    StockObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.StockObat);

    HargaObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.HargaObat);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Detail Data Obat',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              enabled: false,
              controller: NamaObat,
              decoration: InputDecoration(
                  labelText: 'Nama Obat',
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xff00aec4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              enabled: false,
              controller: MerkObat,
              decoration: InputDecoration(
                  labelText: 'Merk Obat',
                  icon: Icon(
                    Icons.approval_outlined,
                    color: Color(0xff00aec4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              enabled: false,
              controller: JenisObat,
              decoration: InputDecoration(
                  labelText: 'Jenis Obat',
                  icon: Icon(
                    Icons.location_city_outlined,
                    color: Color(0xff00aec4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              children: [
                Flexible(
                    child: TextField(
                      enabled: false,
                      controller: StockObat,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.storage,
                            color: Color(0xff00aec4),
                          )),
                    ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              enabled: false,
              controller: StockObat,
              decoration: InputDecoration(
                  labelText: 'Stock Obat',
                  icon: Icon(
                    Icons.call,
                    color: Color(0xff00aec4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              enabled: false,
              controller: HargaObat,
              decoration: InputDecoration(
                  labelText: 'Harga Obat',
                  icon: Icon(
                    Icons.email_outlined,
                    color: Color(0xff00aec4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Pesan Sekarang'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.green,
        onPressed: () {
          //membuat dialog konfirmasi hapus
          AlertDialog hapus = AlertDialog(
            title: Text("Information"),
            content: Container(
              height: 100,
              child: Column(
                children: [
                  Text(
                      "Yakin ingin Menghapus Data$HargaObat"
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Ya"),
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => KasirMenuPage()));
                  },
              ),
              TextButton(
                  child: Text('Tidak'),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => KasirMenuPage()));
                  },
              ),
            ],
          );
          showDialog(context: context, builder: (context) => hapus);
        },
      ),
    );
  }

  Future<void> upsertObat() async {
    if (widget.obat != null) {
      //update
      await db.updateObat(Obat.fromMap({
        'id': widget.obat!.id,
        'NamaObat': NamaObat!.text,
        'MerkObat': MerkObat!.text,
        'JenisObat': JenisObat!.text,
        'StockObat': StockObat!.text,
        'HargaObat': HargaObat!.text,
      }));
      Navigator.pop(context, 'back');
    }
  }
}
