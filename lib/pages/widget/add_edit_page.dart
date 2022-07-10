import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/dataobat.dart';

class AddEditPage extends StatefulWidget {
  final Obat? obat;

  AddEditPage({this.obat});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
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
        text: widget.obat == null ? '' : widget.obat!.StockObat.toString());

    HargaObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.HargaObat.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  labelText: 'Nama Obat',
                  labelStyle: TextStyle(
                    color: Colors.black,
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
              controller: MerkObat,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  labelText: 'Merk Obat',
                  labelStyle: TextStyle(
                    color: Colors.black,
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
              controller: JenisObat,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  labelText: 'Jenis Obat',
                  labelStyle: TextStyle(
                    color: Colors.black,
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
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: StockObat,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  labelText: 'Stock Obat',
                  labelStyle: TextStyle(
                    color: Colors.black,
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
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: HargaObat,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.green),
                  ),
                  labelText: 'Harga Obat',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              textColor: Colors.white,
              color: Colors.green,
              child: (widget.obat == null)
                  ? Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertObat();
              },
            ),
          )
        ],
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
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveObat(Obat(
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
