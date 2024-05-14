// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_element, unused_local_variable, use_build_context_synchronously, avoid_print, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pcsd_app/constants/validators.dart';
import 'package:pcsd_app/user/features/auth/Login.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';
import '../../../../widgets/CustomPasswordInputField.dart';
import '../../../../widgets/CustomSnackbar.dart';
import '../../../../widgets/custom_textField.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController NameController = new TextEditingController();

  final TextEditingController EmailController = new TextEditingController();

  final TextEditingController PasswordController = new TextEditingController();

  final TextEditingController ConfirmPasswordController =
      new TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    NameController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    ConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColors.SecondaryColor,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1.5,
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1.2,
                child: Column(
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
                      text: AppLocalizations.of(context)!.registerWithEmail,
                      color: globalColors.TitleColor,
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    5.h,
                    CustomText(
                      text: AppLocalizations.of(context)!.rDescription,
                      color: globalColors.WhiteColor,
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    35.h,
                    RoundedTextField(
                      hintText: AppLocalizations.of(context)!.enterYourName,
                      labelText: AppLocalizations.of(context)!.name,
                      icon: Icon(
                        Icons.person_outline,
                        color: globalColors.TitleColor,
                        size: 28,
                      ),
                      controller: NameController,
                      inputType: TextInputType.name,
                      validator: validateName,
                    ),
                    20.h,
                    RoundedTextField(
                      hintText: AppLocalizations.of(context)!.enterEmailAddress,
                      labelText: AppLocalizations.of(context)!.email,
                      icon: Icon(
                        Icons.email_outlined,
                        color: globalColors.TitleColor,
                        size: 28,
                      ),
                      controller: EmailController,
                      inputType: TextInputType.emailAddress,
                      validator: validateEmail,
                    ),
                    20.h,
                    CustomPasswordInputField(
                      controller: PasswordController,
                      hintText: AppLocalizations.of(context)!.enterPassword,
                      labelText: AppLocalizations.of(context)!.password,
                      validator: (value) =>
                          validatePassword(value, EmailController.text),
                    ),
                    20.h,
                    CustomPasswordInputField(
                      controller: ConfirmPasswordController,
                      hintText:
                          AppLocalizations.of(context)!.enterconfirmPassword,
                      labelText: AppLocalizations.of(context)!.confirmPassword,
                      validator: (value) => validateconfirmPassword(
                          value, PasswordController.text),
                    ),
                    const Spacer(),
                    RoundButton(
                        title: AppLocalizations.of(context)!.continueButton,
                        loading: isSigningUp,
                        onPress: () {
                          _signUp(context);
                        }),
                    10.h,
                    Row(
                      children: [
                        const Spacer(),
                        CustomText(
                          text: AppLocalizations.of(context)!
                              .alreadyHaveAnAccount,
                          color: globalColors.TitleColor,
                          fontsize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        5.w,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          },
                          child: CustomText(
                              text: AppLocalizations.of(context)!.login,
                              color: globalColors.TitleColor,
                              fontsize: 18,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.underline),
                        ),
                        const Spacer(),
                      ],
                    ),
                    30.h,
                    Spacer(),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isSigningUp = true;
      });

      final String name = NameController.text;
      final String email = EmailController.text;
      final String password = PasswordController.text;

      try {
        // Create the user in Firebase Auth
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Update the user's display name
        await userCredential.user!.updateDisplayName(name);
        final id = DateTime.now().millisecondsSinceEpoch.toString();
        // Save user data to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'id': userCredential.user!.uid,
          'name': name,
          'email': email,
          'password': password,
          'profilePicture': '',
          "token": '',
          'dateCreated': DateTime.now(),
        });

        print("User signed up and data saved to Firestore");
        CustomSnackbar.show(context,
            'Your Successfully SignUp in Pakistan Currency Scanning And Detection App',
            backgroundColor: Colors.green);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          print('The email address is already in use.');
          CustomSnackbar.show(context, 'The email address is already in use.',
              backgroundColor: Colors.red);
        } else {
          print("Error signing up or saving data: $e");
          CustomSnackbar.show(context, 'Some Error occurs',
              backgroundColor: Colors.red);
        }
      } catch (e) {
        print("Error signing up or saving data: $e");
        CustomSnackbar.show(context, 'Some Error occurs',
            backgroundColor: Colors.red);
      }
      setState(() {
        isSigningUp = false;
      });
    }
  }
}
