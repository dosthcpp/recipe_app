import 'package:flutter/material.dart';
import 'package:recipe_app/infoPage.dart';
import 'package:recipe_app/initPage.dart';
import 'package:recipe_app/mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: InitPage.id,
      routes: {
        InitPage.id: (context) => InitPage(),
        InfoPage.id: (context) => InfoPage(),
        MainPage.id: (context) => MainPage(),
      }
    );
  }
}
