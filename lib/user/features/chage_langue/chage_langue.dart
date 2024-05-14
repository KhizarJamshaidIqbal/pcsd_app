// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pcsd_app/Providers/languge_change_provider.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/Onboarding/on_boarding_Screen.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Languges { english, urdu }

class ChagelangueScreen extends StatefulWidget {
  const ChagelangueScreen({super.key});

  @override
  State<ChagelangueScreen> createState() => _ChagelangueScreenState();
}

class _ChagelangueScreenState extends State<ChagelangueScreen> {
  int selectedLanguageIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<String> langugeTitle = [  'Urdu','English',];
    List<String> langugeSubtitle = [ 'اردو','انگریزی',];
    List<String> nationalFlags = [
      'assets/images/national_flags/pk.png',
      'assets/images/national_flags/us.png',
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: globalColors.primaryGradient,
          ),
          child: Consumer<LangugeChangeProvider>(
              builder: (context, provider, child) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  80.h,
                   CustomText(
                    text: AppLocalizations.of(context)!.selectYourLanguge,
                    color: globalColors.WhiteColor,
                    fontsize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  ...List.generate(
                    langugeTitle.length,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedLanguageIndex = index;
                        });
                        try {
                          if (index == 1) {
                            provider.chageLanguge(const Locale('en'));
                          } else {
                            provider.chageLanguge(const Locale('ur'));
                          }
                          print(index);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Card(
                        color: index == selectedLanguageIndex
                            ? globalColors.primaryColor
                            : globalColors.SecondaryColor,
                        shadowColor: globalColors.BlackColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: globalColors.WhiteColor,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                    nationalFlags[index],
                                  ),
                                ),
                              ),
                              10.w,
                              Expanded(
                                child: ListTile(
                                  title: CustomText(
                                    text: langugeTitle[index],
                                    color: globalColors.WhiteColor,
                                    fontsize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomText(
                                      text: langugeSubtitle[index],
                                      color: globalColors.WhiteColor,
                                      fontsize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 65,
                    child: RoundButton(
                      title: AppLocalizations.of(context)!.continueToNext,
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  10.h,
                ],
              ),
            );
          })),
    );
  }
}
