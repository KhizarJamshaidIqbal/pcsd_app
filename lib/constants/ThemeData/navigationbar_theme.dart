import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcsd_app/constants/colors.dart';

NavigationBarThemeData buildNavigationBarThemeData() {
  return NavigationBarThemeData(
    indicatorColor: globalColors.WhiteColor,
    iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: globalColors.primaryColor,size: 25,);
        }
        return const IconThemeData(color: globalColors.SecondaryColor, size: 35,);
      },
    ),
    backgroundColor: globalColors.primaryColor,
    labelTextStyle: MaterialStateProperty.all<TextStyle>(
       GoogleFonts.literata(
         textStyle: const TextStyle(
          color: globalColors.WhiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          decoration: TextDecoration.none,
        ),
       )
    ),
  );
}
