// ignore_for_file: avoid_print, unused_import

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/constants/validators.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/widgets/custom_textField.dart';
import 'package:pcsd_app/widgets/custom_toast.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';

class NotificationSenderScreen extends StatefulWidget {
  const NotificationSenderScreen({super.key});

  @override
  State<NotificationSenderScreen> createState() =>
      _NotificationSenderScreenState();
}

class _NotificationSenderScreenState extends State<NotificationSenderScreen> {
  bool isLoding = false;
  final TextEditingController notificationTitleController =
      TextEditingController();
  final TextEditingController notificationBodyController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  get http => null;
  @override
  void dispose() {
    super.dispose();
    notificationTitleController.dispose();
    notificationBodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          20.h,
          RoundedTextField(
            labelText: 'Title',
            hintText: 'Enter the title of the notification',
            validator: validateNotificationTitle,
            controller: notificationTitleController,
            icon: const Icon(
              CupertinoIcons.pencil,
              color: globalColors.WhiteColor,
            ),
          ),
          20.h,
          RoundedTextField(
            labelText: 'Body',
            hintText: 'Enter the body of the notification',
            validator: validateNotificationbody,
            controller: notificationBodyController,
            icon: const Icon(
              CupertinoIcons.pencil,
              color: globalColors.WhiteColor,
            ),
          ),
          220.h,
          RoundButton(
            loading: isLoding,
            // Update the onPress method in NotificationSenderScreen
            onPress: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoding = true;
                });
                try {
                  print('Notification Sent Successfully');
                  showToast(context, 'Notification Sent Successfully',
                      globalColors.primaryColor);
                  PushNotifications.showSimpleNotification(
                    title: notificationTitleController.text,
                    body: notificationBodyController.text,
                    payload: 'notification_payload',
                  );

                  setState(() {
                    isLoding = false;
                  });
                  print(
                      'Notification Sent: ${notificationTitleController.text}\n${notificationBodyController.text}');
                } catch (e) {
                  print('Notification Failed to Send\n Error: $e');
                  setState(() {
                    isLoding = false;
                  });
                  CustomToast(
                    message: 'Notification Failed to Send\n Error: $e',
                    backgroundColor: globalColors.RedColor,
                  );
                }
              }
              setState(() {});
            },
            title: 'Send Notification',
          ),
        ],
      ),
    );
  }
}
