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
                    onTap: (){Navigator.pushNamed(context, '/ubahpin');},
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