import 'package:flutter/material.dart';

class Tentang extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(0, 149, 218, 1),
          title: Text("Tentang"),
        ),
        body: new Container(
            child: Padding(
                padding: EdgeInsets.only(top: 30.0, right: 25.0, left: 15.0),
                child: Column(

                  children: <Widget>[
                    Text(
                      'Aplikasi money manager'
                          '\naplikasi ini dibuat untuk memenuhi tugas pertama dalama matakuliah'
                          '\npemrograman hybrid\n\n'
                          '\nyang dibuat oleh:\n'
                          '\nWilhelmus Krisvan\t71170144'
                          '\nStephanie Nadia\t71170145'
                          '\nHandi Hermawan\t71170146\n',
                      style: TextStyle(fontSize: 16, ),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
            )
        )
    );
  }
}