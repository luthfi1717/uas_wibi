import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import 'package:uas_wibi/model/dataobat.dart';

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
    String path = join(databasePath, 'obat.db');

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
  Future<int?> saveObat(Obat obat) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, obat.toMap());
  }

  //read database
  Future<List?> getAllObat() async {
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
  Future<int?> updateObat(Obat obat) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, obat.toMap(), where: '$columnId = ?', whereArgs: [obat.id]);
  }

  //hapus database
  Future<int?> deleteObat(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}