import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        title: Text("Setting"),
      ),
      body: new Container(
            child: ListView(
              children: <Widget>[
                Card(
                  child:ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text("Ubah Limit"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){Navigator.pushNamed(context, '/ubahlimit');},
                  ),
                ),
                Card(
                  child:ListTile(
                    leading: Icon(Icons.lock),
                    title: Text("Ubah PIN"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){},
                  ),
                ),
                Card(
                  child:ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Keuntungan Aplikasi"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){Navigator.pushNamed(context, '/keuntungan');},
                  ),
                ),
                Card(
                  child:ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Tentang"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){Navigator.pushNamed(context, '/tentang');},
                  ),
                ),

              ],
            )
      ),
    );
  }
}

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

class Keuntungan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(0, 149, 218, 1),
          title: Text("Keuntungan Aplikasi"),
        ),
        body: new Container(
            child: Padding(
                padding: EdgeInsets.only(top: 30.0, right: 25.0, left: 15.0),
                child: Column(

                  children: <Widget>[
                    Text(
                      'Aplikasi money manager\n',
                      style: TextStyle(fontSize: 16, ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                          'Dengan menggunakan aplikasi ini, kamu akan mendapatkan keuntungan:\n'
                          '\n1. Mencatat pengeluaran dan pemasukan'
                          '\n2. Atur keuangan dengan mudah'
                          '\n3. Terdapat 3 kategori yang umum yang simple'
                          '\n4. Mudah di gunakan'
                          '\n5. Memiliki tampilan yang menarik',
                      style: TextStyle(fontSize: 16, ),
                      textAlign: TextAlign.start,
                    )
                  ],
                )
            )
        )
    );
  }
}