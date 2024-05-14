// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters, deprecated_member_use, avoid_print, use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/custom_textField.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';

class UpdateEmailScreen extends StatefulWidget {
  final User user;

  const UpdateEmailScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateEmailScreenState createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  late TextEditingController _emailController;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _updateEmail() async {
    String newEmail = _emailController.text.toString();
    if (newEmail.isNotEmpty) {
      try {
        setState(() {
          _loading = true;
        });
        await widget.user.updateEmail(newEmail);
        Navigator.pop(context);
      } catch (e) {
        print('Error updating email: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update email. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Email cannot be empty.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.h,
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: globalColors.WhiteColor,
                  size: 35,
                ),
              ),
              20.h,
              CustomText(
                  text: 'What’s Your Email Address?',
                  color: globalColors.WhiteColor,
                  fontsize: 20),
              10.h,
              CustomText(
                  text:
                      'Edit or change your Email to continue to PCSD Service',
                  color: globalColors.WhiteColor,
                  fontsize: 16),
              50.h,
              RoundedTextField(
                labelText: 'Edit your Name',
                controller: _emailController,
                icon: Icon(
                  Icons.person_outline_outlined,
                  color: globalColors.WhiteColor,
                ),
              ),
              Spacer(),
              RoundButton(
                title: 'Save',
                onPress: _updateEmail,
                loading: _loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
