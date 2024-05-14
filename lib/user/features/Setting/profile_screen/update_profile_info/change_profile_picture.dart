// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/widgets/rounded_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChageProfilePicture extends StatefulWidget {
  final String userId;
  const ChageProfilePicture({super.key, required this.userId});

  @override
  State<ChageProfilePicture> createState() => _ChageProfilePictureState();
}

class _ChageProfilePictureState extends State<ChageProfilePicture> {
  XFile? _image;

  bool isloading = false;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> getImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.h,
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: globalColors.WhiteColor,
                )),
            50.h,
            const CustomText(
              text: 'Profile picture',
              color: globalColors.WhiteColor,
              fontsize: 18,
              fontWeight: FontWeight.bold,
            ),
            10.h,
            const CustomText(
              text:
                  'A picture helps people to recognize you and makes your account more personal.',
              color: globalColors.WhiteColor,
              fontsize: 14,
              fontWeight: FontWeight.normal,
            ),
            const Spacer(),
            Center(
              child: _image != null
                  ? CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 150,
                      backgroundImage: FileImage(
                        File(
                          _image!.path,
                        ),
                      ),
                    )
                  : FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return data['profilePicture'] != null &&
                                  data['profilePicture'].isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: globalColors.WhiteColor,
                                  radius: 150,
                                  backgroundImage:
                                      NetworkImage(data['profilePicture']),
                                )
                              : CircleAvatar(
                                  radius: 150,
                                  backgroundColor: globalColors.WhiteColor,
                                  child: Text(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName![0]
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 100.0,
                                      color: globalColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    loading: isloading,
                    title: 'Save as Profile Picture',
                    fontsize: 15,
                    onPress: () async {
                      // final id =
                      //     DateTime.now().millisecondsSinceEpoch.toString();
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/PCSD/Profile Picture/${widget.userId}');
                      firebase_storage.UploadTask uploadTask =
                          ref.putFile(File(_image!.path));
                      setState(() {
                        isloading = true;
                      });
                      // await uploadTask
                      //     .whenComplete(() => print('Upload complete'));

                      final String downloadURL =
                          await (await uploadTask.whenComplete(() {}))
                              .ref
                              .getDownloadURL();
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .update({
                        'id': widget.userId,
                        'profilePicture': downloadURL,
                      });
                      Navigator.pop(context);
                      setState(() {
                        isloading = false;
                      });
                    },
                  ),
                ),
                10.w,
                SizedBox(
                  width: 120,
                  child: RoundButton(
                    title: 'Edit Picture',
                    fontsize: 16,
                    onPress: getImageFromGallery,
                  ),
                ),
              ],
            ),
            30.h,
          ],
        ),
      ),
    );
  }
}
