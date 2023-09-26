import 'dart:convert';

import 'package:get/get.dart';
import '../service/api_client.dart';
import '../models/weather_model.dart'; // Import your WeatherData model

class WeatherDataController extends GetxController {
  Rx<WeatherData?> weatherData = Rx<WeatherData?>(null);
  Rx<List<Hour>?> forecastHourList = Rx<List<Hour>?>(null);

  Future<void> fetchData(String location) async {
    try {
      final response = await ApiClient.fetchData(location);

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final weatherDataModel = WeatherData.fromJson(data);

          forecastHourList.value = weatherDataModel.forecast!.forecastday![0]?.hour;

        weatherData.value = weatherDataModel;
        print(response.body);
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (error) {
      print("Exception occurred: $error");
    }
  }
}

