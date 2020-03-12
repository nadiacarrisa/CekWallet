import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'models/Kategori.dart';

class DBLite {

  static DBLite _dbHelper;
  static Database _database;

  DBLite._createObject();

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
    await db.execute(
        'CREATE TABLE history ( id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT, jumlah INTEGER, date TEXT, deskripsi TEXT, tag TEXT);'
            'CREATE TABLE limit ( id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT, jumlah INTEGER);'
            'CREATE TABLE saldo ( id INTEGER PRIMARY KEY AUTOINCREMENT, jumlah INTEGER);');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }


  static const hisTable = 'history';
  static const id = 'id';
  static const kat = 'kategori';
  static const jml = 'jumlah';
  static const date = 'date';
  static const desk = 'deskripsi';
  static const tag = 'tag';

//bisa menggunakan db.raw : untuk butuh parameter query tertentu atau db.(EXEKUSINYA) untuk memasukkan semua record tanpa parameter

  Future<int> insertHistory(Kategori his) async {
    Database db = await this.initDb();
    final sql = '''INSERT INTO ${hisTable}
    (
      ${kat},
      ${jml},
      ${date},
      ${desk},
      ${tag}
    )
    VALUES (?,?,?,?,?)''';
    List<dynamic> params = [his.kategori, his.jumlah, his.tanggal, his.deskripsi, his.tag];
    final result = await db.rawInsert(sql, params);
    await db.close();
    return result;
  }

  Future<int> updateHistory(Kategori his) async {
    Database db = await this.initDb();
    final sql = '''UPDATE ${hisTable}
    SET ${his.deskripsi} = ?, ${his.jumlah} = ?, ${his.tanggal} = ?
    WHERE ${his.id} = ?
    ''';
    List<dynamic> params = [his.deskripsi, his.jumlah, his.tanggal,his.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> deleteHistory(Kategori his) async {
    Database db = await this.initDb();
    final sql = '''DELETE FROM ${hisTable}
    WHERE ${his.id} = ?
    ''';
    List<dynamic> params = [his.id];
    final result = await db.rawDelete(sql, params);
    await db.close();
    return result;
  }

//untuk select bisa di edit dari sini untuk get beberapa atribut dgn ketentuan tertentu...
//yg dibawah HANYA CONTOH untuk MENGAMBIL SEMUA DATA DI TABEL HISTORY
//UNTUK PEMBUATAN LIST CARD YANG DIAMBIL DAR DATABASE: https://medium.com/komandro-ccit-ftui/tutorial-flutter-todo-list-dengan-sqlite-ffc2fa68f1e6
  Future<List<Kategori>> getHistoryList() async {
    Database db = await this.initDb();
    final sql = '''SELECT * FROM ${hisTable}''';
    final data = await db.rawQuery(sql);
    List<Kategori> kat = List();
    for (final node in data) {
      final todo = Kategori.fromMap(node);
      kat.add(todo);
    }
    return kat;
  }
  
  Future<List> calculateTotalPemasukan() async{
    Database db = await this.initDb();
    var result = await db.rawQuery("SELECT SUM(jumlah) as Total FROM history WHERE tag='0'");
    print(result.toList());
    return result.toList();
  }

  Future<List> calculateTotalPengeluaran() async{
    Database db = await this.initDb();
    var result = await db.rawQuery("SELECT SUM(jumlah) as Total FROM history WHERE tag='1'");
    print(result.toList());
    return result.toList();
  }

}