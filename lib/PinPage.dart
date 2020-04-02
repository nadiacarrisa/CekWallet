import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_management/services/PinService.dart';
Codec<String, String> stringToBase64 = utf8.fuse(base64);
class Pin extends StatefulWidget{
  @override
  _Pin createState() => _Pin();
}
class _Pin extends State<Pin>{
  Color primaryColor = Color.fromRGBO(0, 149, 218, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: primaryColor
        ),
        child: OtpScreen(),
      ),
    );
  }
}
class OtpScreen extends StatefulWidget{
  @override
  _OtpScreen createState() => _OtpScreen();
}
class _OtpScreen extends State<OtpScreen>{
  PinCon dbPin = new PinCon();
  String datapin,datapintamp;

  void getPin() async{
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

  List<String> currentPin = ["","","",""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
//    borderSide: BorderSide(color: Colors.grey),
  );
  int pinIndex =0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment(0,0.5),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buidSecurityText(),
                  SizedBox(height: 40.0,),
                  buildpinrow()
                ],
              ),
            ),
          ),
          buildNumberPad(),
        ],
      ),
    );
  }

  //Tulisan Header
  buidSecurityText() {
    return Text("Masukkan Pin anda: ",
      style: TextStyle(
        color:  Colors.white,
        fontSize: 21.0,
      ),
    );
  }

  //Kotakan putih input code dari user
  buildpinrow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController : pinOneController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController : pinTwoController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController : pinThreeController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController : pinFourController,
        )
      ],
    );
  }

  //Kotakan untuk input code / angka
  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboarNumber(
                    n:1,
                    onPressed: () {
                      pinIndexSetup("1");
                    },
                  ),
                  KeyboarNumber(
                    n:2,
                    onPressed: () {
                      pinIndexSetup("2");
                    },
                  ),
                  KeyboarNumber(
                    n:3,
                    onPressed: () {
                      pinIndexSetup("3");
                    },
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboarNumber(
                    n:4,
                    onPressed: () {
                      pinIndexSetup("4");
                    },
                  ),
                  KeyboarNumber(
                    n:5,
                    onPressed: () {
                      pinIndexSetup("5");
                    },
                  ),
                  KeyboarNumber(
                    n:6,
                    onPressed: () {
                      pinIndexSetup("6");
                    },
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeyboarNumber(
                    n:7,
                    onPressed: () {
                      pinIndexSetup("7");
                    },
                  ),
                  KeyboarNumber(
                    n:8,
                    onPressed: () {
                      pinIndexSetup("8");
                    },
                  ),
                  KeyboarNumber(
                    n:9,
                    onPressed: () {
                      pinIndexSetup("9");
                    },
                  ),

                ],
              ),Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 60,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboarNumber(
                    n:0,
                    onPressed: () {
                      pinIndexSetup("0");
                    },
                  ),
                  Container(
                    width: 60,
                    child: MaterialButton(
                      onPressed: () {
                        clearPin();
                      },
                      child: Icon(Icons.backspace),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //menentukan index, dan validasi
  void pinIndexSetup(String s) {
    if(pinIndex==0){
      pinIndex=1;
    }
    else if(pinIndex<4){
      pinIndex+=1;
    }
    setPin(pinIndex,s);
    currentPin[pinIndex-1] = s;
    String strPin="";
    currentPin.forEach((e){
      strPin+=e;
    });
    if(pinIndex==4){ //validasi
      if(strPin==datapin){
        print(strPin);
        print(datapin);
        Navigator.of(context).pushNamedAndRemoveUntil('/main', ModalRoute.withName('/'));
      }
      else{
        print(strPin);
        Navigator.of(context).pushNamed('/pin');
      }
    }
  }

  //set text field / pin num
  setPin(int n, String text){
    switch(n){
      case 1:
        pinOneController.text=text;
        break;
      case 2:
        pinTwoController.text=text;
        break;
      case 3:
        pinThreeController.text=text;
        break;
      case 4:
        pinFourController.text=text;
        break;
    }
  }

  //clear inputan pin
  clearPin(){
    if(pinIndex==0){
      pinIndex=0;
    }
    else if(pinIndex==4){
      setPin(pinIndex, "");
      currentPin[pinIndex-1]="";
      pinIndex--;
    }
    else{
      setPin(pinIndex, "");
      currentPin[pinIndex-1]="";
      pinIndex--;
    }
  }
}

class KeyboarNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboarNumber({this.n, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightBlueAccent.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        height: 90,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}

class PinNumber extends StatelessWidget{
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PinNumber({this.textEditingController, this.outlineInputBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            border: outlineInputBorder,
            filled: true,
            fillColor: Colors.white
        ),
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
    );
  }

}

