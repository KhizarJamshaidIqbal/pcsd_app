// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class UVLightScreen extends StatefulWidget {
  @override
  _UVLightScreenState createState() => _UVLightScreenState();
}

class _UVLightScreenState extends State<UVLightScreen> {
  double _opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            // Update opacity based on vertical drag position
            _opacity += details.delta.dy / 1000;
            if (_opacity < 0.0) {
              _opacity = 0.0; // Cap opacity at 0.0
            } else if (_opacity > 1.0) {
              _opacity = 1.0; // Cap opacity at 1.0
            }
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _opacity,
                child: Container(
                  // color: Color(0xff9b39ff),
                  // color: Color(0xff2b2af8),
                  color: Color(0xff0000fe),
                  // color: Color(0xff8206ff),
                  // color: Colors.blue.withOpacity(0.5),
                  // color: Colors.blue
                ),
              ),
            ),
            Center(
              child: Text(
                '${AppLocalizations.of(context)!.slideTitle}\n${(_opacity * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
