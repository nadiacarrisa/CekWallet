import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/History.dart';

class DBLite{
  static DBLite _dbHelper;
  static Database _database;

  static const HISTORY_TABLE = 'history';
  static const ID = 'id';
  static const KATEGORI = 'kategori';
  static const JUMLAH = 'jumlah';
  static const DATE = 'date';
  static const DESKRIPSI = 'deskripsi';
  static const TAG = 'tag';
  static const MONTHYEAR = 'monthYear';

  static const LIMIT_TABLE = 'batas';
  static const ID_LIMIT = 'id';
  static const KATEGORI_LIMIT = 'kategori';
  static const JUMLAH_LIMIT = 'jumlah';

  static const PIN_TABLE = 'pincode';
  static const ID_PIN = 'id';
  static const PIN = 'pin';

  DBLite._createObject();

  //default constructor, karena ada constructor kedua yaitu factory DBLite()
  DBLite.second();

  //constructor untuk create dbhelper untuk koneksi ke db
  factory DBLite() {
    if (_dbHelper == null) {
      _dbHelper = DBLite._createObject();
    }
    return _dbHelper;
  }

  //future itu “tipe data” yang terpanggil dengan adanya delay atau “keterlambatan”, sistem akan terus menjalankan method tersebut sampai method itu selesai berjalan
  //async itu untuk menunggu fungsi yg terpanggil sehingga tidak terjadi blocking
  //await (method yg ditndai) harus menunggu hingga syntax/fungsi selesai
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'cekwallet.db';
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('CREATE TABLE history ( id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT, jumlah INTEGER, date TEXT, deskripsi TEXT, tag TEXT, monthYear TEXT);');
    batch.execute('CREATE TABLE batas ( id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT, jumlah INTEGER);');
    batch.execute('CREATE TABLE saldo ( id INTEGER PRIMARY KEY AUTOINCREMENT, jumlah INTEGER);');
    batch.execute('CREATE TABLE pincode(id INTEGER PRIMARY KEY AUTOINCREMENT, pin TEXT);');
    batch.execute('INSERT INTO pincode(pin) VALUES(null);');
    batch.execute('INSERT INTO batas(id,kategori,jumlah) VALUES(1,"Makanan",0);');
    batch.execute('INSERT INTO batas(id,kategori,jumlah) VALUES(2,"Belanja",0);');
    batch.execute('INSERT INTO batas(id,kategori,jumlah) VALUES(3,"Hiburan",0);');
    List<dynamic> res = await batch.commit();
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List> calculateTotalPemasukan() async{
    Database db = await this.initDb();

    var result = await db.rawQuery("SELECT SUM(jumlah) as Total FROM history WHERE tag='+'");
//    print(result.toList());
//    db.close();
    await db.close();
    return result;
  }

  Future<List> calculateTotalPengeluaran() async{
    Database db = await this.initDb();
    var result = await db.rawQuery("SELECT SUM(jumlah) as Total FROM history WHERE tag='-'");
//    print(result.toList());
    await db.close();
    return result.toList();
  }

  Future<List> checkExpense(String kategori, String bulanTahun) async{
    Database db = await this.initDb();
    var result = await db.rawQuery("SELECT SUM(jumlah) as Total FROM history WHERE monthYear='$bulanTahun' AND kategori='$kategori'");
    await db.close();
    return result;
  }
}