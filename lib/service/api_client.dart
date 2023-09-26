import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String apiKey = '2639061e276e41f89d934825231209';
  static const String baseUrl = 'http://api.weatherapi.com/v1';

  static Future<http.Response> fetchData(String location) async {
    String url = '$baseUrl/forecast.json?key=$apiKey&q=$location&days=7&aqi=yes&alerts=no';
    return await http.get(Uri.parse(url));
  }

  static Future<http.Response> searchLocation(String query) async {
    String url = '$baseUrl/search.json?key=$apiKey&q=$query';
    return await http.get(Uri.parse(url));
  }
}
