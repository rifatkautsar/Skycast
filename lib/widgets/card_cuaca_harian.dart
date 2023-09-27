import 'package:flutter/material.dart';
import 'package:weather_app/utilities/color.dart';
import 'package:weather_app/widgets/custom_image_network.dart';

class CardCuacaHarian extends StatelessWidget {
  final String icon_cuaca;
  final String hari;
  final String kondisi_cuaca;
  final String drajat_cuaca;

  const CardCuacaHarian({
    super.key,
    required this.icon_cuaca,
    required this.hari,
    required this.kondisi_cuaca,
    required this.drajat_cuaca,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ColorConst.blue_semi,
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 50.0, // Adjust the size of the outer circle
                  height: 50.0, // Adjust the size of the outer circle
                  color: ColorConst.blue_color4,
                  child: Center(
                    child: ClipOval(
                      child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.transparent,
                          child: CustomNetworkImage(
                              imageUrl: icon_cuaca, width: 30.0, height: 30.0, sizeIcon: 30.0,)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hari,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    kondisi_cuaca,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                drajat_cuaca,
                style: const TextStyle(color: Colors.black),
              ),
              const Icon(Icons.arrow_right)
            ],
          ),
        ],
      ),
    );
  }
}
