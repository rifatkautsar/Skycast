import 'package:flutter/material.dart';
import 'package:weather_app/utilities/color.dart';

class CardCuacaPerjam extends StatelessWidget {
  final String? iconCuaca;
  final String? suhuCuaca;
  final String? waktuCuaca;

  const CardCuacaPerjam({
    super.key,
    required this.iconCuaca,
    required this.suhuCuaca,
    required this.waktuCuaca,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 100.0,
      child: Card(
        child: Column(
          children: [
            Image.asset(iconCuaca! ,width: 100.0, height: 60.0,),
            Text(
              suhuCuaca!,
              style: const TextStyle(
                color: ColorConst.button_color,
              ),
            ),
            Text(
              waktuCuaca!,
              style: const TextStyle(
                color: ColorConst.button_color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
