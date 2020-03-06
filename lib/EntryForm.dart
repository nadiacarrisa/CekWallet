import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class EntryForm extends StatefulWidget {
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Pemasukan'),
          backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
          child: ListView(
            children: <Widget> [

              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Pemasukan',
                    icon: Icon(Icons.mode_edit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  controller: MoneyMaskedTextController(leftSymbol: 'Rp ', thousandSeparator: '.', precision: 0,decimalSeparator: ''),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Jumlah',
                    icon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              // tombol button
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: Row(
                  children: <Widget> [
                    // tombol simpan
                    Expanded(
                      child: Material(
                        elevation: 1.0,
                        borderRadius: BorderRadius.circular(100.0),
                        color: Color.fromRGBO(232, 108, 0, 1),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                          child: Text('SIMPAN',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}