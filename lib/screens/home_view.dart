import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utilities/color.dart';

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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
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
                          style: TextStyle(color: ColorConst.button_color),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                  Spacer(),
                  Icon(
                    Icons.search,
                    size: 24,
                    color: ColorConst.button_color,
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 200.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [ColorConst.blue_color, ColorConst.blue_color2],
                  ),
                ),
                // color: ColorConst.blue_color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Senin, 20 Desember 2021'),
                        Spacer(),
                        Text('3.30 PM'),
                      ],
                    ),
                    SizedBox(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('18º C'),
                            Text('Hujan Berawan '),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Cuaca Per Jam',
                style: TextStyle(
                  color: ColorConst.button_color,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
