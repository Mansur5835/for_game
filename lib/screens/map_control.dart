import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_game/constants/enums.dart';
import 'package:for_game/widgets/assets.dart';
import 'package:for_game/widgets/buttons.dart';

class MapControl extends StatefulWidget {
  const MapControl({Key? key}) : super(key: key);

  @override
  State<MapControl> createState() => _MapControlState();
}

class _MapControlState extends State<MapControl> {
  double mapX = -300;
  double mapY = -300;
  late Timer _timer;
  Diraction diraction = Diraction.none;
  int georgeIndex = 1;

  _moveController() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (diraction == Diraction.up) {
          mapY -= 10;
          georgeIndex++;
          if (georgeIndex >= 12) {
            georgeIndex = 9;
          }
        } else if (diraction == Diraction.down) {
          mapY += 10;
          georgeIndex++;
          if (georgeIndex >= 4) {
            georgeIndex = 1;
          }
        } else if (diraction == Diraction.right) {
          mapX -= 10;
          georgeIndex++;
          if (georgeIndex >= 16) {
            georgeIndex = 13;
          }
        }
        if (diraction == Diraction.left) {
          mapX += 10;
          georgeIndex++;
          if (georgeIndex >= 8) {
            georgeIndex = 5;
          }
        }
      });
    });
  }

  _moveUp() {
    setState(() {
      diraction = Diraction.up;
      georgeIndex = 9;
    });
  }

  _moveDown() {
    setState(() {
      diraction = Diraction.down;
      georgeIndex = 1;
    });
  }

  _moveLeft() {
    setState(() {
      diraction = Diraction.left;
      georgeIndex = 5;
    });
  }

  _moveRight() {
    setState(() {
      diraction = Diraction.right;
      georgeIndex = 13;
    });
  }

  _stopMove() {
    setState(() {
      diraction = Diraction.none;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: mapY,
            left: mapX,
            width: 3 * MediaQuery.of(context).size.width,
            height: 3 * MediaQuery.of(context).size.height,
            child: Image.asset(
              Assets.image(name: "rayworld_background", format: "png"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              alignment: Alignment(0, 0),
              child: Image.asset(
                Assets.george(count: georgeIndex, format: "png"),
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              )),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MapButton(
                        child: Icon(Icons.arrow_upward_outlined),
                        onEnd: _stopMove,
                        onTap: _moveUp)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MapButton(
                        child: Icon(Icons.arrow_back),
                        onEnd: _stopMove,
                        onTap: _moveLeft),
                    MapButton(
                        child: Icon(Icons.arrow_right_alt_outlined),
                        onEnd: _stopMove,
                        onTap: _moveRight)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MapButton(
                        child: Icon(Icons.arrow_downward_outlined),
                        onEnd: _stopMove,
                        onTap: _moveDown)
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
