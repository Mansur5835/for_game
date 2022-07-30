import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  Widget child;
  Function onTap;
  Function onEnd;

  MapButton(
      {Key? key, required this.child, required this.onEnd, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        onTap();
      },
      onTap: (() {
        onEnd();
      }),
      child: CircleAvatar(
        radius: 30,
        child: child,
      ),
    );
  }
}
