import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/screens/detail_menu_home.dart';
import 'package:weather_app/screens/search_location.dart';
import 'package:weather_app/utilities/TextColor.dart';
import 'package:weather_app/utilities/color.dart';
import 'package:weather_app/widgets/custom_image_network.dart';
import 'package:weather_app/utilities/loading_shimmer.dart';
import 'package:weather_app/widgets/card_cuaca_harian.dart';
import 'package:weather_app/widgets/card_cuaca_perjam.dart';
import 'package:get/get.dart';

import '../controllers/weather_data_controller.dart';
import '../models/weather_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedValue = 'Bandung';

  bool isLoading = false;

  final TextEditingController locationController = TextEditingController();

  final WeatherDataController weatherController =
      Get.put(WeatherDataController());

  @override
  void initState() {
    super.initState();
    weatherController.fetchData(selectedValue);
  }

  WeatherDataController weatherControllers = Get.find();

  void updateView(String location) async {
    setState(() {
      selectedValue = location;
    });
    await weatherController.fetchData(location);
  }

  Future<void> fetchData(String location) async {
    Stopwatch stopwatch = Stopwatch()..start();

    try {
      await weatherController.fetchData(location);
    } catch (error) {
      throw Exception("Failed to fetch data: $error");
    }

    stopwatch.stop();

    // Check if elapsed time is too long (adjust the threshold as needed)
    if (stopwatch.elapsedMilliseconds > 5000) {
      // Manual API call
      setState(() {
        fetchData(selectedValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMMM y').format(now);
    return Scaffold(
        backgroundColor: ColorConst.defaultColor,
        body: FutureBuilder(
          future: weatherController.fetchData(selectedValue),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingHomeShimmer();
            } else if (snapshot.hasError) {
              return Center(
                  child: SafeArea(
                    child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                ),
              ),
                  ));
            } else {
              return SingleChildScrollView(
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
                            TextColorAbu(
                              valueTextAbu: selectedValue,
                              size: 18.0,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                Get.to(SearchLocationView(
                                    onLocationSelected: updateView));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Obx(() {
                          final weatherData =
                              weatherController.weatherData.value;
                          List<Hour>? forecastHourList =
                              weatherData?.forecast.forecastday![0].hour;

                          if (weatherData != null) {
                            final currentWeather = weatherData.current;

                            AirQuality airQuality = AirQuality(
                              co: currentWeather.airQuality?.co,
                              no2: currentWeather.airQuality?.no2,
                              o3: currentWeather.airQuality?.o3,
                              so2: currentWeather.airQuality?.so2,
                              pm2_5: currentWeather.airQuality?.pm2_5,
                              pm10: currentWeather.airQuality?.pm10,
                              usEpaIndex: currentWeather.airQuality?.usEpaIndex,
                              gbDefraIndex:
                                  currentWeather.airQuality?.gbDefraIndex,
                            );

                            return InkWell(
                              onTap: () {
                                Get.to(DetailMenuHome(
                                  celciusCuaca: currentWeather.tempC,
                                  kondisiCuaca: currentWeather.condition?.text,
                                  kondisiKelembaban: currentWeather.humidity,
                                  kondisiKecepatan: currentWeather.windKph,
                                  kondisiTekanan: currentWeather.pressureMb,
                                  kondisiKabut: currentWeather.cloud,
                                  nama_lokasi: weatherData.location.name,
                                  waktuLokal: weatherData.location.localtime,
                                  forecastHourList: forecastHourList,
                                  waktuUpdate: weatherData.location.localtime,
                                  imageCuaca: currentWeather.condition!.icon!
                                      .replaceAll('//', 'https://'),
                                  airquality: airQuality,
                                  minTempC: weatherData
                                      .forecast.forecastday![0].day!.mintempC,
                                  maxTempC: weatherData
                                      .forecast.forecastday![0].day!.maxtempC,
                                  moonPahase: weatherData.forecast
                                      .forecastday![0].astro!.moonPhase,
                                ));
                              },
                              child: Container(
                                height: 210.0,
                                padding: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorConst.black_color,
                                      ColorConst.black_color2
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(formattedDate),
                                    const SizedBox(height: 25.0),
                                    Row(
                                      children: [
                                        CustomNetworkImage(
                                          imageUrl: currentWeather
                                              .condition!.icon!
                                              .replaceAll('//', 'https://'),
                                          width: 80.0,
                                          height: 80.0,
                                          sizeIcon: 70.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(currentWeather.tempC
                                                .toString()),
                                            Text(currentWeather.condition!.text
                                                .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Text(
                                            'Terakhir update ${weatherData.location.localtime}'),
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            await fetchData(selectedValue);

                                            setState(() {
                                              selectedValue =
                                                  weatherData.location.name!;
                                            });

                                            setState(() {
                                              isLoading = false;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.restart_alt_outlined,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
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
                        Obx(() {
                          final weatherData =
                              weatherController.weatherData.value;
                          List<Hour>? forecastHourList =
                              weatherData?.forecast.forecastday![0].hour;

                          forecastHourList?.forEach((hour) {
                            if (hour.condition?.icon != null) {
                              hour.condition!.icon = hour.condition!.icon!
                                  .replaceAll('//', 'https://');
                            }
                          });

                          return SizedBox(
                            height: 150.0,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: forecastHourList!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                Hour hour = forecastHourList[index];
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
                          );
                        }),
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
                        Container(
                          height: 90.0,
                          decoration: BoxDecoration(
                            color: ColorConst.pink_color.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                              child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/heavy_rain.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Text(
                                            'Jangan Lupa Bawa Payung Ya',
                                            style: TextStyle(
                                              color: ColorConst.button_color,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -30,
                                right: -30,
                                child: ClipOval(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    color:
                                        ColorConst.pink_color.withOpacity(0.13),
                                    child: ClipOval(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(height: 15.0),
                        Obx(() {
                          final weatherData =
                              weatherController.weatherData.value;
                          List<Forecastday>? forecastDayList =
                              weatherData?.forecast.forecastday;
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              forecastDayList!.length,
                              (index) {
                                final forecastDay = forecastDayList[index];
                                DateTime date =
                                    DateTime.parse(forecastDay.date!);
                                String dateFormat =
                                    DateFormat('EEEE').format(date);
                                return CardCuacaHarian(
                                  icon_cuaca: forecastDay.day!.condition!.icon
                                      .toString()
                                      .replaceAll('//', 'https://'),
                                  hari: dateFormat,
                                  kondisi_cuaca: forecastDay
                                      .day!.condition!.text
                                      .toString(),
                                  drajat_cuaca:
                                      forecastDay.day!.maxtempC.toString(),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
