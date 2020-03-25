import 'package:money_management/models/Pin.dart';
import 'package:money_management/services/DBlite.dart';
import 'package:sqflite/sqlite_api.dart';

class PinCon extends DBLite{
  Pin pin;
  PinCon() : super.second();

  Future<int> update(Pin p) async{
    Database db = await this.initDb();
    final sql = '''UPDATE ${DBLite.PIN_TABLE}
    SET ${DBLite.PIN} = ?
    WHERE ${DBLite.ID_LIMIT} = '1'
    ''';
    List<dynamic> params = [p.pin];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<List> lihatPin() async{
    Database db = await this.initDb();
    final sql = "SELECT pin FROM pincode where id = 1";
    var result = await db.rawQuery(sql);
    return result;
  }
}