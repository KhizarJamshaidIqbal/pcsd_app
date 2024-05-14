import 'package:flutter/material.dart';
import 'package:pcsd_app/admin/features/home/video_preview.dart';
import 'package:pcsd_app/constants/app_size.dart';

import 'package:pcsd_app/widgets/custom_dropdown_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = 'Video';
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          20.h,
          CustomDropdownButton(
            items: const ['Video', 'App Logo', 'PNI_data'],
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue ?? 'Video';
              });
            },
          ),
          5.h,
          if (dropdownValue == 'Video')
          const VideoPreview()
        ],
      ),
    );
  }
}
