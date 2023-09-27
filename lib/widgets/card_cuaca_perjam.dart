import 'package:flutter/material.dart';
import 'package:weather_app/utilities/color.dart';
import 'package:weather_app/widgets/custom_image_network.dart';

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
    return SizedBox(
      height: 50.0,
      width: 100.0,
      child: Column(
        children: [
          CustomNetworkImage(imageUrl: iconCuaca!, width: 100.0, height: 80.0, sizeIcon: 30.0,),
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
    );
  }
}
