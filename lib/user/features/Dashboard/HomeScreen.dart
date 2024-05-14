// ignore_for_file: prefer_const_constructors, sort_child_properties_last, file_names, unused_element, non_constant_identifier_names, unused_import, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/user/features/Dashboard/PNI.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/privacypolicy.dart';
import '../../../model/static_PNI.dart';
import '../../../widgets/CustomAppbar.dart';
import '../../../widgets/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  // ScrollController scrollController = ScrollController();

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic list = Pakistan_Note_api.PNI_data;
  int _selectedIndex = -1;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    super.initState();
    // PushNotifications.getDeviceToken();
    // PushNotifications.requestNotificationPermission();
    // PushNotifications.firebaseInit(context);
    // PushNotifications.isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        // height: double.infinity,
        decoration: BoxDecoration(
          gradient: globalColors.primaryGradient,
        ),
        child: ListView.builder(
          // controller: widget.scrollController,
          shrinkWrap: true,
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (_selectedIndex == index) {
                      // If tapped iteam is  Selected when tapped again then deselect it
                      _selectedIndex = -1;
                    } else {
                      // Otherwise, select the tapped item
                      _selectedIndex = index;
                    }
                  });
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: _selectedIndex == index
                              ? globalColors.WhiteColor
                              : Colors.transparent,
                          width: _selectedIndex == index ? 6 : 0,
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          child: Image.asset(
                            "${list[index]["thumbnailUrl"]}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    _selectedIndex == index
                        ? Positioned(
                            top: 65,
                            left: 140,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PNI_details(
                                        imgeUrl: list[index]["PNI_Images"],
                                        Title: list[index]["RS"],
                                        initialIndex: index,
                                      ),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: globalColors.primaryColor
                                              .withOpacity(0.5),
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                          offset: Offset(0, 4))
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: globalColors.primaryColor
                                        .withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.white, width: 4)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 12, right: 12),
                                  child: Text(
                                    AppLocalizations.of(context)!.viewNow,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: globalColors.WhiteColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
