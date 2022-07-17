import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_game/screens/home.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
