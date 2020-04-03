import 'package:money_management/models/History.dart';
import 'package:money_management/services/DBlite.dart';
import 'package:sqflite/sqlite_api.dart';

class HistoryCon extends DBLite {
  History history;

  //default constructor >> biar ga error :V
  HistoryCon() : super.second();

  //bisa menggunakan db.raw : untuk butuh parameter query tertentu atau db.(EXEKUSINYA) untuk memasukkan semua record tanpa parameter4

  Future<int> insertHistory(History his) async {
    Database db = await this.initDb();
    final sql = '''INSERT INTO ${DBLite.HISTORY_TABLE}
    (
      ${DBLite.KATEGORI},
      ${DBLite.JUMLAH},
      ${DBLite.DATE},
      ${DBLite.DESKRIPSI},
      ${DBLite.TAG},
      ${DBLite.MONTHYEAR}
    )
    VALUES (?,?,?,?,?,?)''';
    List<dynamic> params = [his.kategori, his.jumlah, his.date, his.deskripsi, his.tag, his.bulanTahun];
    final result = await db.rawInsert(sql, params);
    await db.close();
    return result;
  }

  Future<int> updateHistory(History his) async {
    Database db = await this.initDb();
    final sql = '''UPDATE ${DBLite.HISTORY_TABLE}
    SET ${DBLite.DESKRIPSI} = ?, ${DBLite.JUMLAH} = ?, ${DBLite.KATEGORI} = ?, ${DBLite.TAG} = ?, ${DBLite.DATE} = ?, ${DBLite.MONTHYEAR} = ?
    WHERE ${DBLite.ID} = ?
    ''';
    List<dynamic> params = [his.deskripsi, his.jumlah, his.kategori, his.tag, his.date, his.bulanTahun, his.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> deleteHistory(History his) async {
    Database db = await this.initDb();
    final sql = '''DELETE FROM ${DBLite.HISTORY_TABLE}
    WHERE ${DBLite.ID} = ?
    ''';
    List<dynamic> params = [his.id];
    final result = await db.rawDelete(sql, params);
    await db.close();
    return result;
  }

  Future<List> getHistoryList(int jumlah) async {
    Database db = await this.initDb();
    final sql = 'SELECT * FROM ${DBLite.HISTORY_TABLE} ORDER BY id DESC LIMIT ?';
    List<dynamic> params = [jumlah];
    final data = await db.rawQuery(sql, params);
    return data.toList();
  }

  Future<List> getAllHistoryList() async {
    Database db = await this.initDb();
    final sql = 'SELECT * FROM ${DBLite.HISTORY_TABLE} ORDER BY id DESC';
    final data = await db.rawQuery(sql);
    return data.toList();
  }

  Future<List> getAllHistoryListByName(String name) async {
    Database db = await this.initDb();
    final sql = 'SELECT * FROM ${DBLite.HISTORY_TABLE} where kategori = "$name" ORDER BY id DESC';
    final data = await db.rawQuery(sql);
    return data.toList();
  }
}