// ignore_for_file: prefer_const_constructors, use_super_parameters, unused_local_variable, file_names, unused_element, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UVLightPreview extends StatefulWidget {
  final String uvImageUrl;

  const UVLightPreview({Key? key, required this.uvImageUrl}) : super(key: key);

  @override
  State<UVLightPreview> createState() => _UVLightPreviewState();
}

class _UVLightPreviewState extends State<UVLightPreview> {
  @override
  Widget build(BuildContext context) {
    final controller = TransformationController();
    bool isZoomed = false;
    var degree = 90;
    var angle = degree * pi / 180;

    void reset() {
      setState(() {
        controller.value = Matrix4.identity();
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalColors.primaryColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: globalColors.WhiteColor,
            )),
        title: Text(
          AppLocalizations.of(context)!.uvLightPreview,
          style: TextStyle(
              color: globalColors.WhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        child: Center(
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(20),
            minScale: 1,
            maxScale: 9,
            transformationController: controller,
            onInteractionStart: (_) => setState(() {
              isZoomed = false;
            }),
            onInteractionEnd: (details) {
              setState(() {
                isZoomed = controller.value.getMaxScaleOnAxis() > 2;
              });
            },
            child: Transform.rotate(
              angle: angle,
              child: Image.asset(
                widget.uvImageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
