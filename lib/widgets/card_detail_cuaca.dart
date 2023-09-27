import 'package:flutter/material.dart';
import 'package:weather_app/utilities/TextColor.dart';
import 'package:weather_app/utilities/color.dart';

class CardDetailCuaca extends StatelessWidget {
  final IconData iconDetailCuaca;
  final String dataDetailCuaca;
  final String deskripsiDetailCuaca;

  const CardDetailCuaca(
      {super.key,
      required this.iconDetailCuaca,
      required this.dataDetailCuaca,
      required this.deskripsiDetailCuaca});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.0,
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(
              iconDetailCuaca,
              size: 28,
              color: ColorConst.blue_color3,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextColorBlack(valueText: dataDetailCuaca),
                TextColorAbu(valueTextAbu: deskripsiDetailCuaca, size: 12.0,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
