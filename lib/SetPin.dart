import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_management/services/PinService.dart';
import 'models/Pin.dart';
Codec<String, String> stringToBase64 = utf8.fuse(base64);
class SetPin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController pinController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Set Pin Anda", style: TextStyle(fontSize: 25),),
            Text("Set Pin Anda dengan ketentuan:\n- Terdiri dari 4 Angka"),
            TextFormField(
              controller: pinController,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Material(
                elevation: 1.0,
                borderRadius: BorderRadius.circular(100.0),
                color: Color.fromRGBO(232, 108, 0, 1),
                child: MaterialButton(
                  onPressed: (){
                    if(pinController.text.length==4){
                      String tamp = stringToBase64.encode(pinController.text);
                      Pin p = new Pin(pin: tamp);
                      PinCon dbPin = new PinCon();
                      dbPin.update(p);
                      print(pinController.text);
                      showAlertDialog_Berhasil(context);
                    }
                    else{
                      showAlertDialog_GAGAL(context);
                    }
                  },
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: Text(
                    'Set Pin',
                    style:
                    TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  showAlertDialog_GAGAL(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil('/setpin', ModalRoute.withName('/')); },
    );
    AlertDialog alert = AlertDialog(
      title: Text("PIN Gagal Di set", style: TextStyle(color: Colors.red),),
      content: Text("PIN harus terdiri dari 4 angka!"),
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

  showAlertDialog_Berhasil(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil('/main', ModalRoute.withName('/')); },
    );
    AlertDialog alert = AlertDialog(
      title: Text("PIN Berhasil Di set", style: TextStyle(color: Colors.green),),
      content: Text("Pin anda telah berhasil diubah!"),
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