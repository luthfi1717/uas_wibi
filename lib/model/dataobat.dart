class Obat{
  int? id;
  String? NamaObat;
  String? MerkObat;
  String? JenisObat;
  String? StockObat;
  String? HargaObat;

  Obat({this.id, this.NamaObat, this.MerkObat, this.JenisObat, this.StockObat, this.HargaObat});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['namaobat'] = NamaObat;
    map['merkobat'] =MerkObat;
    map['jenisobat'] = JenisObat;
    map['stockobat'] = StockObat;
    map['hargaobat'] = HargaObat;

    return map;
  }

  Obat.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.NamaObat = map['NamaObat'];
    this.MerkObat = map['MerkObat'];
    this.JenisObat = map['JenisObat'];
    this.StockObat = map['StockObat'];
    this.HargaObat = map['HargaObat'];
  }
}