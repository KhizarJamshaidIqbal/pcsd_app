// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, use_super_parameters, library_private_types_in_public_api, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/custom_textField.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';

class UpdateNameScreen extends StatefulWidget {
  final User user;
  const UpdateNameScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateNameScreenState createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  late TextEditingController _nameController;

  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateName() async {
    String newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      try {
        setState(() {
          _loading = true;
        });
        await widget.user.updateDisplayName(newName);
        Navigator.pop(context);
      } catch (e) {
        print('Error updating name: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update name. Please try again later.'),
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
          content: Text('Name cannot be empty.'),
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
                  text: 'What’s Your Name?',
                  color: globalColors.WhiteColor,
                  fontsize: 20),
              10.h,
              CustomText(
                  text:
                      'Edit or change your full name to continue to PCSD Service',
                  color: globalColors.WhiteColor,
                  fontsize: 16),
              50.h,
              RoundedTextField(
                labelText: 'Edit your Name',
                controller: _nameController,
                icon: Icon(
                  Icons.person_outline_outlined,
                  color: globalColors.WhiteColor,
                ),
              ),
              Spacer(),
              RoundButton(
                title: 'Save',
                onPress: _updateName,
                loading: _loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
