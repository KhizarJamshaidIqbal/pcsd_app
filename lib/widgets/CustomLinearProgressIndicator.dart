// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';

class CoustomLinearProgressIndicator extends StatelessWidget {
  final double value;

  CoustomLinearProgressIndicator({required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .5,
      height: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: globalColors.WhiteColor,
          valueColor: AlwaysStoppedAnimation<Color>(
              const Color.fromARGB(255, 32, 134, 54)),
        ),
      ),
    );
  }
}
