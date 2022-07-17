import 'dart:async';

import 'package:flutter/material.dart';
import "dart:math";

import 'package:for_game/constants/enums.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Size size;
  late int countHeight;
  int index = 10;

  Diraction diraction = Diraction.down;

  _boxMove() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (diraction == Diraction.down) {
          index += 20;
        } else if (diraction == Diraction.up) {
          index -= 20;
        }
      });
      _controlIndex(index);
    });
  }

  _controlIndex(int index) {
    if (index > countHeight) {
      diraction = Diraction.up;
    } else if (index < 0) {
      diraction = Diraction.down;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    countHeight = (size.height ~/ (size.width ~/ 20) * 20 - 40);

    return GestureDetector(
      onTap: _boxMove,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: GridView.count(
            crossAxisCount: 20,
            children: List.generate(countHeight, (index) {
              return Container(
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
              );
            }),
          )),
    );
  }
}
