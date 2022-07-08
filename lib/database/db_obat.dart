import 'package:uas_wibi/model/crud_dataobat.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbObat {
  static final DbObat _instance = DbObat._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableDataObat';
  final String columnId = 'id';
  final String columnNamaObat = 'NamaObat';
  final String columnMerkObat = 'MerkObat';
  final String columnJenisObat = 'JenisObat';
  final String columnStockObat = 'StockObat';
  final String columnHargaObat = 'HargaObat';

  DbObat._internal();
  factory DbObat() => _instance;

  //cek apakah database ada
  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNamaObat TEXT,"
        "$columnMerkObat TEXT,"
        "$columnJenisObat TEXT,"
        "$columnHargaObat TEXT,"
        "$columnStockObat TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

  //read database
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNamaObat,
      columnMerkObat,
      columnJenisObat,
      columnHargaObat,
      columnStockObat
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, kontak.toMap(), where: '$columnId = ?', whereArgs: [kontak.id]);
  }

  //hapus database
  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}