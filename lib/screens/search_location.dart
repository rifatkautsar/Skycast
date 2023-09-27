import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_search_controller.dart';
import '../utilities/TextColor.dart';
import '../utilities/color.dart';

class SearchLocationView extends StatefulWidget {
  final Function(String) onLocationSelected; // Add this line

  const SearchLocationView(
      {Key? key, required this.onLocationSelected}); // Modify the constructor

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  final TextEditingController _textEditingController = TextEditingController();

  final LocationSearchController locationController =
      Get.put(LocationSearchController());

  bool isClearButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    _textEditingController.addListener(() {
      setState(() {
        isClearButtonVisible = _textEditingController.text.isNotEmpty;
      });
    });
    return Scaffold(
      backgroundColor: ColorConst.defaultColor,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
            locationController.locations.clear();
          },
        ),
        title: Container(
          width: double.infinity,
          child: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: "Search Location...",
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          Visibility(
            visible: isClearButtonVisible,
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _textEditingController.clear();
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (locationController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (locationController.locations.isEmpty) {
                  return const Center(
                    child: Text(
                      'No locations found.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  {
                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        final location = locationController.locations[index];
                        return InkWell(
                          onTap: () {
                            String selectedLocation = location.name;
                            widget.onLocationSelected(selectedLocation);
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextColorAbu(
                                  valueTextAbu:
                                      '${location.region}, ${location.country}',
                                  size: 14.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                      itemCount: locationController.locations.length,
                    );
                  }
                }
              }),
            ),
            Visibility(
              visible: isClearButtonVisible,
              child: ElevatedButton(
                onPressed: () async {
                  await locationController.searchLocation(_textEditingController.text);
                },
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
