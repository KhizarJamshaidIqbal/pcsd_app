// ignore_for_file: file_names, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, override_on_non_overriding_member, override_on_non_overriding_member, unused_field, unused_local_variable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_super_parameters, duplicate_ignore, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';

//CustomHomeScreenAppbar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  HomeAppBar(
    this.title, {
    super.key,
    this.fontSize = 16.0,
  });
  final String title;
  final double fontSize;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final currentuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      centerTitle: true,
      iconTheme: IconThemeData(color: globalColors.WhiteColor),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: FutureBuilder<bool>(
              future: FirebaseAuthServices.isLoggedIn(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: globalColors.WhiteColor,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data!
                      ? currentuser!.photoURL != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10, top: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: globalColors.WhiteColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: globalColors.WhiteColor,
                                  backgroundImage:
                                      NetworkImage(currentuser!.photoURL!),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10, top: 0),
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: SvgPicture.asset(
                                  "assets/images/Drawer_Icon_2.svg",
                                ),
                              ),
                            )
                      : Padding(
                          padding: const EdgeInsets.only(left: 10, top: 0),
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              "assets/images/Drawer_Icon_2.svg",
                            ),
                          ),
                        );
                }
              },
            ),
          );
        },
      ),
      title: OverflowTextAnimated(
        text: "  " + title + "  ",
        style: const TextStyle(
            color: globalColors.WhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        curve: Curves.fastEaseInToSlowEaseOut,
        animation: OverFlowTextAnimations.infiniteLoop,
        animateDuration: const Duration(milliseconds: 1000),
        delay: const Duration(milliseconds: 100),
      ),
      elevation: 0.9,
      backgroundColor: globalColors.primaryColor,
    );
  }
}

//CustomSettingScreenAppbar
class MyCustomAppBar extends StatelessWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      backgroundColor: Color(0xff1F8536),
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: globalColors.WhiteColor),
      title: Text(
        "More Settings",
        style: TextStyle(
          color: globalColors.WhiteColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
