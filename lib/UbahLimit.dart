import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

enum Kategori {makanan, hiburan, belanja}


class UbahLimit extends StatefulWidget{
  @override
  _ubah createState(){
    return new _ubah();
  }
}
class _ubah extends State<UbahLimit>{
  Kategori _kat = Kategori.makanan;
  String dropdownValue = 'makanan';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(0, 149, 218, 1),
          title: Text("Ubah Limit"),
        ),
        body: new Container(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0, right: 25.0, left: 15.0),
            child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Pilih Kategori :   ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['makanan','hiburan','belanja']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Jumlah (Rp) : ',
                    hintText: '100000',

                  ),
                  controller: MoneyMaskedTextController(leftSymbol:'Rp. ',thousandSeparator: ',', decimalSeparator: '', precision: 0),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: RaisedButton(
                    onPressed: () {},
                    child: const Text(
                      'Ubah',
                      style: TextStyle(fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    color: Color.fromRGBO(232, 108, 0, 1),
                  ),
                )

//              ListTile(
//                title: const Text('Makanan'),
//                leading: Radio(
//                  value: Kategori.makanan,
//                  groupValue: _kat,
//                  onChanged: (Kategori value) {
//                    setState(() { _kat = value; });
//                  },
//                ),
//              ),
//              ListTile(
//                title: const Text('Hiburan'),
//                leading: Radio(
//                  value: Kategori.hiburan,
//                  groupValue: _kat,
//                  onChanged: (Kategori value) {
//                    setState(() { _kat = value; });
//                  },
//                ),
//              ),
//              ListTile(
//                title: const Text('Belanja'),
//                leading: Radio(
//                  value: Kategori.belanja,
//                  groupValue: _kat,
//                  onChanged: (Kategori value) {
//                    setState(() { _kat = value; });
//                  },
//                ),
//              ),
              ],
            ),
          )
        )
    );
  }
}