// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, deprecated_member_use, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pcsd_app/user/features/Setting/profile_screen/profile_screen.dart';
import 'package:pcsd_app/user/features/auth/Login.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/user/features/scanner/scanner.dart';
import 'package:pcsd_app/widgets/CustomSnackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/privacypolicy.dart';
import 'line.dart';

class CustomDrawer extends StatelessWidget {
  final User? user;
  CustomDrawer({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    Future<void> _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Widget drawerHeader = user != null
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: currentUser,
                    ),
                  ));
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(gradient: globalColors.primaryGradient),
              accountEmail: Text(user!.email ?? ''),
              accountName: Text(user!.displayName ?? ''),
              currentAccountPicture: user!.photoURL != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: globalColors.WhiteColor,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!),
                      ),
                    )
                  : FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          if (data['profilePicture'] == null ||
                              data['profilePicture'].isEmpty) {
                            return CircleAvatar(
                              backgroundColor: globalColors.WhiteColor,
                              child: Text(
                                FirebaseAuth
                                    .instance.currentUser!.displayName![0]
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: globalColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: globalColors.WhiteColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  data['profilePicture'],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        }

                        return CircularProgressIndicator(
                          color: globalColors.WhiteColor,
                        );
                      },
                    ),

              // CircleAvatar(
              //     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              //     child: Text(
              //       user!.displayName![0].toUpperCase(),
              //       style: TextStyle(
              //         color: Color.fromARGB(255, 37, 182, 9),
              //         fontSize: 24,
              //       ),
              //     ),
              //   ),
            ),
          )
        : DrawerHeader(
            decoration: BoxDecoration(gradient: globalColors.primaryGradient),
            child: SvgPicture.asset("assets/images/PCSAD_Logo.svg"),
          );
    return Drawer(
      surfaceTintColor: globalColors.WhiteColor,
      clipBehavior: Clip.none,
      width: MediaQuery.of(context).size.width * .65,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          drawerHeader,
          Column(
            children: [
              5.h,
              ListTile(
                title: FittedBox(
                  child: Text(
                    AppLocalizations.of(context)!.scn,
                    style: TextStyle(
                        color: globalColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter"),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 25,
                      width: 25,
                      child:
                          SvgPicture.asset("assets/images/Camera_Icon_2.svg")),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scanner(),
                      ));
                },
              ),
              line2(),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.sh,
                  style: TextStyle(
                      color: globalColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 25,
                      width: 20,
                      child: SvgPicture.asset("assets/images/Share.svg")),
                ),
                onTap: () async {
                  try {
                    Share.share(
                        "https://play.google.com/store/apps/details?id=com.sharasol.PKR_Fake_Check_Guide");
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
              line2(),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.ru,
                  style: TextStyle(
                      color: globalColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 25,
                      width: 20,
                      child: SvgPicture.asset("assets/images/Rate_us.svg")),
                ),
                onTap: () {
                  // StoreRedirect.redirect(
                  //   androidAppId: "com.sharasol.PKR_Fake_Check_Guide",
                  // );
                  try {
                    StoreRedirect.redirect(
                        androidAppId: "com.iyaffle.rangoli",
                        iOSAppId: "585027354");
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              line2(),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.ma,
                  style: TextStyle(
                      color: globalColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 25,
                      width: 20,
                      child:
                          SvgPicture.asset("assets/images/More_Apps_Icon.svg")),
                ),
                onTap: () {
                  _launchURL(
                      "https://play.google.com/store/apps/dev?id=8994386378575122109&hl=en_IN");
                },
              ),
              line2(),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.fb,
                  style: TextStyle(
                      color: globalColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 25,
                      width: 20,
                      child: SvgPicture.asset("assets/images/Feedback.svg")),
                ),
                onTap: () {
                  launch('mailto:21101001-058@uskt.edu.pk');
                },
              ),
              line2(),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.pp,
                  style: TextStyle(
                      color: globalColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 25,
                      width: 20,
                      child:
                          SvgPicture.asset("assets/images/PrivacyPolicy.svg")),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicy(),
                      ));
                },
              ),
              line2(),
              30.h,
              // ListTile(
              //   title: const Text(
              //     'Report',
              //     style: TextStyle(
              //         color: globalColors.primaryColor,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //         fontFamily: "Inter"),
              //   ),
              //   leading: Padding(
              //     padding: const EdgeInsets.only(left: 5),
              //     child: SizedBox(
              //         height: 25,
              //         width: 20,
              //         child: SvgPicture.asset("assets/images/Report.svg")),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => PrivacyPolicy(),
              //         ));
              //   },
              // ),

              //Auth Login and Logout
              currentUser != null
                  ? ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.lagout,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter"),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SizedBox(
                            height: 25,
                            width: 20,
                            child:
                                SvgPicture.asset("assets/images/Lagout.svg")),
                      ),
                      onTap: () async {
                        FirebaseAuthServices authService =
                            FirebaseAuthServices();
                        try {
                          await authService.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                          CustomSnackbar.show(context, 'Logout',
                              backgroundColor: Colors.red);
                        } catch (e) {
                          print('Error signing out: $e');
                          // CustomSnackbar.show(context, 'Error signing out: $e',
                          //     backgroundColor: Colors.red);
                        }
                        FirebaseAuth.instance.signOut().then((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                          CustomSnackbar.show(context, 'Logout',
                              backgroundColor: Colors.red);
                        }).catchError((error) {
                          print('Error signing out: $error');
                        });
                      },
                    )
                  : ListTile(
                      title: Text(
                        'Login here...',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter"),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: SizedBox(
                          height: 45,
                          width: 40,
                          child: Image.asset(
                            "assets/images/login_icon.png",
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      onTap: () async {
                        FirebaseAuthServices authService =
                            FirebaseAuthServices();
                        try {
                          // await authService.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                          CustomSnackbar.show(context, 'Login',
                              backgroundColor: Colors.blue);
                        } catch (e) {
                          print('Error signing out: $e');
                          // CustomSnackbar.show(context, 'Error signing out: $e',
                          //     backgroundColor: Colors.red);
                        }
                        FirebaseAuth.instance.signOut().then((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                          CustomSnackbar.show(context, 'Login here...',
                              backgroundColor: Colors.blue);
                        }).catchError((error) {
                          print('Error signing out: $error');
                        });
                      },
                    ),

              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Container(
                    height: 1,
                    width: 120,
                    color: globalColors.primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.appVersion,
                        style: TextStyle(
                            fontSize: 18,
                            color: globalColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter"),
                      ),
                      Text(
                        "1.0.0+1",
                        style: TextStyle(
                            fontSize: 12,
                            color: globalColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter"),
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    width: 120,
                    color: globalColors.primaryColor,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
