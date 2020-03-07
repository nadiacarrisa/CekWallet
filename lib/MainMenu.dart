import 'package:flutter/material.dart';
import 'ExpenseForm.dart';
import 'EntryForm.dart';
import 'dart:async';
import 'models/Kategori.dart';
import 'DBlite.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  DBLite dbHelper = new DBLite();
  int _total;
  int masuk, keluar;
  List totalList;
  void calTot() async{
    totalList = await dbHelper.calculateTotalPemasukan();
    totalList.forEach((harga){masuk = harga['Total'];});
    //var total2 = (await dbHelper.calculateTotal2())[0]['Total'];
    totalList = await dbHelper.calculateTotalPengeluaran();
    totalList.forEach((harga){keluar = harga['Total'];});
//    print(_total);
    _total = masuk - keluar;
    setState(() => _total = _total);
  }

  Future<Kategori> navigateToEntryForm(BuildContext context,
      Kategori kat) async {
    var result = await
    Navigator.push(
        context, MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(kat);
        }
    ));
    return result;
  }

  Future<Kategori> navigateToExpenseForm(BuildContext context,
      Kategori kat, String jenis) async {
    var result = await
    Navigator.push(
        context, MaterialPageRoute(
        builder: (BuildContext context) {
          return ExpenseForm(jenis, kat);
        }
    ));
    return result;
  }

  //NANTI...@HANDI
//  @override
//  void initState() {
//    super.initState();
//    updateListView();
//  }
//  void updateListView() {
//    setState(() {
//      future = dbHelper.getContactList();
//    });
//  }
  
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color.fromRGBO(0, 149, 218, 1);
    this.calTot();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.android),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {
                Navigator.pushNamed(context, '/setting');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // buat bakcground yang warnanya biru ijo
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(color: primaryColor),
              ),
            ),
            Stack(
              //Stack itu kaya z-index di css
              children: <Widget>[
                ClipPath(
                  // ini kaya bikin shape yang bisa di customize sisi nya
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$_total',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Sisa Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                      Material(
                        elevation: 1.0,
                        borderRadius: BorderRadius.circular(100.0),
                        color: Color.fromRGBO(232, 108, 0, 1),
                        child: MaterialButton(
                            onPressed: () async {
                              var kategori = await navigateToEntryForm(context, null);
                              if(kategori != null) {
                                int result = await dbHelper.insertHistory(kategori);
//                              NANTI...@HANDI
//                                if (result > 0) {
//                                  updateListView();
//                               }
                              }
                            },
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                          child: Text('TAMBAH',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 120.0, right: 25.0, left: 25),
                  child: Container(
                    width: double.infinity,
                    height: 230.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Color.fromRGBO(187, 223, 227, 0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.fastfood),
                                      color: Color.fromRGBO(96, 212, 224, 1),
                                      iconSize: 30,
                                      onPressed: () async{
                                        RouteExpenseForm('Makanan');
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Makanan',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Color.fromRGBO(176, 209, 255, 0.07),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.shopping_cart),
                                      color: Color.fromRGBO(117, 175, 255, 1),
                                      iconSize: 30,
                                        onPressed: () async{
                                          RouteExpenseForm('Belanja');
                                        },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Belanja',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Color.fromRGBO(255, 0, 174, 0.02),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.movie_filter),
                                      color: Color.fromRGBO(255, 0, 174, 0.61),
                                      iconSize: 30,
                                        onPressed: () async{
                                          RouteExpenseForm('Hiburan');
                                        },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Hiburan',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Divider(),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                                  'Lorem Ipsum has been the industry Lorem Ipsum is simply dummy text',
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 0.5,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 30.0, bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'History',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: InkWell(
                      child: Text(
                        'Lebih Banyak',
                        style: TextStyle(
                          color: Colors.blue.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/history');
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0, bottom: 25.0),
              child: Container(
                height: 400.0,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    HistoryCards(
                      title: 'Tagihan Listrik',
                      value: 32000,
                      cPrice: Color.fromRGBO(119, 184, 116, 1),
                      time: '13.02',
                    ),
                    HistoryCards(
                      title: 'Tagihan Listrik',
                      value: 32000,
                      cPrice: Color.fromRGBO(255, 117, 117, 1),
                      time: '13.02',
                    ),
                    HistoryCards(
                      title: 'Tagihan Listrik',
                      value: 32000,
                      cPrice: Color.fromRGBO(255, 117, 117, 1),
                      time: '13.02',
                    ),
                    HistoryCards(
                      title: 'Tagihan Listrik',
                      value: 32000,
                      cPrice: Color.fromRGBO(119, 184, 116, 1),
                      time: '13.02',
                    ),
                    HistoryCards(
                      title: 'Tagihan Listrik',
                      value: 32000,
                      cPrice: Color.fromRGBO(119, 184, 116, 1),
                      time: '13.02',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void RouteExpenseForm(String jenis) async {
    var kategori = await navigateToExpenseForm(
        context, null, jenis);
    if (kategori != null) {
      int result = await dbHelper.insertHistory(
          kategori);
      //NANTI...@HANDI
//      if (result > 0) {
//        updateListView();
//      }
    }
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

class HistoryCards extends StatelessWidget {
  String title;
  double value;
  String time;
  Color cPrice;
  Color color = Color.fromRGBO(153, 153, 153, 0.07);

  HistoryCards({this.title, this.value, this.time, this.cPrice});

  Color checkColour(String tag) {
    if (tag == '+') {
      return Color.fromRGBO(129, 255, 117, 1);
    } else {
      return Color.fromRGBO(255, 117, 117, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0, bottom: 10.0),
      child: Container(
        width: 120.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                '$value',
                style: TextStyle(
                    fontSize: 22.0, color: cPrice, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
