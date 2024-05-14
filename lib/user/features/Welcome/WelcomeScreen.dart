// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/share/user_dashbord_screens.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();
    // Set a timer to hide the animation after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: globalColors.primaryGradient,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  90.h,
                  const CustomText(
                      text:
                          'Welcome to the Currency Scanning\nAnd Detection App!',
                      color: globalColors.TitleColor,
                      fontsize: 18,
                      fontWeight: FontWeight.bold),
                  10.h,
                  const CustomText(
                      text:
                          'With a simple scan, you can verify your currency notes.  Say goodbye to Fake currency and secure your financial transactions with confidence.',
                      color: globalColors.WhiteColor,
                      fontsize: 14,
                      fontWeight: FontWeight.w500),
                  const Spacer(),
                  Center(
                    child: Lottie.asset(
                      "assets/images/welcome.json",
                      width: 340,
                      height: 340,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  const CustomText(
                      text:
                          'By clicking on Next, you agree to PCS&D Terms and \nConditions of Use.',
                      color: globalColors.WhiteColor,
                      fontsize: 13,
                      fontWeight: FontWeight.w500),
                  12.h,
                  RoundButton(
                    title: "Continue",
                    onPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDashbordScreens(),
                          ));
                    },
                  ),
                  const SizedBox(height: 30),
                  30.h,
                ],
              ),
            ),
            _showAnimation
                ? Positioned(
                    top: 20,
                    left: -200,
                    right: 0,
                    child: Lottie.asset(
                      "assets/images/lottieAnimation/startAnimation.json",
                      width: 800,
                      height: 800,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
