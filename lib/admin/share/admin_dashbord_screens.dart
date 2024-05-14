// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/admin/features/add_screen/add_screen.dart';
import 'package:pcsd_app/admin/features/home/home_screen.dart';
import 'package:pcsd_app/admin/features/users/user_screen.dart';
import 'package:pcsd_app/admin/share/custom_navigation_bar/custom_navigation_bar.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/widgets/CustomAppbar.dart';
import 'package:pcsd_app/widgets/CustomDrawer.dart';

class AdminDashbordScreens extends StatefulWidget {
  const AdminDashbordScreens({super.key});

  @override
  State<AdminDashbordScreens> createState() => _AdminDashbordScreensState();
}

class _AdminDashbordScreensState extends State<AdminDashbordScreens> {
  List<Widget> pages = <Widget>[
    const HomeScreen(),
    const AddDataScreen(),
    const UsersScreen(),
  ];
  int curentIndex = 0;
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    PushNotifications.getDeviceToken();
    PushNotifications.requestNotificationPermission();
    PushNotifications.firebaseInit(context);
    PushNotifications.isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColors.SecondaryColor,
      drawer: CustomDrawer(
        user: currentUser,
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          HomeAppBar(
            'Admin Panel',
            fontSize: 20,
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
          child: CustomNavigationBar(
            initialIndex: curentIndex,
            onIndexChanged: (index) {
              setState(() {
                curentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
