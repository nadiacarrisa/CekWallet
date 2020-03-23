import 'package:flutter/material.dart';
import 'package:money_management/HistoryPage.dart';
import 'EditForm.dart';
import 'ExpenseForm.dart';
import 'IncomeForm.dart';
import 'dart:async';
import 'models/History.dart';
import 'services/DBlite.dart';
import 'services/HistoryService.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class MainMenu extends StatefulWidget {

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  int _total = 0;
  int masuk, keluar;
  List totalList;
  List<Widget> cardList = [];
  DBLite dbHelper = new DBLite();
  HistoryCon dbHistory = new HistoryCon();
  HistoryCards historyCardList = new HistoryCards();



  void calTot() async {
    totalList = await dbHelper.calculateTotalPemasukan();
    totalList.forEach(
      (harga) {
        masuk = harga['Total'];
      },
    );

    totalList = await dbHelper.calculateTotalPengeluaran();
    totalList.forEach(
      (harga) {
        keluar = harga['Total'];
      },
    );

    if(masuk!=null && keluar !=null){
      _total = masuk - keluar;
    }else if(keluar==null){
      _total = 0 + masuk;
    }else{
      _total = 0 - keluar;
    }
    setState(() => this._total = _total);
  }

  void getList() async {
    List cList = new List();
    List<Widget> _cardList = new List();
    String tgl = '';
    Widget dateText;
    cList = await dbHistory.getHistoryList(10);
    Color col;
    String tag;
    cList.forEach(
      (history) {
        if (history['tag'] == '+') {
          col = Color.fromRGBO(61, 153, 75, 0.8);
        } else {
          col = Color.fromRGBO(237, 85, 85, 0.8);
        }

        if (tgl != history['date']) {
          tgl = history['date'];
          dateText = Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              tgl,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
          _cardList.add(dateText);
        }

        HistoryCards hc = new HistoryCards(
          id: history['id'],
          title: history['deskripsi'],
          value: history['jumlah'],
          time: history['date'],
          cPrice: col,
          tag: history['tag'],
          tagLabel: history['kategori'],
          klikUpdate: ()=>{RouteEditForm(History(id: history['id'], kategori: history['kategori'], deskripsi: history['deskripsi'], date: history['date'],jumlah: history['jumlah'], tag: history['tag']))}
        );
        _cardList.add(hc.cards());
      },
    );
    setState(() => this.cardList = _cardList);
  }

  @override
  void initState() {
    calTot();
    getList();
    super.initState();
  }

  Future<History> navigateToIncomeForm(
      BuildContext context, History kat) async {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return IncomeForm(kat);
          },
        ),
      );
    return result;
  }

  Future<History> navigateToExpenseForm(
      BuildContext context, History kat, String jenis) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ExpenseForm(jenis, kat);
        },
      ),
    );
    return result;
  }

  Future<History> navigateToEditForm(
      BuildContext context, History kat) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditForm(kat);
        },
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color.fromRGBO(0, 149, 218, 1);
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
                            var kategori =
                                await navigateToIncomeForm(context, null);
                            if (kategori != null) {
                              await dbHistory
                                  .insertHistory(kategori)
                                  .then((total) {
                                calTot();
                                getList();
                              });
                            }
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: Text(
                            'TAMBAH',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
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
                                      onPressed: () async {
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
                                      onPressed: () async {
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
                                      onPressed: () async {
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
              padding: EdgeInsets.only(left: 25.0, bottom: 25.0, right: 25.0),
              child: Container(
                height: 400.0,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: cardList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void RouteExpenseForm(String jenis) async {
    var kategori = await navigateToExpenseForm(context, null, jenis);
    if (kategori != null) {
      await dbHistory.insertHistory(kategori).then((total) {
        calTot();
        getList();
      });
    }
  }

  void RouteEditForm(History edit) async{
    var kategori = await navigateToEditForm(context, edit);
    if (kategori != null) {
      await dbHistory.updateHistory(kategori).then((total) {
        calTot();
        getList();
      });
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

class HistoryCards {
  int id;
  String title;
  int value;
  String time;
  Color cPrice;
  String tagLabel;
  String tag;
  VoidCallback klikUpdate;

  HistoryCards(
      {this.id,this.title,
      this.value,
      this.time,
      this.cPrice,
      this.tag,
      this.tagLabel, this.klikUpdate});
  Widget cards() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(224, 224, 224, 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.2),
                              blurRadius: 2.0,
                              // has the effect of softening the shadow
                              spreadRadius: 0.2,
                              // has the effect of extending the shadow
                              offset: Offset(
                                0, // horizontal, move right 10
                                1.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 2.0),
                          child: Text(
                            tagLabel,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(64, 72, 79, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
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
            ],
          ),
          trailing: Text(
            '$tag' + ' Rp' + '$value',
            style: TextStyle(
              fontSize: 18.0,
              color: cPrice,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: klikUpdate,
        ),
      ),
    );
  }
}
