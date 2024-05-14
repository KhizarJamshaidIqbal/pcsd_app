// ignore_for_file: file_names
// // ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:pcsd_app/constants/app_size.dart';
// import 'package:pcsd_app/constants/colors.dart';

// class ResultScreen extends StatelessWidget {
//   final File imageFile;
//   final String result, label;

//   const ResultScreen(this.imageFile, this.result, this.label);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: globalColors.primaryColor,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back),
//             color: Colors.white),
//         title: Text(
//           'Result : ' + label,
//           style: TextStyle(fontSize: 25, color: Colors.white),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               decoration: BoxDecoration(boxShadow: const [
//                 BoxShadow(
//                     color: globalColors.primaryColor,
//                     blurRadius: 100,
//                     offset: Offset(0, 0),
//                     blurStyle: BlurStyle.outer)
//               ], border: Border.all(color: globalColors.primaryColor)),
//               width: double.infinity,
//               height: 600,
//               child: Image.file(
//                 imageFile,
//                 fit: BoxFit.cover,
//               )),
//           10.h,
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Text(
//               result.isNotEmpty ? result : 'No result',
//               style: TextStyle(
//                 color: Colors.green,
//                 fontSize: 28,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
