import 'package:flutter/material.dart';

import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/dataobat.dart';
import 'package:uas_wibi/pages/kasir_page.dart';
import 'package:uas_wibi/pages/widget/detail_page_gudang.dart';
import 'package:uas_wibi/pages/widget/add_edit_page.dart';


class GudangMenuPage extends StatefulWidget {
  const GudangMenuPage({Key? key}) : super(key: key);

  @override
  _GudangMenuPageState createState() => _GudangMenuPageState();
}

class _GudangMenuPageState extends State<GudangMenuPage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const GudangPage(), "title": "Screen A Title"},
    {"screen": const KasirPage(), "title": "Screen B Title"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: "Gudang"),
          BottomNavigationBarItem(icon: Icon(Icons.calculate_sharp), label: "Kasir")
        ],
      ),
    );
  }
}

class GudangPage extends StatefulWidget {
  const GudangPage({Key? key}) : super(key: key);

  @override
  GudangPageState createState() => GudangPageState();
}

class GudangPageState extends State<GudangPage> {
  List<Obat> listObat = [];
  DbObat db = DbObat();

  @override
  void initState() {
    _getAllObat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.green,
          title: const Text(
            'Gudang Obat',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      body: ListView.builder(
          itemCount: listObat.length,
          itemBuilder: (context, index) {
            Obat obat = listObat[index];
            return Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ListTile(
                    leading: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[ Icon(
                          Icons.medical_services_outlined,
                          size: 50,
                        )
                        ]
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text("Nama Obat: ${obat.NamaObat}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text("Merk Obat: ${obat.MerkObat}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text("Harga : Rp.${obat.HargaObat}"),
                        ),
                      ],
                    ),
                    trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:<Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // button edit
                                IconButton(
                                  onPressed: () {
                                    _openFormEdit(obat);
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: (){
                                    //membuat dialog konfirmasi hapus
                                    AlertDialog hapus = AlertDialog(
                                      title: Text("Informasi"),
                                      content: Container(
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Text(
                                                "Yakin ingin Menghapus Data data ini?"
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              _deleteObat(obat, index);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Ya", style: TextStyle(fontSize: 16, color: Colors.green,  fontWeight: FontWeight.bold))
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
                                IconButton(
                                  onPressed: () {
                                    _openFormLook(obat);
                                  },
                                  icon: Icon(Icons.visibility),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 50.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Obat
  Future<void> _getAllObat() async {
    var list = await db.getAllObat();
    setState(() {
      listObat.clear();
      list!.forEach((obat) {
        listObat.add(Obat.fromMap(obat));
      });
    });
  }

  Future<void> _deleteObat(Obat obat, int position) async {
    await db.deleteObat(obat.id!);
    setState(() {
      listObat.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddEditPage()));
    if (result == 'save') {
      await _getAllObat();
    }
  }

  Future<void> _openFormEdit(Obat obat) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddEditPage(obat: obat)));
    if (result == 'update') {
      await _getAllObat();
    }
  }

  Future<void> _openFormLook(Obat obat) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPageGudang(obat: obat)));
    if (result == 'back') {
      await _getAllObat();
    }
  }
}
