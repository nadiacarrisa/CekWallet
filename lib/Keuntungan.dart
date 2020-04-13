import 'package:flutter/material.dart';

class Keuntungan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(0, 149, 218, 1),
          title: Text("Keuntungan Aplikasi"),
        ),
        body: new ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Keuntungan yang anda dapatkan dari", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
                    Text("Wang", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue, fontStyle: FontStyle.italic),),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(width: 400,height:0),
                            Text("Mengatur keuangan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Icon(Icons.account_balance_wallet, size: 100, color: Colors.blue,),
                            Text("Mengatur pemasukan dan pengeluaran\nanda dengan baik dan mudah", textAlign: TextAlign.center,)
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(width: 400,height:0),
                            Text("Mencatat keuangan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Icon(Icons.assignment, size: 100, color: Colors.blue,),
                            Text("Mencatat data pengeluaran dan pemasukan\nyang anda lakukan", textAlign: TextAlign.center,)
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(width: 400,height:0),
                            Text("Kategori Pilihan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Icon(Icons.equalizer, size: 100, color: Colors.blue,),
                            Text("Memiliki 3 Kategori yang sangat umum\nseperti makan, belanja, dan hiburan", textAlign: TextAlign.center,)
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(width: 400,height:0),
                            Text("Mudah di gunakan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Icon(Icons.person, size: 100, color: Colors.blue,),
                            Text("Mudah di gunakan oleh segala kalangan\nseperti anak muda, dan orang tua", textAlign: TextAlign.center,)
                          ],
                        ),
                      )
                    ),
                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Container(width: 400,height:0),
                              Text("Aman dan Rahasia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Icon(Icons.lock, size: 100, color: Colors.blue,),
                              Text("Sangat aman, karena di menggunakan pin\nagar tidak sembarangan orang melihat data anda", textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              )
            )
          ],
        )
    );
  }
}