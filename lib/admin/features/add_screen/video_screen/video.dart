// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/admin/features/add_screen/custom_add_data_floating_action_button/custom_add_data_floating_action_button.dart';
import 'package:pcsd_app/admin/features/add_screen/video_screen/picked_video.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_dropdownb_button_with_checkbox.dart';
import 'package:pcsd_app/widgets/custom_textField.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({
    super.key,
  });

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  // String value = '10 Rs';
  final TextEditingController titleController = TextEditingController();
  String? videoUrl;
  VideoPlayerController? _controller;
  List<String> newSelectedValues = ['10 Rs'];

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ListView(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.arrow_forward,
                  color: globalColors.WhiteColor,
                ),
                10.w,
                const CustomText(
                  text: 'fill the data filds',
                  color: globalColors.WhiteColor,
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            20.h,
            const CustomText(
              text: 'Select Video type',
              color: globalColors.WhiteColor,
              fontsize: 16,
              fontWeight: FontWeight.bold,
            ),
            10.h,
            // CustomDropdownButton(
            //   items: const [
            // '10 Rs',
            // '20 Rs',
            // '50 Rs',
            // '100 Rs',
            // '500 Rs',
            // '1000 Rs',
            // '5000 Rs'
            //   ],
            //   value: value,
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       value = newValue ?? '10 Rs';
            //     });
            //   },
            // ),
            CustomDropdownButtonWithCheckBox(
              items: const [
                '10 Rs',
                '20 Rs',
                '50 Rs',
                '100 Rs',
                '500 Rs',
                '1000 Rs',
                '5000 Rs',
                'SPB | Bank Note Security Features'
              ],
              selectedValues: newSelectedValues,
              onChanged: (List<String> selectedValues) {
                setState(() {
                  newSelectedValues = selectedValues;
                });
                print(newSelectedValues);
              },
            ),

            20.h,
            RoundedTextField(
              labelText: 'Video Title',
              hintText: 'Enter Video title',
              controller: titleController,
              icon: const Icon(
                CupertinoIcons.pencil,
                color: globalColors.WhiteColor,
              ),
            ),
            30.h,
            const CustomText(
              text: 'Select the Video',
              color: globalColors.WhiteColor,
              fontsize: 16,
              fontWeight: FontWeight.bold,
            ),
            15.h,
            videoUrl != null
                ? _videoPreviewWidget()
                : InkWell(
                    onTap: _pickedVideo,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .35,
                      decoration: const BoxDecoration(
                          color: globalColors.WhiteColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.videocam_circle,
                          color: globalColors.primaryColor,
                          size: 150,
                        ),
                      ),
                    ),
                  )
          ],
        ),
        Positioned(
          bottom: 100,
          right: 20,
          child: CustomAddDataFloatingActionButton(
            dropdownValue: 'Video',
            rs: newSelectedValues,
            title: titleController.text,
            videoUrl: videoUrl.toString(),
          ),
        ),
      ],
    );
  }

  void _pickedVideo() async {
    final url = await pickedVideo();
    if (url != null) {
      setState(() {
        videoUrl = url;
      });
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(videoUrl!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  Widget _videoPreviewWidget() {
    if (_controller != null) {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .35,
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .35,
        decoration: const BoxDecoration(
            color: globalColors.WhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: const Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              color: globalColors.primaryColor,
            ),
          ),
        ),
      );
    }
  }
}
