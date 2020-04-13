import 'package:flutter/material.dart';

class Tentang extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        title: Text("Tentang"),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            // ini kaya bikin shape yang bisa di customize sisi nya
            clipper: CustomShapeClipper(),
            child: Container(
              height: 350,
              decoration: BoxDecoration(color: Color.fromRGBO(0, 149, 218, 1),),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Image.asset('images/wang.png', width: 300, height: 300,),
                Text(
                  'Aplikasi money manager ini dibuat\nuntuk memenuhi tugas pertama dalam\nmatakuliah pemrograman hybrid\n\n'
                      '\nyang dibuat oleh:\n'
                      '\nWilhelmus Krisvan\t71170144'
                      '\nStephanie Nadia\t71170145'
                      '\nHandi Hermawan\t71170146\n',
                  style: TextStyle(fontSize: 16, ),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 20),
            child:Text('Copyright \u00a9 2020 by Wang\'s Team',),
          )
        ],
      )
    );
  }
}
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 390.0 - 200);
    path.quadraticBezierTo(size.width / 2, 280, size.width, 390.0 - 200.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}