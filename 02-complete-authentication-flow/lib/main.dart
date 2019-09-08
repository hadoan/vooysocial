import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Network',
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.teal
      ),
    );
  }
  
}
