import 'package:money_management/models/Limit.dart';
import 'package:money_management/models/History.dart';
import 'package:money_management/services/DBlite.dart';
import 'package:sqflite/sqlite_api.dart';

class LimitCon extends DBLite {
  Limit limit;

  //default constructor >> biar ga error :V
  LimitCon() : super.second();

  //bisa menggunakan db.raw : untuk butuh parameter query tertentu atau db.(EXEKUSINYA) untuk memasukkan semua record tanpa parameter4

//  Future<int> insertLimit(Limit lim) async {
//    Database db = await this.initDb();
//    final sql = '''INSERT INTO ${DBLite.LIMIT_TABLE}
//    (
//      ${DBLite.KATEGORI_LIMIT},
//      ${DBLite.JUMLAH_LIMIT},
//    )
//    VALUES (?,?)''';
//    List<dynamic> params = [lim.kategori,  lim.jumlah];
//    final result = await db.rawInsert(sql, params);
//    await db.close();
//    return result;
//  }

  Future<int> updateLimit(Limit lim) async {
    Database db = await this.initDb();
    final sql = '''UPDATE ${DBLite.LIMIT_TABLE}
    SET ${DBLite.JUMLAH_LIMIT} = ?
    WHERE ${DBLite.KATEGORI_LIMIT} = ?
    ''';
    List<dynamic> params = [lim.jumlah, lim.kategori];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

//  Future<int> deleteLimit(Limit lim) async {
//    Database db = await this.initDb();
//    final sql = '''DELETE FROM ${DBLite.LIMIT_TABLE}
//    WHERE ${DBLite.ID_LIMIT} = ?
//    ''';
//    List<dynamic> params = [lim.id];
//    final result = await db.rawDelete(sql, params);
//    await db.close();
//    return result;
//  }

  Future<List> checkLimit(String kategori) async{
    Database db = await this.initDb();
    final sql = "SELECT jumlah FROM batas WHERE kategori = '$kategori'";
    var result = await db.rawQuery(sql);
    return result;
  }

}