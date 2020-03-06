import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class History extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<History>
    with SingleTickerProviderStateMixin {
  TabController controller;
  Color primaryColor = Color.fromRGBO(0, 149, 218, 1);
  Color secondaryColor = Colors.orangeAccent;
  Color hiburan = Color.fromRGBO(224, 224, 224, 1);
  Color makanan = Color.fromRGBO(224, 224, 224, 1);
  Color belanja = Color.fromRGBO(224, 224, 224, 1);

  @override
  void initState() {
    super.initState();
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
                HistoryCardsWithTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  tagColor: belanja,
                  time: '13.02',
                  tag: 'Belanja',
                ),
                HistoryCardsWithTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  tagColor: hiburan,
                  time: '13.02',
                  tag: 'Hiburan',
                ),
                HistoryCardsWithTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  tag: 'Makanan',
                  tagColor: makanan,
                  time: '13.02',
                ),
                HistoryCardsWithTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  tag: 'Makanan',
                  tagColor: makanan,
                  time: '13.02',
                ),
                HistoryCardsWithTag(
                  tag: 'Hiburan',
                  title: 'Tagihan Listrik',
                  value: 32000,
                  tagColor: hiburan,
                  time: '13.02',
                ),
                HistoryCardsWithTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  tag: 'Makanan',
                  tagColor: makanan,
                  time: '13.02',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 15.0),
                  child: Text(
                    '30 Januari 2020',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                HistoryCardsWithTag(
                  title: 'Tagihan Listrik',
                  tag: 'Makanan',
                  value: 32000,
                  tagColor: makanan,
                  time: '13.02',
                ),
                HistoryCardsWithTag(
                  title: 'saya adalah handi hermawan',
                  tagColor: hiburan,
                  time: '13.02',
                  tag: 'Hiburan',
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
                HistoryCardsWithOutTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  time: '13.02',
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
                HistoryCardsWithOutTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  time: '13.02',
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
                HistoryCardsWithOutTag(
                  title: 'Tagihan Listrik',
                  value: 32000,
                  time: '13.02',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCardsWithTag extends StatelessWidget {
  String title;
  double value;
  String time;
  String tag;
  Color tagColor;
  Color cPrice;
  Color color = Color.fromRGBO(153, 153, 153, 0.07);

  HistoryCardsWithTag(
      {this.title = "",
      this.tag = "",
      this.value = 0,
      this.time,
      this.cPrice,
      this.tagColor});

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
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.05),
              blurRadius: 2.0,
              // has the effect of softening the shadow
              spreadRadius: 0.2,
              // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            )
          ],
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
                  Row(
                    children: <Widget>[
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: tagColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
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
                              tag,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(64, 72, 79, 1),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
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
              Text(
                '$value',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Color.fromRGBO(0, 132, 219, 0.4),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCardsWithOutTag extends StatelessWidget {
  String title;
  double value;
  String time;
  Color cPrice;
  Color color = Color.fromRGBO(153, 153, 153, 0.07);

  HistoryCardsWithOutTag(
      {this.title = "",
        this.value = 0,
        this.time,
        this.cPrice});

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
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.05),
              blurRadius: 2.0,
              // has the effect of softening the shadow
              spreadRadius: 0.2,
              // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            )
          ],
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
                  Row(
                    children: <Widget>[
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
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
              Text(
                '$value',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Color.fromRGBO(0, 132, 219, 0.4),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
