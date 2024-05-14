// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/constants/fonts.dart';

import 'custom_Text_Widget.dart';

class CustomPasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText, labelText;

  final String? Function(String?)? validator;

  CustomPasswordInputField(
      {required this.controller,
      required this.hintText,
      required this.labelText,
      this.validator});

  @override
  _CustomPasswordInputFieldState createState() =>
      _CustomPasswordInputFieldState();
}

class _CustomPasswordInputFieldState extends State<CustomPasswordInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: widget.labelText,
              color: globalColors.TitleColor,
              fontsize: 18,
            ),
            10.w,
            CustomText(
              text: "*",
              color: globalColors.RedColor,
              fontsize: 18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        15.h,
        TextFormField(
          controller: widget.controller,
          obscureText: _isPasswordVisible ? false : true,
          validator: widget.validator,
          style: TextStyle(
            color: Colors.white,
            fontFamily: fonts.fontfamily_4,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.key_rounded,
              color: globalColors.TitleColor,
              size: 28,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: globalColors.TitleColor,
                  size: 25),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: globalColors.TitleColor,
              fontFamily: fonts.fontfamily_4,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: globalColors.TitleColor),
            ),
            labelStyle: TextStyle(color: globalColors.TitleColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
          cursorColor: Colors.white,
          cursorWidth: 2.0,
          cursorHeight: 25.0,
        ),
      ],
    );
  }
}
