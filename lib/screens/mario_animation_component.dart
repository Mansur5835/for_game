import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:for_game/constants/enums.dart';
import 'package:for_game/widgets/assets.dart';

class MarioAnimationCompanent extends StatefulWidget {
  const MarioAnimationCompanent({Key? key}) : super(key: key);

  @override
  State<MarioAnimationCompanent> createState() =>
      _MarioAnimationCompanentState();
}

class _MarioAnimationCompanentState extends State<MarioAnimationCompanent> {
  int index = 6;
  Diraction diraction = Diraction.right;
  double parallaxX = 1;
  double parallaxX1 = 0;
  late Size size;
  double podark = 1.5;

  _moveMario() {
    setState(() {
      if (parallaxX1 == 0) {
        parallaxX1 = 2 * size.width;
      }
    });
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        index++;

        if (diraction == Diraction.right) {
          parallaxX -= 10;
          parallaxX1 -= 10;
          podark -= 0.01;

          if (index >= 6) {
            index = 1;
          }
        } else if (diraction == Diraction.left) {
          parallaxX += 10;
          if (index >= 11) {
            index = 7;
          }
        }

        _controlParallax();
        _controlPodark();
      });
    });
  }

  _controlParallax() {
    if (parallaxX < -size.width * 2) {
      parallaxX = size.width * 2 - 10;
    }

    if (parallaxX1 < -size.width * 2) {
      parallaxX1 = size.width * 2 - 10;
    }
  }

  _controlPodark() {
    if (podark < -1) {
      podark = 1.5;
    }
  }

  _moveRight() {
    setState(() {
      diraction = Diraction.right;
      index = 1;
    });
  }

  _moveLeft() {
    setState(() {
      diraction = Diraction.left;
      index = 7;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    size = MediaQuery.of(context).size;
    print(size.width);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment(parallaxX, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 1,
              height: MediaQuery.of(context).size.height - 1,
              child: Image.asset(
                Assets.image(name: "trees", format: "jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment(parallaxX1, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 1,
              height: MediaQuery.of(context).size.height - 1,
              child: Image.asset(
                Assets.image(name: "trees", format: "jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment(podark, 0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                Assets.image(name: "podark", format: "png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          GestureDetector(
            onTap: _moveMario,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                Assets.mario(count: index, format: "png"),
                width: 100,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _moveLeft,
                  child: const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.arrow_left_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: _moveRight,
                  child: const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.arrow_right_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
