import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'models/Limit.dart';
import 'services/LimitService.dart';

enum Kategori { makanan, hiburan, belanja }

class UbahLimit extends StatefulWidget {
  @override
  _ubah createState() {
    return new _ubah();
  }
}

class _ubah extends State<UbahLimit> {
  TextEditingController jumlahlimit = MoneyMaskedTextController(
      initialValue: 0,
      thousandSeparator: '',
      precision: 0,
      decimalSeparator: '');
  Kategori _kat = Kategori.makanan;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        title: Text("Ubah Limit"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, right: 25.0, left: 15.0),
          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Pilih Kategori :',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  DropdownButton<String>(
                    iconSize: 24,
                    hint: Text('Kategori'),
                    value: dropdownValue,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Makanan',
                      'Hiburan',
                      'Belanja',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              TextFormField(
                controller: jumlahlimit,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah (Rp)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Color.fromRGBO(232, 108, 0, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        onPressed: () {
                          int jumlah = int.parse(jumlahlimit.text);
                          if (jumlah == 0 && dropdownValue == '') {
                            showAlertDialog_Fail(context,
                                'Silahkan isi minimal limit dan pilih kategori!');
                          } else if (jumlah == 0) {
                            showAlertDialog_Fail(
                                context, 'Silahkan isi minimal limit!');
                          } else if (dropdownValue == '') {
                            showAlertDialog_Fail(
                                context, 'Silahkan isi pilih kategori!');
                          } else {
                            Limit l =
                                Limit(kategori: dropdownValue, jumlah: jumlah);
                            LimitCon dbhelp = new LimitCon();
                            dbhelp.updateLimit(l);
                            showAlertDialog_Berhasil(context, l);
                          }
                        },
                        child: Text(
                          'Ubah limit',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog_Berhasil(BuildContext context, Limit l) {
    String kat = l.kategori;
    int jum = l.jumlah;
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', ModalRoute.withName('/'));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Limit Berhasil Diubah",
        style: TextStyle(color: Colors.green),
      ),
      content: Text(
          "Limit anda telah berhasil diubah!\nJangan boros-boros ya jangan melebihi Rp." +
              jum.toString() +
              " di kategori " +
              kat),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog_Fail(BuildContext context, String msg) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Perhatian!",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
        msg,
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
