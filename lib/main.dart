import 'package:flutter/material.dart';
import 'package:recipe_app/initPage.dart';

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
      }
    );
  }
}
