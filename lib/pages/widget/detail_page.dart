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
        padding: EdgeInsets.all(20.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.medication,
                  color: Colors.green,
                ),
                SizedBox(width: 10),
                Text("Nama Obat :", style: TextStyle(fontSize: 18)),
                SizedBox(width: 10),
                Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: NamaObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                ),
              ],
            )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_library,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Merk Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: MerkObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.switch_camera,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Jenis Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: JenisObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Stock Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: StockObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Harga Obat :  Rp.", style: TextStyle(fontSize: 18)),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: HargaObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
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
            title: Center(child: Text("Pembelian", style: TextStyle(fontWeight: FontWeight.bold))),
            content: Container(
              height: 275,
              child: Column(
                children:<Widget>[
                  Text(
                      "Apakah anda yakin ingin membeli item ini?"
                  ),
                  SizedBox(height: 40),
                  Text(
                      "Keterangan barang yang di beli : ", style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nama Obat :", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          style: TextStyle(fontSize: 16.0),
                          enabled: false,
                          controller: NamaObat,
                          decoration: InputDecoration(
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Harga Obat :  Rp.", style: TextStyle(fontSize: 16)),
                      Flexible(
                        child: TextField(
                          style: TextStyle(fontSize: 16.0),
                          enabled: false,
                          controller: HargaObat,
                          decoration: InputDecoration(
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Jumlah :  1", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Ya", style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => KasirMenuPage()));
                  },
              ),
              TextButton(
                  child: Text('Tidak', style: TextStyle(fontSize: 16, color: Colors.green,  fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pop(context);
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
