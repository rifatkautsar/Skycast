import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/detail_menu_home.dart';
import 'package:weather_app/utilities/color.dart';
import 'package:weather_app/widgets/card_cuaca_harian.dart';
import 'package:weather_app/widgets/card_cuaca_perjam.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedValue = 'Tanjungsiang, Subang'; // Initial selected value

  // List of items for the dropdown
  List<String> items = [
    'Tanjungsiang, Subang',
    'Garut',
    'Pangandaran',
    'Bandung',
    'Jakarta',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 24,
                      color: ColorConst.button_color,
                    ),
                    DropdownButton<String>(
                      value: selectedValue,
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style:
                                const TextStyle(color: ColorConst.button_color),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.search,
                      size: 24,
                      color: ColorConst.button_color,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                InkWell(
                  onTap: () {
                    Get.to(const DetailMenuHome());
                  },
                  child: Container(
                    height: 200.0,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorConst.black_color,
                          ColorConst.black_color2
                        ],
                      ),
                    ),
                    // color: ColorConst.blue_color,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text('Senin, 20 Desember 2021'),
                            Spacer(),
                            Text('3.30 PM'),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          children: [
                            Lottie.asset(
                              'assets/weather_anim.json',
                              // Replace with the URL to your Lottie animation JSON file
                              width: 80, // Set the width and height as needed
                              height: 80,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('18º C'),
                                Text('Hujan Berawan '),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Terakhir update 3.00 PM '),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Text(
                  'Cuaca Per Jam',
                  style: TextStyle(
                    color: ColorConst.button_color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
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
                  'Harian',
                  style: TextStyle(
                    color: ColorConst.button_color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 95.0,
                  child: Card(
                    color: ColorConst.pink_color.withOpacity(0.13),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/red_weather_icon.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.0,
                                child: Text(
                                  'Cuaca esok hari kemungkinan akan terjadi hujan di siang hari',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300.0,
                                child: Text(
                                  'Jangan Lupa Bawa Payung Ya',
                                  style: TextStyle(
                                    color: ColorConst.button_color,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const CardCuacaHarian(
                    icon_cuaca: 'assets/icon_petir.png',
                    hari: 'Senin',
                    kondisi_cuaca: 'Hujan Petir',
                    drajat_cuaca: '19º C '),
                const CardCuacaHarian(
                    icon_cuaca: 'assets/icon_petir.png',
                    hari: 'Selasa',
                    kondisi_cuaca: 'Cerah',
                    drajat_cuaca: '35º C '),
                const CardCuacaHarian(
                    icon_cuaca: 'assets/icon_petir.png',
                    hari: 'Rabu',
                    kondisi_cuaca: 'Hujan',
                    drajat_cuaca: '16º C '),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
