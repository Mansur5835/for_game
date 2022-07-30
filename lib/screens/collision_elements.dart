import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:for_game/constants/enums.dart';

class CollisionOfElement extends StatefulWidget {
  const CollisionOfElement({Key? key}) : super(key: key);

  @override
  State<CollisionOfElement> createState() => _CollisionOfElementState();
}

class _CollisionOfElementState extends State<CollisionOfElement> {
  double boxX1 = 1;
  double boxY1 = 0;
  double boxX2 = -1;
  double boxY2 = 0;
  Timer? _timer;
  bool isCollision = false;

  _boxMove() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        print(isCollision);
        if (isCollision) {
          boxX1 += 0.09;

          boxX2 -= 0.09;
        } else {
          boxX1 -= 0.09;

          boxX2 += 0.09;
        }
      });

      _controlBoxes(boxX1, boxX2);

      print("boxX1 $boxX1 boxY1 $boxY1 boxX2 $boxX2 boxY2 $boxY2");
    });
  }

  _controlBoxes(double x1, double x2) {
    if ((x1 - x2).abs() < 0.3) {
      isCollision = true;
    }

    if (x2 < -1 || x1 > 1) {
      isCollision = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _boxMove,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              alignment: Alignment(boxX1, boxY1),
              child: const CircleAvatar(
                backgroundColor: Colors.red,
              ),
            ),
            Container(
              alignment: Alignment(boxX2, boxY2),
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
