import 'package:flutter/material.dart';
import 'package:money_management/services/PinService.dart';

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
    List get = new List();
    get = await dbPin.lihatPin();
    get.forEach(
        (pin){
          datapin=pin['pin'];
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
          Row(
            children: <Widget>[
              Text('PIN ada Sekarang : '),
              Text(datapin),
              IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: (){
                  lihat();
                },
              )
            ],
          ),
          Text('Ubah Pin'),
          TextFormField(
            keyboardType: TextInputType.number,
          ),
          RaisedButton(
            child: Text('Ubah Pin'),
            onPressed: (){},
          )
        ],
      ),
    );
  }

}