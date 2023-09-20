import 'package:flutter/material.dart';
import 'package:weather_app/utilities/color.dart';

class TextColorBlack extends StatelessWidget {
  final String valueText;

  const TextColorBlack({super.key, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Text(
      valueText!,
      style: const TextStyle(
        fontSize: 15.0,
        color: ColorConst.black_color,
      ),
    );
  }
}

class TextColorAbu extends StatelessWidget {
  final String valueTextAbu;
  final double size;
  const TextColorAbu({super.key, required this.valueTextAbu , required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      valueTextAbu!,
      style: TextStyle(
        fontSize: size,
        color: ColorConst.brown,
      ),
    );
  }
}

