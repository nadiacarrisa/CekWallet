import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/services/PinService.dart';
import 'dart:async';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    PinCon dbPin = new PinCon();
    String datapin, datapintamp;
    List get = new List();
    get = await dbPin.lihatPin();
    get.forEach((pin) {
      datapintamp = pin['pin'];
      print(datapintamp);
    });
    if (datapintamp == null) {
      Navigator.of(context).pushReplacementNamed('/setpin');
    } else
      Navigator.of(context).pushReplacementNamed('/pin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(''),
            Center(
              child: Image.asset(
                'images/wang.png',
                width: 200,
                height: 100,
              ),
            ),
            Text(
              'Copyright \u00a9 2020 by Wang\'s Team',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ],
        ));
  }
}
