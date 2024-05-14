// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, use_build_context_synchronously, prefer_final_fields, unused_field

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/Setting/profile_screen/profile_screen.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/widgets/CustomSnackbar.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/line.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pcsd_app/Providers/languge_change_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/CustomAppbar.dart';

enum Languges { english, urdu }

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;
  // Method to close application and clean data
  Future<void> _closeAndCleanApp(BuildContext context) async {
    await FirebaseAuthServices().deleteAccount();
    await FirebaseAuth.instance.signOut();
    // Clean data
    await _clearLocalData();

    exit(0);
  }

  // Method to clear local data
  Future<void> _clearLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomSnackbar.show(context, 'Some Error occurs',
        backgroundColor: Colors.red);
    await prefs.clear();
    // Clear all SharedPreferences data
    // You can also delete cached files, databases, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            40.h,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomText(
                text: AppLocalizations.of(context)!.ms,
                color: globalColors.WhiteColor,
                fontsize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            40.h,
            //Profile
            user == null
                ? Container()
                : Column(
                    children: [
                      line2(color: globalColors.WhiteColor),
                      20.h,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                user: FirebaseAuth.instance.currentUser,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            40.w,
                            SvgPicture.asset(
                              'assets/images/profile.svg',
                            ),
                            20.w,
                            CustomText(
                              text: AppLocalizations.of(context)!.mp,
                              color: globalColors.WhiteColor,
                              fontsize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: globalColors.WhiteColor,
                            ),
                            20.w,
                          ],
                        ),
                      ),
                      20.h,
                      line2(color: globalColors.WhiteColor),
                    ],
                  ),
            //Chage Languge
            Column(
              children: [
                user == null ? line2(color: globalColors.WhiteColor) : SizedBox(),
                20.h,
                Row(
                  children: [
                    20.w,
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/language.png',
                        color: globalColors.WhiteColor,
                      ),
                    ),
                    10.w,
                    CustomText(
                      text: AppLocalizations.of(context)!.cl,
                      color: Colors.white,
                      fontsize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    Spacer(),
                    Consumer<LangugeChangeProvider>(
                      builder: (context, provider, child) {
                        return PopupMenuButton(
                          iconSize: 35.0,
                          color: globalColors.WhiteColor,
                          iconColor: globalColors.WhiteColor,
                          onSelected: (Languges iteam) {
                            if (Languges.english.name == iteam.name) {
                              provider.chageLanguge(const Locale('en'));
                            } else {
                              provider.chageLanguge(const Locale('ur'));
                            }
                          },
                          itemBuilder: (context) => <PopupMenuEntry<Languges>>[
                            const PopupMenuItem(
                              value: Languges.english,
                              child: Text('English'),
                            ),
                            const PopupMenuItem(
                              value: Languges.urdu,
                              child: Text('اردو'),
                            ),
                          ],
                        );
                      },
                    ),
                    10.w,
                  ],
                ),
                20.h,
                line2(color: globalColors.WhiteColor),
              ],
            ),
            //Chage Theme
            // Column(
            //   children: [
            //     20.h,
            //     InkWell(
            //       onTap: () {},
            //       child: Row(
            //         children: [
            //           20.w,
            //           SizedBox(
            //               height: 50,
            //               width: 50,
            //               child: Image.asset('assets/images/language.png',)),
            //           10.w,
            //           CustomText(
            //             text: AppLocalizations.of(context)!.ct,
            //             color: Colors.white,
            //             fontsize: 16,
            //             fontWeight: FontWeight.w700,
            //           ),
            //         ],
            //       ),
            //     ),
            //     20.h,
            //     line2(color: globalColors.WhiteColor),
            //   ],
            // ),
        
            Spacer(),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: RoundButton(
                    title: AppLocalizations.of(context)!.deleteaccount,
                    textcolor: globalColors.WhiteColor,
                    backgroundColor: Color(0xffFF6B00),
                    borderSideColor: Color(0xffFF6B00),
                    onPress: () async {
                      setState(() {
                        _isLoading = false;
                      });
        
                      showAlertBox();
                    }),
              ),
            ),
            106.h,
          ],
        ),
        _isLoading
            ? Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: globalColors.WhiteColor.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: LoadingAnimationWidget.fallingDot(
                    color: globalColors.RedColor,
                    size: 110,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  void showAlertBox() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: globalColors.SecondaryColor,
            title: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: globalColors.RedColor,
                ),
                SizedBox(width: 10),
                CustomText(
                  text: 'Delete Account?',
                  color: globalColors.RedColor,
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            content: CustomText(
              text: "Do you want to delete your account?",
              color: globalColors.WhiteColor,
              fontsize: 18,
              fontWeight: FontWeight.bold,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: CustomText(
                  text: 'Cancel',
                  color: globalColors.WhiteColor,
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _closeAndCleanApp(context);
                },
                child: CustomText(
                  text: 'Yes',
                  color: globalColors.WhiteColor,
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      );
}
