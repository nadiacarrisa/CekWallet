import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/SplashScreen.dart';
import 'MainMenu.dart';
import 'EntryForm.dart';

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
        '/': (context) => SplashScreenPage(),
        '/main': (context) => MainMenu(),
        '/pemasukan': (context) => EntryForm(),
      },
    );
  }
}
