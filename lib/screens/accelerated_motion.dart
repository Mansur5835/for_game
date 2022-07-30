import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:for_game/constants/enums.dart';
import 'dart:math' as math;

class AcceleratedMotion extends StatefulWidget {
  const AcceleratedMotion({Key? key}) : super(key: key);

  @override
  State<AcceleratedMotion> createState() => _AcceleratedMotionState();
}

class _AcceleratedMotionState extends State<AcceleratedMotion> {
  double t = 0.01;
  double y = -1;
  double a = 0.1;
  late final double v0;
  Diraction diraction = Diraction.down;
  bool loadV0 = false;

  _boxMove() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (diraction == Diraction.down) {
          y += a * t * t / 2;
          t += 0.1;
        } else if (diraction == Diraction.up) {
          y += -(v0 - a * t * t / 2);
          t += 0.1;
        }
        _controlY();
      });
    });
  }

  _controlY() {
    if (y > 1) {
      diraction = Diraction.up;
      if (!loadV0) {
        v0 = (a * t * t / 2) / 2;
        loadV0 = true;
      }

      t = 0.01;
      y = 0.8;
    } else if (y < -1) {
      diraction = Diraction.down;
      t = 0.01;
      y = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
              alignment: Alignment(0, y),
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
