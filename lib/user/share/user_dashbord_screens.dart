import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/Dashboard/HomeScreen.dart';
import 'package:pcsd_app/user/features/Setting/Setting.dart';
import 'package:pcsd_app/user/features/UVLight/UVLightScreen.dart';
import 'package:pcsd_app/user/features/video_screen/video_screen.dart';
import 'package:pcsd_app/user/share/custom_navigation_bar/custom_navigation_bar.dart';
import 'package:pcsd_app/widgets/CustomAppbar.dart';
import 'package:pcsd_app/widgets/CustomDrawer.dart';
import 'package:pcsd_app/widgets/floating_action_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class UserDashbordScreens extends StatefulWidget {
  const UserDashbordScreens({super.key});

  @override
  State<UserDashbordScreens> createState() => _UserDashbordScreensState();
}

class _UserDashbordScreensState extends State<UserDashbordScreens> {

  
  List<Widget> pages = <Widget>[
    const HomeScreen(),
    const VideoScreen(),
    UVLightScreen(),
    const Setting(),
  ];

  int curentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          HomeAppBar(
            AppLocalizations.of(context)!.appBarTitle,
            fontSize: 20.0,
          ),
        ],
        body: Container(
            width: double.infinity,
            decoration:
                const BoxDecoration(gradient: globalColors.primaryGradient),
            child: pages[curentIndex]),
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          child: CustomNavigationBarMain(
            initialIndex: curentIndex,
            onIndexChanged: (index) {
              setState(() {
                curentIndex = index;
              });
            },
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton:
          curentIndex == 0 ? const CustomFloatingActionButton() : null,
    );
  }
}
