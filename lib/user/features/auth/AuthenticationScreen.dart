// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, dead_code, unused_local_variable, use_build_context_synchronously, non_constant_identifier_names


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/user/features/Welcome/WelcomeScreen.dart';
import 'package:pcsd_app/user/features/auth/Register.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/user/share/user_dashbord_screens.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import '../../../../widgets/line.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_btn_with_Icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Login.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseAuthServices authService = FirebaseAuthServices();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: globalColors.primaryGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      50.h,
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            // final String User =
                            //     'User${Random().nextInt(10000000000000).toString()}';
                            // final String id = DateTime.now()
                            //     .microsecondsSinceEpoch
                            //     .toString();
                            // await FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(id)
                            //     .set({
                            //   'id': id,
                            //   'name': User,
                            //   'email': User,
                            //   'profilePicture': '',
                            //   'token': '',
                            //   'dateCreated': DateTime.now(),
                            // });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ));
                          },
                          child: CustomText(
                            text: AppLocalizations.of(context)!.continueAsGuest,
                            color: globalColors.TitleColor,
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      40.h,
                      CustomText(
                        text: AppLocalizations.of(context)!.registerYourSelf,
                        color: globalColors.TitleColor,
                        fontsize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      5.h,
                      CustomText(
                        text: AppLocalizations.of(context)!.bdescription,
                        color: globalColors.TitleColor,
                        fontsize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      const Spacer(),
                      Center(
                        child: Lottie.asset(
                          "assets/images/security.json",
                          width: 340,
                          height: 340,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Spacer(),
                      5.h,
                      RoundButtonWithIcon(
                        icon: FontAwesomeIcons.google,
                        color: Colors.redAccent,
                        title: AppLocalizations.of(context)!.continueWithGoogle,
                        onpress: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          User? user = await authService.signInWithGoogle();
                          if (user != null) {
                            DocumentSnapshot userData = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(user.uid)
                                .get();

                            if (!userData.exists) {
                              // Save user data in Firestore
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .update({
                                'id': user.uid,
                                'name': user.displayName,
                                'email': user.email,
                                'profilePicture': user.photoURL,
                                'token': '',
                                'dateCreated': DateTime.now(),
                              });
                            }
                            //Local Notification Sender
                            PushNotifications.showSimpleNotification(
                              title: 'PCSD',
                              body:
                                  'Welcome to the Currency Scanning and Detection App!',
                              payload: 'notification_payload',
                            );
                            // Navigate to the next screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(),
                              ),
                            );
                            PushNotifications.showSimpleNotification(
                              title: 'PCSD',
                              body:
                                  "Wlecome to the Pakistani Currency Scanning and detection app",
                              payload: 'notification_payload',
                            );
                          } else {
                            // Handle sign in failure
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to sign in with Google'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      10.h,
                      RoundButtonWithIcon(
                        icon: FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        title:
                            AppLocalizations.of(context)!.continueWithFacebook,
                        onpress: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            User? user = await FirebaseAuthServices()
                                .signInWithFacebook();
                            if (user != null) {
                              DocumentSnapshot userData =
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .get();

                              if (!userData.exists) {
                                // Save user data in Firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .set({
                                  'name': user.displayName,
                                  'email': user.email,
                                  'profilePicture': user.photoURL,
                                  'token': '',
                                  'dateCreated': DateTime.now(),
                                });
                              }
                              //Local Notification Sender
                              PushNotifications.showSimpleNotification(
                                title: 'PCSD',
                                body:
                                    'Welcome to the Currency Scanning and Detection App!',
                                payload: 'notification_payload',
                              );
                              // Navigate to the next screen or perform other actions
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserDashbordScreens()),
                              );
                              PushNotifications.showSimpleNotification(
                                title: 'PCSD',
                                body:
                                    "Wlecome to the Pakistani Currency Scanning and detection app",
                                payload: 'notification_payload',
                              );
                            } else {
                              // Handle sign in failure
                              setState(() {
                                _isLoading = false;
                                _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Failed to sign in with Facebook'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            // Handle sign in error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error signing in with Facebook: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      20.h,
                      line(),
                      20.h,
                      Center(
                        child: RoundButton(
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ));
                          },
                          title: AppLocalizations.of(context)!.signUpWithEmail,
                        ),
                      ),
                      10.h,
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          },
                          child: CustomText(
                              text: AppLocalizations.of(context)!
                                  .alredyhaveAccount,
                              color: globalColors.TitleColor,
                              fontsize: 18,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.underline),
                        ),
                      ),
                      20.h,
                    ],
                  ),
                ),
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
                          color: globalColors.primaryColor,
                          size: 110,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
