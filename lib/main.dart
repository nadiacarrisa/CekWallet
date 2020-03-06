import 'package:flutter/material.dart';
import 'MainMenu.dart';
import 'History.dart';

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
      initialRoute: '/history',
      routes: <String, WidgetBuilder>{
        '/': (context) => MainMenu(),
        '/history': (context) => History(),
      },
    );
  }
}
