import 'package:flutter/material.dart';
import 'package:money_management/Settings.dart';
import 'UbahLimit.dart';
import 'package:money_management/SplashScreen.dart';
import 'MainMenu.dart';
import 'HistoryPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/setting': (context) => Settings(),
        '/ubahlimit': (context) => UbahLimit(),
        '/tentang': (context) => Tentang(),
        '/keuntungan': (context) => Keuntungan(),
        '/history': (context) => HistoryPage(),
        '/': (context) => SplashScreenPage(),
        '/main': (context) => MainMenu(),
      },
    );
  }
}
