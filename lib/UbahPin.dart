import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_management/services/PinService.dart';
import 'models/Pin.dart';
Codec<String, String> stringToBase64 = utf8.fuse(base64);
class UbahPin extends StatefulWidget{
  @override
  _ubahPin createState(){
    return new _ubahPin();
  }
}
class _ubahPin extends State<UbahPin>{
  PinCon dbPin = new PinCon();
  String datapin="* * * *";
  TextEditingController pinController = TextEditingController();

  void getPin() async{
    String datapintamp;
    List get = new List();
    get = await dbPin.lihatPin();
    get.forEach(
        (pin){
          datapintamp=pin['pin'];
          datapin =stringToBase64.decode(datapintamp);
        }
    );
  }

  @override
  void initState() {
    super.initState();
    getPin();
  }

  void lihat(){
    setState(
        (){
          getPin();
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Pin'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Text('PIN ada Sekarang : ', style: TextStyle(fontSize: 20),),
                Text(datapin, style: TextStyle(fontSize: 20),),
              ]
            ),
            trailing: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: (){
                  lihat();
                },
              ),
          ),
          Text('Ubah Pin', style: TextStyle(fontSize: 20)),
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
                  'Ubah Pin',
                  style:
                  TextStyle(fontSize: 13.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  showAlertDialog_GAGAL(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil('/ubahpin', ModalRoute.withName('/setting')); },
    );
    AlertDialog alert = AlertDialog(
      title: Text("PIN Gagal Diubah", style: TextStyle(color: Colors.red),),
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
      title: Text("PIN Berhasil Diubah", style: TextStyle(color: Colors.green),),
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

