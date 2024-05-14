// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, non_constant_identifier_names, unused_element, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/constants/validators.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/widgets/CustomSnackbar.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';
import '../../../../widgets/custom_textField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  FirebaseAuthServices authService = FirebaseAuthServices();
  final formKey = GlobalKey<FormState>();
  bool _isSigning = false;
  final TextEditingController EmailController = new TextEditingController();
  @override
  void dispose() {
    super.dispose();
    EmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColors.SecondaryColor,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.h,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // _GOBack();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: globalColors.TitleColor,
                          ),
                        ),
                      ],
                    ),
                    40.h,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.enterEmailAddress,
                          color: globalColors.TitleColor,
                          fontsize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        5.h,
                        CustomText(
                          text:
                              AppLocalizations.of(context)!.eAddressDescription,
                          color: globalColors.WhiteColor,
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        55.h,
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
                      ],
                    ),
                    const Spacer(),
                    RoundButton(
                        loading: _isSigning,
                        title: AppLocalizations.of(context)!.verifyEmailAddress,
                        onPress: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              _isSigning=true;
                            });
                            try {
                              await authService
                                  .resetPassword(EmailController.text);
                              setState(() {
                                _isSigning = true;
                                Navigator.pop(context);
                              });
                              CustomSnackbar.show(context,
                                  'Password reset email sent successfully',
                                  backgroundColor: Colors.green);
                            } catch (e) {
                              setState(() {
                              _isSigning=false;
                            });
                              CustomSnackbar.show(context, e.toString(),
                                  backgroundColor: Colors.red);
                            }
                          }
                        }),
                    20.h,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
