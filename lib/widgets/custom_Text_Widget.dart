// ignore: file_names
//CustomTextWidget
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {
  final String text;
  final TextDecoration textDecoration;
  final Color color;
  final double fontsize;
  final FontWeight fontWeight;

  const CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.fontsize,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.literata(
        textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontsize,
          decoration: textDecoration,
        ),
      ),
    );
  }
}
// class CustomText extends StatelessWidget {
//   final String text;
//   final TextDecoration textDecoration;
//   final Color color;
//   final double fontsize;
//   final FontWeight fontWeight;

//   const CustomText(String s, {
//     super.key,
//     required this.text,
//     required this.color,
//     required this.fontsize,
//     this.fontWeight = FontWeight.normal,
//     this.textDecoration = TextDecoration.none,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: TextAlign.start,
//       style: GoogleFonts.literata(
//         textStyle: TextStyle(
//           color: color,
//           fontWeight: fontWeight,
//           fontSize: fontsize,
//           decoration: textDecoration,
//         ),
//       ),
//     );
//   }
// }
