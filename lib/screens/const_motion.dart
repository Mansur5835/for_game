import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:for_game/constants/enums.dart';
import 'dart:math' as math;

class ConstMotion extends StatefulWidget {
  const ConstMotion({Key? key}) : super(key: key);

  @override
  State<ConstMotion> createState() => _ConstMotionState();
}

class _ConstMotionState extends State<ConstMotion> {
  double x = 0;
  double y = 0;
  double x0 = 0;
  double y0 = 0;
  double r = 0.8;
  Diraction diraction = Diraction.right;
  int minusOrPlus = 1;

  _boxMove() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        y = minusOrPlus * math.sqrt((math.pow(r, 2) - math.pow(x, 2)));

        if (diraction == Diraction.right) {
          x += 0.02;
        } else if (diraction == Diraction.left) {
          x -= 0.02;
        }
        _controlX();
      });
    });
  }

  _controlX() {
    if (x > r) {
      diraction = Diraction.left;
      minusOrPlus = 1;
    } else if (x < -r) {
      diraction = Diraction.right;
      minusOrPlus = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            alignment: Alignment(x, y),
            child: GestureDetector(
              onTap: _boxMove,
              child: CircleAvatar(
                backgroundColor: Colors.red,
              ),
            ))
      ]),
    );
  }
}
