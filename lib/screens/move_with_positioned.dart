import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_game/constants/enums.dart';
import 'dart:math' as math;

class MoveWithPositioned extends StatefulWidget {
  const MoveWithPositioned({Key? key}) : super(key: key);

  @override
  State<MoveWithPositioned> createState() => _MoveWithPositionedState();
}

class _MoveWithPositionedState extends State<MoveWithPositioned> {
  double t = 0.5;
  double y = 0;
  double a = 10;
  late final double v0;
  Diraction diraction = Diraction.down;
  bool loadV0 = false;
  late Size size;

  _boxMove() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (diraction == Diraction.down) {
          y += a * t * t / 2;
          t += 0.5;
        } else if (diraction == Diraction.up) {
          y += -(v0 - a * t * t / 2);
          t += 0.5;
        }
        _controlY();
      });
    });
  }

  _controlY() {
    if (y > size.height - 40) {
      diraction = Diraction.up;
      if (!loadV0) {
        v0 = (a * t * t / 2) / 2;
        loadV0 = true;
      }

      t = 0.5;
      y = size.height - 10;
    } else if (y < 0) {
      diraction = Diraction.down;
      t = 0.5;
      y = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              top: y,
              left: size.width / 2,
              child: GestureDetector(
                onTap: _boxMove,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ))
        ]),
      ),
    );
  }
}
