// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/user/features/Onboarding/on_boarding_Screen.dart';
import 'package:pcsd_app/user/features/chage_langue/chage_langue.dart';
import 'package:pcsd_app/user/share/user_dashbord_screens.dart';
import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              seenOnboard == true ? UserDashbordScreens() : ChagelangueScreen(),
        ),
      ),
    );

    // PushNotifications.getDeviceToken();
    
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => HomeScreen()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: globalColors.primaryGradient),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/front-5000.jpg',
                  width: 300,
                )),
                Center(
                  child: Lottie.asset(
                    'assets/images/scanner_2.json',
                  ),
                ),
                // SvgPicture.asset('assets/images/MP.svg')
              ],
            )));
  }
}
