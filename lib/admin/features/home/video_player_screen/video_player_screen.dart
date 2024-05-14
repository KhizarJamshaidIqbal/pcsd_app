// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_local_variable, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:overflow_text_animated/overflow_text_animated.dart';
// import 'package:pcsd_app/constants/app_size.dart';
// import 'package:pcsd_app/constants/colors.dart';
// import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl, videoTitle, videoRs;

//   const VideoPlayerScreen(
//       {super.key,
//       required this.videoUrl,
//       required this.videoTitle,
//       required this.videoRs});

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isLandscape = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black.withOpacity(.5),
//       appBar: AppBar(
//         toolbarHeight: 90,
//         // centerTitle: true,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(
//             Icons.arrow_back,
//             color: globalColors.WhiteColor,
//           ),
//         ),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             OverflowTextAnimated(
//               text: widget.videoTitle,
//               style: const TextStyle(
//                 color: globalColors.WhiteColor,
//                 fontSize: 20,
//               ),
//               curve: Curves.linear,
//               animation: OverFlowTextAnimations.infiniteLoop,
//               animateDuration: const Duration(milliseconds: 1500),
//               delay: const Duration(milliseconds: 100),
//             ),
//             CustomText(
//               text: widget.videoRs,
//               fontsize: 14,
//               color: globalColors.WhiteColor,
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.screen_rotation,
//               color: globalColors.WhiteColor,
//             ),
//             onPressed: () {
//               if (_isLandscape) {
//                 SystemChrome.setPreferredOrientations([
//                   DeviceOrientation.portraitUp,
//                   DeviceOrientation.portraitDown,
//                 ]);
//               } else {
//                 SystemChrome.setPreferredOrientations([
//                   DeviceOrientation.landscapeRight,
//                   DeviceOrientation.landscapeLeft,
//                 ]);
//               }
//               _isLandscape = !_isLandscape;
//             },
//           ),
//         ],
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               _isLandscape == true ? 0.h : 100.h,
//               _controller.value.isInitialized
//                   ? SizedBox(
//                       width: _isLandscape == true
//                           ? MediaQuery.of(context).size.width * .8
//                           : double.infinity,
//                       height: _isLandscape == true
//                           ? MediaQuery.of(context).size.height
//                           : MediaQuery.of(context).size.height * .4,
//                       child: AspectRatio(
//                         aspectRatio: _controller.value.aspectRatio,
//                         child: Stack(
//                           alignment: Alignment.bottomCenter,
//                           children: <Widget>[
//                             VideoPlayer(_controller),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color:
//                                       globalColors.WhiteColor.withOpacity(0.7)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 30.0, vertical: 10.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     FutureBuilder<Duration?>(
//                                       future: _controller.position,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.hasData &&
//                                             snapshot.data != null) {
//                                           final currentPosition =
//                                               snapshot.data!;
//                                           final duration =
//                                               _controller.value.duration;
//                                           return Text(
//                                             '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
//                                             style: const TextStyle(
//                                               color: globalColors.BlackColor,
//                                               fontSize: 16,
//                                             ),
//                                           );
//                                         } else {
//                                           return Container();
//                                         }
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: Icon(_isPlaying
//                                           ? Icons.pause_circle_outline_outlined
//                                           : Icons.play_arrow_outlined),
//                                       onPressed: () {
//                                         setState(() {
//                                           if (_isPlaying) {
//                                             _controller.pause();
//                                           } else {
//                                             _controller.play();
//                                           }
//                                           _isPlaying = !_isPlaying;
//                                         });
//                                       },
//                                     ),
//                                     FutureBuilder<Duration?>(
//                                       future: _controller.position,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.hasData &&
//                                             snapshot.data != null) {
//                                           final currentPosition =
//                                               snapshot.data!;
//                                           final duration =
//                                               _controller.value.duration;
//                                           return Text(
//                                             '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
//                                             style: const TextStyle(
//                                               color: globalColors.BlackColor,
//                                               fontSize: 16,
//                                             ),
//                                           );
//                                         } else {
//                                           return Container();
//                                         }
//                                       },
//                                     ),

//                                     // Text(
//                                     //   '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
//                                     //   style: const TextStyle(
//                                     //     color: globalColors.BlackColor,
//                                     //     fontSize: 16,
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : const CircularProgressIndicator(
//                       color: globalColors.WhiteColor,
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl, videoTitle, videoRs;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoRs,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late FlickManager flickManager;
  bool _isLandscape = false;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Container(
        decoration: const BoxDecoration(gradient: globalColors.primaryGradient),
        width: double.infinity,
        height: double.infinity,
        child: FlickVideoPlayer(
          flickManager: flickManager,
          preferredDeviceOrientation: const [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
          flickVideoWithControls: const FlickVideoWithControls(
            controls: FlickPortraitControls(),
          ),
          flickVideoWithControlsFullscreen:
              const FlickVideoWithControls(
            controls: FlickLandscapeControls(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? CustomAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      backgroundColor: globalColors.primaryColor,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: globalColors.WhiteColor,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverflowTextAnimated(
            text: widget.videoTitle,
            style: const TextStyle(
              color: globalColors.WhiteColor,
              fontSize: 20,
            ),
            curve: Curves.linear,
            animation: OverFlowTextAnimations.infiniteLoop,
            animateDuration: const Duration(milliseconds: 1500),
            delay: const Duration(milliseconds: 100),
          ),
          CustomText(
            text: widget.videoRs,
            fontsize: 14,
            color: globalColors.WhiteColor,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.screen_rotation,
            color: globalColors.WhiteColor,
          ),
          onPressed: () {
            if (_isLandscape) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            }
            _isLandscape = !_isLandscape;
          },
        ),
      ],
    );
  }
}
