// ignore_for_file: file_names, unused_local_variable, prefer_final_fields, use_super_parameters, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/auth/AuthenticationScreen.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../../model/onboardingscreen_components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  Future setSeenonboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenonboard();
  }

  void _navigateToNext(List<OnBoarding> onboarding_data) {
    if (currentPage < onboarding_data.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {}
  }

  void _navigateToBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoarding> onboarding_data = [
      OnBoarding(
        title: AppLocalizations.of(context)!.onboardingTitle_1,
        image: "assets/images/scanner.json",
        Description: AppLocalizations.of(context)!.onboardingDescription_1,
      ),
      OnBoarding(
        title: AppLocalizations.of(context)!.onboardingTitle_2,
        image: "assets/images/info.json",
        Description: AppLocalizations.of(context)!.onboardingDescription_2,
      ),
      OnBoarding(
        title: AppLocalizations.of(context)!.onboardingTitle_3,
        image: "assets/images/shaild_2.json",
        Description: AppLocalizations.of(context)!.onboardingDescription_3,
      ),
    ];
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1.3,
        decoration: BoxDecoration(gradient: globalColors.primaryGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboarding_data.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        55.h,
                        currentPage < 1
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AuthenticationScreen(),
                                          ));
                                    },
                                    child: CustomText(
                                        text:
                                            AppLocalizations.of(context)!.skip,
                                        color: globalColors.WhiteColor,
                                        fontsize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          globalColors.primaryColor,
                                      radius: 18,
                                      child: IconButton(
                                          onPressed: () {
                                            _navigateToBack();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            size: 20,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AuthenticationScreen(),
                                          ));
                                    },
                                    child: CustomText(
                                        text:
                                            AppLocalizations.of(context)!.skip,
                                        color: globalColors.WhiteColor,
                                        fontsize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                        50.h,
                        CustomText(
                            text: onboarding_data[index].title,
                            color: globalColors.TitleColor,
                            fontsize: 20,
                            fontWeight: FontWeight.bold),
                        10.h,
                        CustomText(
                            text: onboarding_data[index].Description,
                            color: globalColors.WhiteColor,
                            fontsize: 14,
                            fontWeight: FontWeight.w400),
                        Spacer(),
                        Expanded(
                          child: Lottie.asset(
                            onboarding_data[index].image,
                            width: 340,
                            height: 340,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboarding_data.length,
                      (index) => AnimatedContainer(
                        margin: const EdgeInsets.only(right: 5.0),
                        duration: const Duration(milliseconds: 500),
                        height: 10,
                        width: currentPage == index ? 25 : 10,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? globalColors.primaryColor
                              : globalColors.WhiteColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60)),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      currentPage > 1
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthenticationScreen()),
                            )
                          : _navigateToNext(onboarding_data);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(color: globalColors.WhiteColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomText(
                              text: AppLocalizations.of(context)!.next,
                              color: globalColors.WhiteColor,
                              fontsize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.arrow_forward_ios_sharp,
                                color: globalColors.WhiteColor),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              30.h
            ],
          ),
        ),
      ),
    );
  }
}
