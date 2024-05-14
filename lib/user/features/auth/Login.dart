// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, non_constant_identifier_names, must_be_immutable, unused_field, override_on_non_overriding_member, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously, unused_element, unnecessary_null_comparison, unused_local_variable, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pcsd_app/constants/validators.dart';
import 'package:pcsd_app/controllers/notification_service.dart';
import 'package:pcsd_app/user/features/auth/ResetPassword.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/Welcome/WelcomeScreen.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/user/share/user_dashbord_screens.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';
import '../../../../widgets/CustomPasswordInputField.dart';
import '../../../../widgets/CustomSnackbar.dart';
import '../../../../widgets/custom_textField.dart';
import '../../../../widgets/line.dart';
import '../../../../widgets/rounded_btn_with_Icon.dart';
import 'Register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isSigning = false;
  bool _isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthServices authService = FirebaseAuthServices();
  final formKey = GlobalKey<FormState>();
  final TextEditingController EmailController = new TextEditingController();
  final TextEditingController PasswordController = new TextEditingController();

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColors.SecondaryColor,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        60.h,
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: globalColors.TitleColor,
                          ),
                        ),
                        40.h,
                        CustomText(
                          text: AppLocalizations.of(context)!.signIn,
                          color: globalColors.TitleColor,
                          fontsize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        5.h,
                        CustomText(
                          text: AppLocalizations.of(context)!.sDescription,
                          color: globalColors.WhiteColor,
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        35.h,
                        RoundedTextField(
                          hintText:
                              AppLocalizations.of(context)!.enterEmailAddress,
                          labelText: AppLocalizations.of(context)!.email,
                          validator: validateEmail,
                          icon: Icon(
                            Icons.email_outlined,
                            color: globalColors.TitleColor,
                            size: 28,
                          ),
                          controller: EmailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        20.h,
                        CustomPasswordInputField(
                          controller: PasswordController,
                          hintText: AppLocalizations.of(context)!.enterPassword,
                          labelText: AppLocalizations.of(context)!.password,
                          validator: (value) =>
                              validatePassword(value, EmailController.text),
                        ),
                        10.h,
                        Row(
                          children: [
                            const Spacer(),
                            CustomText(
                              text: AppLocalizations.of(context)!
                                  .forgetYourPassword,
                              color: globalColors.TitleColor,
                              fontsize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                            5.w,
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPassword(),
                                    ));
                              },
                              child: CustomText(
                                  text: AppLocalizations.of(context)!
                                      .resetPassword,
                                  color: globalColors.TitleColor,
                                  fontsize: 18,
                                  fontWeight: FontWeight.bold,
                                  textDecoration: TextDecoration.underline),
                            ),
                            const Spacer(),
                          ],
                        ),
                        30.h,
                        line(),
                        30.h,
                        RoundButtonWithIcon(
                          // image: 'assets/images/Google.jpg',
                          icon: FontAwesomeIcons.google,
                          color: Colors.redAccent,
                          title:
                              AppLocalizations.of(context)!.continueWithGoogle,
                          onpress: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            User? user = await authService.signInWithGoogle();
                            if (user != null) {
                              // Check if user data already exists in Firestore
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
                                    .update({
                                  'id': user.uid,
                                  'name': user.displayName,
                                  'email': user.email,
                                  'profilePicture': user.photoURL,
                                  'token': '',
                                  'dateCreated': DateTime.now(),
                                });
                              }
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
                                  content:
                                      Text('Failed to sign in with Google'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                        10.h,
                        RoundButtonWithIcon(
                          color: Colors.blue,
                          // image: 'assets/images/Facebook.jpg',
                          icon: FontAwesomeIcons.facebook,
                          title: AppLocalizations.of(context)!
                              .continueWithFacebook,
                          onpress: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              User? user = await FirebaseAuthServices()
                                  .signInWithFacebook();
                              if (user != null) {
                                // Navigate to the next screen or perform other actions
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserDashbordScreens()),
                                );
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                // Handle sign in failure
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
                                  content: Text(
                                      'Error signing in with Facebook: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                        const Spacer(),
                        RoundButton(
                            title: AppLocalizations.of(context)!.continueButton,
                            loading: _isSigning,
                            onPress: () {
                              _signIn();
                            }),
                        10.h,
                        Row(
                          children: [
                            const Spacer(),
                            CustomText(
                              text: AppLocalizations.of(context)!
                                  .dontHaveAnAccount,
                              color: globalColors.TitleColor,
                              fontsize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                            5.w,
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ));
                              },
                              child: CustomText(
                                  text: AppLocalizations.of(context)!.signUp,
                                  color: globalColors.TitleColor,
                                  fontsize: 18,
                                  fontWeight: FontWeight.bold,
                                  textDecoration: TextDecoration.underline),
                            ),
                            const Spacer(),
                          ],
                        ),
                        20.h,
                      ],
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
        ),
      ),
    );
  }

  void _signIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isSigning = true;
      });
      String email = EmailController.text;
      String password = PasswordController.text;

      try {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        setState(() {
          _isSigning = false;
          _isLoading = false;
        });

        // User sign-in successful
        print("Successfully signed in");
        CustomSnackbar.show(context, 'Sign-In successful',
            backgroundColor: Colors.green);

        Navigator.push(
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
      } catch (e) {
        // Handle sign-in failure
        print("Error signing in: $e");
        CustomSnackbar.show(context, 'Error during sign-in\n Error: $e',
            backgroundColor: Colors.red);
        setState(() {
          _isSigning = false;
          _isLoading = false;
        });
      }
    }
  }
}
