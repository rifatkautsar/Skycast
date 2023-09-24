import 'dart:convert';

import 'package:get/get.dart';
import '../service/api_client.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart'; // Import your WeatherData model

class WeatherDataController extends GetxController {
  Rx<WeatherData?> weatherData = Rx<WeatherData?>(null);
  Rx<List<Hour>?> forecastHourList = Rx<List<Hour>?>(null);

  RxList<Map<String, dynamic>> locations = <Map<String, dynamic>>[].obs;

  static Future<String?> searchLocation(String query) async {
    String apiUrl =
        "http://api.weatherapi.com/v1/search.json?key=2639061e276e41f89d934825231209&q=$query";

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;

    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }

  Future<void> fetchData(String location) async {
    try {
      final response = await ApiClient.fetchData(location);

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final weatherDataModel = WeatherData.fromJson(data);

        // Assuming hourly forecast is directly under forecastday[0].hour
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

