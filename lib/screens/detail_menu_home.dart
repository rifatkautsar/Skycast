import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utilities/color.dart';
import 'package:weather_app/widgets/appbar.dart';
import 'package:weather_app/widgets/card_cuaca_perjam.dart';
import 'package:weather_app/widgets/card_detail_cuaca.dart';

import '../models/weather_model.dart';

class DetailMenuHome extends StatefulWidget {
  final double? celciusCuaca;
  final String? kondisiCuaca;
  final int? kondisiKelembaban;
  final double? kondisiTekanan;
  final double? kondisiKecepatan;
  final int? kondisiKabut;
  final String? nama_lokasi;
  final String? waktuLokal;
  final String? waktuUpdate;
  final String? imageCuaca;
  final List<Hour>? forecastHourList;
  final AirQuality airquality;
  final double? minTempC;
  final double? maxTempC;
  final String? moonPahase;

  const DetailMenuHome({
    super.key,
    required this.celciusCuaca,
    required this.kondisiCuaca,
    required this.kondisiKelembaban,
    required this.kondisiTekanan,
    required this.kondisiKecepatan,
    required this.kondisiKabut,
    required this.nama_lokasi,
    required this.waktuLokal,
    required this.forecastHourList,
    required this.waktuUpdate,
    required this.imageCuaca,
    required this.airquality,
    required this.minTempC,
    required this.maxTempC,
    required this.moonPahase,
  });

  @override
  State<DetailMenuHome> createState() => _DetailMenuHomeState();
}

class _DetailMenuHomeState extends State<DetailMenuHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.defaultColor,
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
                    Text(widget.waktuLokal.toString()),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Image.network(
                      widget.imageCuaca!,
                      width: 60,
                      height: 60,
                    ),
                    Text('${widget.celciusCuaca}º C'),
                    Text(widget.kondisiCuaca!),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text('Terakhir update ${widget.waktuUpdate}'),
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.forecastHourList!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(width: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          Hour hour = widget.forecastHourList![index];
                          DateTime dateTime = DateTime.parse(hour.time!);
                          String formattedTime =
                              DateFormat('HH:mm').format(dateTime);
                          return CardCuacaPerjam(
                            iconCuaca: hour.condition?.icon,
                            suhuCuaca: '${hour.tempC}º',
                            waktuCuaca: formattedTime,
                          );
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
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CardDetailCuaca(
                                  iconDetailCuaca: CupertinoIcons.drop_fill,
                                  dataDetailCuaca:
                                      '${widget.kondisiKelembaban!} %',
                                  deskripsiDetailCuaca: 'Kelembaban'),
                              CardDetailCuaca(
                                  iconDetailCuaca: CupertinoIcons.gauge,
                                  dataDetailCuaca:
                                      '${widget.kondisiTekanan!} pHa',
                                  deskripsiDetailCuaca: 'Tekanan Udara'),
                              CardDetailCuaca(
                                  iconDetailCuaca: CupertinoIcons.moon_stars,
                                  dataDetailCuaca:
                                  widget.moonPahase!,
                                  deskripsiDetailCuaca: 'Moon Phase'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CardDetailCuaca(
                                  iconDetailCuaca: CupertinoIcons.thermometer,
                                  dataDetailCuaca: '${widget.maxTempC}° / ${widget.minTempC}°',
                                  deskripsiDetailCuaca: 'High / Low'
                              ),
                              CardDetailCuaca(
                                  iconDetailCuaca: CupertinoIcons.wind,
                                  dataDetailCuaca:
                                      '${widget.kondisiKecepatan!} km/h',
                                  deskripsiDetailCuaca: 'Kecepatan Angin'),
                              CardDetailCuaca(
                                  iconDetailCuaca: CupertinoIcons.cloud_fog,
                                  dataDetailCuaca:
                                      '${widget.kondisiKabut!} %',
                                  deskripsiDetailCuaca: 'Kabut'),
                            ],
                          ),
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