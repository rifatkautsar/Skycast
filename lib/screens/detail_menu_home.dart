import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather_app/utilities/TextColor.dart';
import 'package:weather_app/utilities/color.dart';
import 'package:weather_app/widgets/appbar.dart';
import 'package:weather_app/widgets/card_cuaca_perjam.dart';
import 'package:weather_app/widgets/card_detail_cuaca.dart';

class DetailMenuHome extends StatefulWidget {
  final double? celciusCuaca;
  final String? kondisiCuaca;
  final int? kondisiKelembaban;
  final double? kondisiTekanan;
  final double? kondisiKecepatan;
  final int? kondisiKabut;
  final String? nama_lokasi;


  const DetailMenuHome({super.key , required this.celciusCuaca, required this.kondisiCuaca,
    required this.kondisiKelembaban,
    required this.kondisiTekanan,
    required this.kondisiKecepatan,
    required this.kondisiKabut,
    required this.nama_lokasi,
  });

  @override
  State<DetailMenuHome> createState() => _DetailMenuHomeState();
}

class _DetailMenuHomeState extends State<DetailMenuHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSkycast(appbarName: widget.nama_lokasi!),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 210.0,
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [ColorConst.black_color, ColorConst.black_color2],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Senin, 20 Desember 2021 - 10.30 PM'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Lottie.asset(
                      'assets/weather_anim.json',
                      // Replace with the URL to your Lottie animation JSON file
                      width: 60, // Set the width and height as needed
                      height: 60,
                    ),
                    Text('${widget.celciusCuaca}º C' ?? 'Loading...'),
                    Text(widget.kondisiCuaca!),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Terakhir update 8.00 PM'),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.restart_alt_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cuaca Per Jam',
                      style: TextStyle(
                        color: ColorConst.button_color,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 150.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return const CardCuacaPerjam(
                              iconCuaca: 'assets/rainy.png',
                              suhuCuaca: '17º',
                              waktuCuaca: '11.00 PM');
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Detail Informasi',
                      style: TextStyle(
                        color: ColorConst.button_color,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 3.0,
                            animation: true,
                            percent: 0.12,
                            reverse: true,
                            center: const Text(
                              "12",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.green),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.green,
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextColorBlack(valueText: 'Aqi - Sangat Baik'),
                            SizedBox(
                              height: 2.0,
                            ),
                            SizedBox(
                              width: 250.0,
                              child: TextColorAbu(
                                  valueTextAbu:
                                      'Kualitas udara di daerahmu untuk saat inisangat baik. Tidak ada pencemaran udara yang menyebabkan berbagai penyakit.', size: 12.0,),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            CardDetailCuaca(
                                iconDetailCuaca: Icons.cloud,
                                dataDetailCuaca: '${widget.kondisiKelembaban!} %',
                                deskripsiDetailCuaca: 'Kelembaban'),
                            CardDetailCuaca(
                                iconDetailCuaca: Icons.wind_power_rounded,
                                dataDetailCuaca: '${widget.kondisiTekanan!} pHa',
                                deskripsiDetailCuaca: 'Tekanan Udara'),
                          ],
                        ),
                        Column(
                          children: [
                            CardDetailCuaca(
                                iconDetailCuaca: Icons.cloud,
                                dataDetailCuaca: '${widget.kondisiKecepatan!} km/h',
                                deskripsiDetailCuaca: 'Kecepatan Angin'),
                            CardDetailCuaca(
                                iconDetailCuaca: Icons.cloud,
                                dataDetailCuaca: '${widget.kondisiKabut!} %',
                                deskripsiDetailCuaca: 'Kabut'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
