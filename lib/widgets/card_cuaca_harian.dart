import 'package:flutter/material.dart';
import 'package:weather_app/utilities/color.dart';

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
    return SizedBox(
      height: 90.0,
      child: Card(
        color: ColorConst.blue_semi,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(icon_cuaca),
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
        ),
      ),
    );
  }
}
