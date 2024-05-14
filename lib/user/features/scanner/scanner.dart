// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/main.dart';
// import 'package:tflite_v2/tflite_v2.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late CameraImage imgCamera;
  late CameraController cameraController;
  bool isWorking = false;
  // String result = "";
  @override
  void initState() {
    super.initState();

    initCamera();
    // loadModel();
  }

  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            imgCamera = imageFromStream;
            // runmodel();
          }
        });
      });
    });
  }
  //
  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: "assets/model_unquant.tflite",
  //     labels: "assets/labels.txt",
  //   );
  // }
  //
  // runmodel() async {
  //   if (imgCamera == null) {
  //     return;
  //   }
  //
  //   var recognitions = await Tflite.runModelOnFrame(
  //     bytesList: imgCamera.planes.map((plane) {
  //       return plane.bytes;
  //     }).toList(),
  //     imageHeight: imgCamera.height,
  //     imageWidth: imgCamera.width,
  //     imageMean: 117, // defaults to 117.0
  //     imageStd: 1.0, // defaults to 1.0
  //     numResults: 1, // defaults to 5
  //     threshold: 0.1, // defaults to 0.1
  //   );
  //
  //   result = "";
  //
  //   recognitions?.forEach((response) {
  //     double confidence = (response["confidence"] as double) * 100;
  //     print(
  //         'Raw Confidence: ${(response["confidence"] as double)}, Percentage: $confidence');
  //     String confidencePercentage = confidence.toStringAsFixed(2);
  //     result += "\n" +
  //         "Label :: " +
  //         response["label"] +
  //         "\n" +
  //         "Accuracy :: " +
  //         "$confidencePercentage%" +
  //         "\n";
  //   });
  //
  //   setState(() {
  //     result;
  //   });
  //
  //   isWorking = false;
  // }
  //

  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   Tflite.close();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: globalColors.primaryGradient),
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: size.height,
              child: (!cameraController.value.isInitialized)
                  ? Icon(
                Icons.camera_alt_outlined,
                color: globalColors.WhiteColor,
                size: 100,
              )
                  : AspectRatio(
                aspectRatio: cameraController.value.aspectRatio,
                child: CameraPreview(cameraController),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // result.isNotEmpty
                      //     ? Text(
                      //   result,
                      //   style: const TextStyle(
                      //     color: Colors.green,
                      //     fontSize: 30.0,
                      //   ),
                      // )
                      //     :
                      const Text(
                        "\nPlace The Picture here",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
