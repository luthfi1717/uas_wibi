import 'package:flutter/material.dart';
import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/crud_dataobat.dart';

class LookKontak extends StatefulWidget {
  final Kontak? kontak;

  LookKontak({this.kontak});

  @override
  _LookKontakState createState() => _LookKontakState();
}

class _LookKontakState extends State<LookKontak> {
  DbObat db = DbObat();

  TextEditingController? Nama;
  TextEditingController? Alamat;
  TextEditingController? Kota;
  TextEditingController? Notlp;
  TextEditingController? Email;

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
      Navigator.pop(context, 'back');
    }
  }
}
