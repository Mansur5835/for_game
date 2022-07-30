import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_game/screens/collision_elements.dart';
import 'package:for_game/screens/grid_view_component.dart';
import 'package:for_game/screens/map_control.dart';
import 'package:for_game/screens/mario_animation_component.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapControl(),
    );
  }
}
