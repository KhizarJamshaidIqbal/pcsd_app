// ignore_for_file: avoid_returning_null_for_void, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:pcsd_app/admin/features/add_screen/notification_sender_screen/notification_sender_screen.dart';
import 'package:pcsd_app/admin/features/add_screen/video_screen/video.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/custom_dropdown_button.dart';
// import 'package:pcsd_app/widgets/rounded_btn.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  String dropdownValue = 'Video';
  bool isloading = false;
  String rs = '';
  String title = '';
  String videoUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColors.SecondaryColor,
      body: Container(
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.h,
              const CustomText(
                text: 'Select Data Store Path',
                color: globalColors.WhiteColor,
                fontsize: 20,
                fontWeight: FontWeight.bold,
              ),
              20.h,
              CustomDropdownButton(
                items: const ['Video', 'Send Notification'],
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue ?? 'Video';
                  });
                },
              ),
              5.h,
              if (dropdownValue == 'Video')
                const Expanded(
                  child: Video(),
                ),
              if (dropdownValue == 'Send Notification')
                const Expanded(
                  child: NotificationSenderScreen(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
