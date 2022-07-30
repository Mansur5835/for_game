import 'dart:async';

import 'package:flutter/material.dart';
import "dart:math";

import 'package:for_game/constants/enums.dart';

class GridViewComponent extends StatefulWidget {
  const GridViewComponent({Key? key}) : super(key: key);

  @override
  State<GridViewComponent> createState() => _GridViewComponentState();
}

class _GridViewComponentState extends State<GridViewComponent> {
  late Size size;
  late int countHeight;
  int index = 10;
  int target = 10 * 20 + 10;

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

    if (index == target) {
      _randomTarget();
    }
  }

  _randomTarget() {
    target = Random().nextInt(countHeight);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    countHeight = (size.height ~/ (size.width ~/ 20) * 20 - 40);

    return GestureDetector(
      onTap: _boxMove,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            bottom: false,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 20,
              children: List.generate(countHeight, (index) {
                return Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: this.index == index
                          ? Colors.blue
                          : index == target
                              ? Colors.yellow
                              : Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                );
              }),
            ),
          )),
    );
  }
}
