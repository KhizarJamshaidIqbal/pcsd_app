import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/admin/features/home/video_player_screen/video_player_screen.dart';
import 'package:pcsd_app/user/features/video_screen/shimer_effect/shimer_effect.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('PCSD');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
            query: databaseRef.child('Video'),
            defaultChild: const VideoScreenShimerEffect(),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              if (snapshot.value != null) {
                Map<dynamic, dynamic> video =
                    snapshot.value as Map<dynamic, dynamic>;
                return Card(
                  color: globalColors.WhiteColor,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.video_library_outlined,
                      color: globalColors.primaryColor,
                    ),
                    title: CustomText(
                      text: video['title'],
                      color: globalColors.primaryColor,
                      fontsize: 20,
                    ),
                    subtitle: CustomText(
                        text: video['rs'] is String ? video['rs'] : (video['rs'] as List<Object?>).join(", "),
                        color: globalColors.primaryColor,
                        fontsize: 16),
                    onTap: () {
                      // Navigate to new screen and play video
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                              videoUrl: video['videoUrl'],
                              videoTitle: video['title'],
                              videoRs: video['rs'] is String ? video['rs'] : (video['rs'] as List<Object?>).join(", "),
                              ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
