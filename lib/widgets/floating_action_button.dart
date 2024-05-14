// ignore_for_file: deprecated_member_use, unused_element, prefer_adjacent_string_concatenation

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/model_screens/floting_action_button_attach_screen/result_screen.dart';
import 'package:tflite/tflite.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  late String result = '', label = '';
  bool isWorking = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model/VGG16_Model.tflite",
        labels: "assets/model/labels.txt",
      );
      if (kDebugMode) {
        print("Model loaded successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading model: $e");
      }
    }
  }

  Future<void> runModel(XFile imageFile) async {
    if (!mounted || isWorking) return;
    setState(() {
      isWorking = true;
      isLoading = true;
    });

    var recognitions = await Tflite.runModelOnImage(
      path: imageFile.path,
      imageMean: 117,
      imageStd: 1.0,
      numResults: 5,
      threshold: 0.7,
    );

    setState(() {
      result = "";
      label = "";
      recognitions?.forEach((response) {
        double confidence = (response["confidence"] as double) * 100;
        if (kDebugMode) {
          print(
              'Raw Confidence: ${(response["confidence"] as double)}, Percentage: $confidence');
        }
        String confidencePercentage = confidence.toStringAsFixed(2);
        result +=
            "${"\n" + "Label :: " + response["label"]}\nAccuracy :: $confidencePercentage%\n";
        label += response["label"];
      });
      isWorking = false;
      isLoading = false;
      // Navigate to the ResultScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(File(imageFile.path), result, label),
        ),
      );
    });
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      runModel(pickedFile);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(eccentricity: 0.5),
      backgroundColor: globalColors.primaryColor,
      elevation: 0.5,
      onPressed: () {
        _openCamera();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const PickImage(),
        //   ),
        // );
      },
      child: isLoading
          ? Positioned.fill(
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          : SvgPicture.asset(
              'assets/images/SelectedScanner.svg',
              color: globalColors.WhiteColor,
            ),
    );
  }
}
