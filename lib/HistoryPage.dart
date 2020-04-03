import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:money_management/services/HistoryService.dart';
import 'EditForm.dart';
import 'models/History.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  Color primaryColor = Color.fromRGBO(0, 149, 218, 1);
  Color secondaryColor = Colors.orangeAccent;
  HistoryCon dbHistory = new HistoryCon();
  List<Widget> cardListAll = [];
  List<Widget> cardListFood = [];
  List<Widget> cardListEntertain = [];
  List<Widget> cardListshopping = [];
  List<Widget> cardListPemasukan= [];

  void getList() async {
    List cList = new List();
    List cListFood = new List();
    List cListEntertain = new List();
    List cListShopping = new List();
    List cListPemasukan = new List();
    List<Widget> _cardList = new List();
    List<Widget> _cardListFood = new List();
    List<Widget> _cardListEntertain = new List();
    List<Widget> _cardListShopping = new List();
    List<Widget> _cardListPemasukan = new List();
    cList = await dbHistory.getAllHistoryList();
    cListFood = await dbHistory.getAllHistoryListByName("Makanan");
    cListEntertain = await dbHistory.getAllHistoryListByName("Hiburan");
    cListShopping = await dbHistory.getAllHistoryListByName("Belanja");
    cListPemasukan = await dbHistory.getAllHistoryListByName("Pemasukan");
    Widget dateText;
    Color col;
    String tag;

    if (cList.length != 0) {
      String tgl = '';
      cList.forEach(
        (history) {
          if (history['tag'] == '+') {
            col = Color.fromRGBO(61, 153, 75, 0.8);
            tag = '+';
          } else {
            col = Color.fromRGBO(237, 85, 85, 0.8);
            tag = '-';
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

          HistoryCardsWithTag hc = new HistoryCardsWithTag(
            title: history['deskripsi'],
            value: history['jumlah'],
            time: history['date'],
            cPrice: col,
            tag: tag,
            tagLabel: history['kategori'],
            klikUpdate: () => {
              RouteEditForm(
                History(
                  id: history['id'],
                  kategori: history['kategori'],
                  deskripsi: history['deskripsi'],
                  date: history['date'],
                  jumlah: history['jumlah'],
                  tag: history['tag'],
                ),
              ),
            },
          );
          _cardList.add(hc.cards());
        },
      );
    } else {
      _cardList.add(noHistory('images/taskwithpeople.png'));
    }

    if (cListFood.length != 0) {
      String tgl = '';
      cListFood.forEach(
        (history) {
          if (history['tag'] == '+') {
            col = Color.fromRGBO(61, 153, 75, 0.8);
            tag = '+';
          } else {
            col = Color.fromRGBO(237, 85, 85, 0.8);
            tag = '-';
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
            _cardListFood.add(dateText);
          }

          HistoryCardsWithTag hc = new HistoryCardsWithTag(
            title: history['deskripsi'],
            value: history['jumlah'],
            time: history['date'],
            cPrice: col,
            tag: tag,
            tagLabel: history['kategori'],
            klikUpdate: () => {
              RouteEditForm(
                History(
                  id: history['id'],
                  kategori: history['kategori'],
                  deskripsi: history['deskripsi'],
                  date: history['date'],
                  jumlah: history['jumlah'],
                  tag: history['tag'],
                ),
              ),
            },
          );
          _cardListFood.add(hc.cards());
        },
      );
    } else {
      _cardListFood.add(noHistory('images/noFoodData.png'));
    }

    if (cListEntertain.length != 0) {
      String tgl = '';
      cListEntertain.forEach(
        (history) {
          if (history['tag'] == '+') {
            col = Color.fromRGBO(61, 153, 75, 0.8);
            tag = '+';
          } else {
            col = Color.fromRGBO(237, 85, 85, 0.8);
            tag = '-';
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
            _cardListEntertain.add(dateText);
          }

          HistoryCardsWithTag hc = new HistoryCardsWithTag(
            title: history['deskripsi'],
            value: history['jumlah'],
            time: history['date'],
            cPrice: col,
            tag: tag,
            tagLabel: history['kategori'],
            klikUpdate: () => {
              RouteEditForm(
                History(
                  id: history['id'],
                  kategori: history['kategori'],
                  deskripsi: history['deskripsi'],
                  date: history['date'],
                  jumlah: history['jumlah'],
                  tag: history['tag'],
                ),
              ),
            },
          );
          _cardListEntertain.add(hc.cards());
        },
      );
    } else {
      _cardListEntertain.add(noHistory('images/noEntertaintData.png'));
    }

    if (cListShopping.length != 0) {
      String tgl = '';
      cListShopping.forEach(
        (history) {
          if (history['tag'] == '+') {
            col = Color.fromRGBO(61, 153, 75, 0.8);
            tag = '+';
          } else {
            col = Color.fromRGBO(237, 85, 85, 0.8);
            tag = '-';
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
            _cardListShopping.add(dateText);
          }

          HistoryCardsWithTag hc = new HistoryCardsWithTag(
            title: history['deskripsi'],
            value: history['jumlah'],
            time: history['date'],
            cPrice: col,
            tag: tag,
            tagLabel: history['kategori'],
            klikUpdate: () => {
              RouteEditForm(
                History(
                  id: history['id'],
                  kategori: history['kategori'],
                  deskripsi: history['deskripsi'],
                  date: history['date'],
                  jumlah: history['jumlah'],
                  tag: history['tag'],
                ),
              ),
            },
          );
          _cardListShopping.add(hc.cards());
        },
      );
    } else {
      _cardListShopping.add(noHistory('images/noShoppingData.png'));
    }

    if (cListPemasukan.length != 0) {
      String tgl = '';
      cListPemasukan.forEach(
            (history) {
          if (history['tag'] == '+') {
            col = Color.fromRGBO(61, 153, 75, 0.8);
            tag = '+';
          } else {
            col = Color.fromRGBO(237, 85, 85, 0.8);
            tag = '-';
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
            _cardListPemasukan.add(dateText);
          }

          HistoryCardsWithTag hc = new HistoryCardsWithTag(
            title: history['deskripsi'],
            value: history['jumlah'],
            time: history['date'],
            cPrice: col,
            tag: tag,
            tagLabel: history['kategori'],
            klikUpdate: () => {
              RouteEditForm(
                History(
                  id: history['id'],
                  kategori: history['kategori'],
                  deskripsi: history['deskripsi'],
                  date: history['date'],
                  jumlah: history['jumlah'],
                  tag: history['tag'],
                ),
              ),
            },
          );
          _cardListPemasukan.add(hc.cards());
        },
      );
    } else {
      _cardListPemasukan.add(noHistory('images/noMoneyData.png'));
    }

    setState(() {
      this.cardListAll = _cardList;
      this.cardListFood = _cardListFood;
      this.cardListEntertain = _cardListEntertain;
      this.cardListshopping = _cardListShopping;
      this.cardListPemasukan = _cardListPemasukan;
    });
  }

  Widget noHistory(String url) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Text(
            'Ow Snap!',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Image.asset(
            url,
            height: 280,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Belum ada data yang dapat ditampilkan',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void RouteEditForm(History edit) async {
    var kategori = await navigateToEditForm(context, edit);
    if (kategori != null) {
      await dbHistory.updateHistory(kategori).then((total) {
        getList();
      });
    }
  }

  Future<History> navigateToEditForm(BuildContext context, History kat) async {
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
  void initState() {
    super.initState();
    getList();
    controller = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: primaryColor,
        //CODE BARU
        bottom: TabBar(
          controller: controller,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.5),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 30.0,
            indicatorColor: secondaryColor,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: <Tab>[
            Tab(
              child: Text("Semua"),
            ),
            Tab(
              child: Text("Makanan"),
            ),
            Tab(
              child: Text("Hiburan"),
            ),
            Tab(
              child: Text("Belanja"),
            ),
            Tab(
              child: Text("Income"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: cardListAll,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: cardListFood,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: cardListEntertain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: cardListshopping,
            ),
          ),Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: cardListPemasukan,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCardsWithTag {
  String title;
  int value;
  String time;
  Color cPrice;
  String tagLabel;
  String tag;
  VoidCallback klikUpdate;

  HistoryCardsWithTag({
    this.title,
    this.value,
    this.time,
    this.cPrice,
    this.tag,
    this.tagLabel,
    this.klikUpdate,
  });

  Widget cards() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: ListTile(
          title: Column(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                      child: Text(
                        tagLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(64, 72, 79, 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
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

class HistoryCardsWithOutTag {
  String title;
  double value;
  String time;
  Color cPrice;
  Color color = Color.fromRGBO(153, 153, 153, 0.07);

  HistoryCardsWithOutTag(
      {this.title = "", this.value = 0, this.time, this.cPrice});

  Color checkColour(String tag) {
    if (tag == '+') {
      return Color.fromRGBO(129, 255, 117, 1);
    } else {
      return Color.fromRGBO(255, 117, 117, 1);
    }
  }

  Widget cards() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: ListTile(
//        leading: Icon(Icons.account_balance_wallet),
          title: Row(
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
            '$value',
            style: TextStyle(
                fontSize: 22.0,
                color: Color.fromRGBO(0, 132, 219, 0.4),
                fontWeight: FontWeight.bold),
          ),
//        onTap: (){Navigator.pushNamed(context, '/ubahlimit');},
        ),
      ),
    );
  }
}
