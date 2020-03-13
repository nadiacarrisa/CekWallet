import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:money_management/services/HistoryService.dart';

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
  List<Widget> cardList = [];

  void getList() async {
    List cList = new List();
    List<Widget> _cardList = new List();
    String tgl = '';
    Widget dateText;
    cList = await dbHistory.getAllHistoryList();
    Color col;
    String tag;
    cList.forEach(
      (history) {
        if (history['tag'] == '0') {
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
        );
        _cardList.add(hc.cards());
      },
    );
    setState(() => this.cardList = _cardList);
  }

  @override
  void initState() {
    super.initState();
    getList();
    controller = TabController(vsync: this, length: 4);
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
              children: cardList,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 15.0),
                  child: Text(
                    '29 Januari 2020',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 15.0),
                  child: Text(
                    '29 Januari 2020',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 15.0),
                  child: Text(
                    '29 Januari 2020',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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

  HistoryCardsWithTag(
      {this.title,
      this.value,
      this.time,
      this.cPrice,
      this.tag,
      this.tagLabel});

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
//        onTap: (){Navigator.pushNamed(context, '/ubahlimit');},
          ),
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
