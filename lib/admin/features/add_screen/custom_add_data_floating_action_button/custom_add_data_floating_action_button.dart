
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_toast.dart';

class CustomAddDataFloatingActionButton extends StatefulWidget {
  final String dropdownValue;
  final List<String> rs;
  final String  title, videoUrl;

  const CustomAddDataFloatingActionButton({
    super.key,
    required this.dropdownValue,
    required this.rs,
    required this.title,
    required this.videoUrl,
  });

  @override
  State<CustomAddDataFloatingActionButton> createState() =>
      _CustomAddDataFloatingActionButtonState();
}

class _CustomAddDataFloatingActionButtonState
    extends State<CustomAddDataFloatingActionButton> {
  bool isUploading = false;
  final databaseRef = FirebaseDatabase.instance.ref('PCSD');

  Future<void> _uploadVideoToStorage() async {
    setState(() {
      isUploading = true;
    });

    final storageRef =
        FirebaseStorage.instance.ref().child('/PCSD/Videos/${widget.rs.join("_")}.mp4');

    try {
      await storageRef.putFile(File.fromUri(Uri.parse(widget.videoUrl)));
      final videoUrl = await storageRef.getDownloadURL();
      await _addVideoUrlToDatabase(videoUrl);
      showToast(context, 'Video Stored Sucessfully', globalColors.primaryColor);
      Navigator.pop(context);
    } catch (e) {
      showToast(context, '$e', globalColors.RedColor);
    }

    setState(() {
      isUploading = false;
    });
  }

  Future<void> _addVideoUrlToDatabase(String videoUrl) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      await databaseRef.child(widget.dropdownValue).child(id).set({
        'id': id,
        'rs': widget.rs,
        'title': widget.title,
        'videoUrl': videoUrl,
      });

      showToast(context, 'Data Added Successfully', globalColors.primaryColor);
    } catch (e) {
      showToast(context, 'Error adding video to database: $e',
          globalColors.primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isUploading ? null : _uploadVideoToStorage,
      shape: const CircleBorder(eccentricity: 0.5),
      backgroundColor: globalColors.WhiteColor,
      child: isUploading
          ? const CircularProgressIndicator(
              color: globalColors.primaryColor,
            )
          : const Icon(
              Icons.cloud_upload,
              color: globalColors.primaryColor,
            ),
    );
  }
}
