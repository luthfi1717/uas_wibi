import 'package:flutter/material.dart';
import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/crud_dataobat.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;

  FormKontak({this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  DbObat db = DbObat();

  TextEditingController? NamaObat;
  TextEditingController? MerkObat;
  TextEditingController? JenisObat;
  TextEditingController? StockObat;
  TextEditingController? HargaObat;

  @override
  void initState() {
    NamaObat = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.NamaObat);

    MerkObat = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.MerkObat);

    JenisObat = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.JenisObat);

    StockObat = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.StockObat);

    HargaObat = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.HargaObat);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Form Data Obat',
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
              controller: NamaObat,
              decoration: InputDecoration(
                  labelText: 'Nama Obat',
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
              controller: MerkObat,
              decoration: InputDecoration(
                  labelText: 'Merk Obat',
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
              controller: JenisObat,
              decoration: InputDecoration(
                  labelText: 'Jenis Obat',
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
              controller: StockObat,
              decoration: InputDecoration(
                  labelText: 'Stock Obat',
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
              controller: HargaObat,
              decoration: InputDecoration(
                  labelText: 'Harga Obat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              textColor: Colors.white,
              color: Color(0xff00aec4),
              child: (widget.kontak == null)
                  ? Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertKontak();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      //update
      await db.updateKontak(Kontak.fromMap({
        'id': widget.kontak!.id,
        'NamaObat': NamaObat!.text,
        'MerkObat': MerkObat!.text,
        'JenisObat': JenisObat!.text,
        'StockObat': StockObat!.text,
        'HargaObat': HargaObat!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveKontak(Kontak(
        NamaObat: NamaObat!.text,
        MerkObat: MerkObat!.text,
        JenisObat: JenisObat!.text,
        StockObat: StockObat!.text,
        HargaObat: HargaObat!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
