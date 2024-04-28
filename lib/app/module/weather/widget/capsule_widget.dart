import 'package:flutter/material.dart';
import 'package:flutter_craft/app/module/weather/widget/froster_glass.dart';

class CapsuleWidget extends StatelessWidget {
  final needDot;
  final icon;
  String? day;
  final temp;

  CapsuleWidget({Key? key, this.needDot, this.icon, this.temp, this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
        theWidth: 80.0, theHeight: 160.0, theChild: _items());
  }

  Widget _items() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(day ?? ''), Icon(Icons.cloud), Text(temp ?? '')],
      );
}
