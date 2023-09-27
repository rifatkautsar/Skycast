import 'dart:convert';
import 'package:get/get.dart';
import 'package:weather_app/models/search_location_model.dart';
import '../service/api_client.dart';

class LocationSearchController extends GetxController {
  RxList<LocationSearch> locations = <LocationSearch>[].obs;
  RxBool isLoading = false.obs;

  Future<void> searchLocation(String query) async {
    isLoading.value = true;

    final response = await ApiClient.searchLocation(query);

    isLoading.value = false;

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data is List) {
        List<LocationSearch> locationsData = data.map((location) {
          return LocationSearch.fromJson(location);
        }).toList();

        locations.assignAll(locationsData);
      } else {
        throw Exception("Data is not in the expected format");
      }
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }
}
