import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utilities/color.dart';

class AppbarSkycast extends StatelessWidget implements PreferredSizeWidget {
  final String appbarName;

  AppbarSkycast({super.key, required this.appbarName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: Get.back,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorConst.black_color, ColorConst.black_color2], // Define your gradient colors here
          ),
        ),
      ),
      title: Center(
        child: Text(
          appbarName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white,),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
