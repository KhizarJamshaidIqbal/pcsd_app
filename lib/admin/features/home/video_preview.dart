// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:pcsd_app/admin/features/home/video_player_screen/video_player_screen.dart';
// import 'package:pcsd_app/constants/app_size.dart';
// import 'package:pcsd_app/constants/colors.dart';
// import 'package:pcsd_app/widgets/custom_Text_Widget.dart';

// class VideoPreview extends StatefulWidget {
//   const VideoPreview({super.key});

//   @override
//   State<VideoPreview> createState() => _VideoPreviewState();
// }

// class _VideoPreviewState extends State<VideoPreview> {
//   final databaseRef = FirebaseDatabase.instance.ref('PCSD');
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FirebaseAnimatedList(
//         query: databaseRef.child('Video'),
//         defaultChild: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const CircularProgressIndicator(
//               color: globalColors.WhiteColor,
//             ),
//             10.h,
//             const Text(
//               'Loading...',
//               style: TextStyle(color: globalColors.WhiteColor, fontSize: 20),
//             ),
//           ],
//         )),
//         itemBuilder: (BuildContext context, DataSnapshot snapshot,
//             Animation<double> animation, int index) {
//           if (snapshot.value != null) {
//             Map<dynamic, dynamic> video =
//                 snapshot.value as Map<dynamic, dynamic>;
//             return Card(
//               color: globalColors.WhiteColor,
//               child: ListTile(
//                 leading: const Icon(
//                   Icons.video_library_outlined,
//                   color: globalColors.primaryColor,
//                 ),
//                 title: CustomText(
//                   text: video['title'],
//                   color: globalColors.primaryColor,
//                   fontsize: 18,
//                 ),
//                 subtitle: CustomText(
//                   text: video['rs'] is String
//                       ? video['rs']
//                       : (video['rs'] as List<dynamic>).join(", "),
//                   color: globalColors.primaryColor,
//                   fontsize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => VideoPlayerScreen(
//                         videoUrl: video['videoUrl'],
//                         videoTitle: video['title'],
//                         videoRs: video['rs'] is String ? video['rs'] : (video['rs'] as List<Object?>).join(", "),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           } else {
//             return const SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/admin/features/home/video_player_screen/video_player_screen.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({super.key, });

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  final databaseRef = FirebaseDatabase.instance.ref('PCSD');

  // Method to delete a video by its ID
  void _deleteVideo(String id) {
    databaseRef.child('Video').child(id).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        query: databaseRef.child('Video'),
        defaultChild: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: globalColors.WhiteColor,
              ),
              10.h,
              const Text(
                'Loading...',
                style: TextStyle(color: globalColors.WhiteColor, fontSize: 20),
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.value != null) {
            Map<dynamic, dynamic> video =
                snapshot.value as Map<dynamic, dynamic>;
            return Dismissible(
              // Set a unique key for each item based on the video's ID
              key: Key(video['id']),
              // Add a background to show when swiping
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  
                color: globalColors.RedColor,
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 50.0),
                child: const Icon(Icons.delete, color: globalColors.WhiteColor, size: 40.0,),
              ),
              // Define the direction in which the item can be dismissed
              direction: DismissDirection.endToStart,
              // Callback when the item is dismissed
              onDismissed: (direction) {
                _deleteVideo(video['id']);
              },
              child: Card(
                color: globalColors.WhiteColor,
                child: ListTile(
                  leading: const Icon(
                    Icons.video_library_outlined,
                    color: globalColors.primaryColor,
                  ),
                  title: CustomText(
                    text: video['title'],
                    color: globalColors.primaryColor,
                    fontsize: 18,
                  ),
                  subtitle: CustomText(
                    text: video['rs'] is String
                        ? video['rs']
                        : (video['rs'] as List<dynamic>).join(", "),
                    color: globalColors.primaryColor,
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                          videoUrl: video['videoUrl'],
                          videoTitle: video['title'],
                          videoRs: video['rs'] is String
                              ? video['rs']
                              : (video['rs'] as List<Object?>).join(", "),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
