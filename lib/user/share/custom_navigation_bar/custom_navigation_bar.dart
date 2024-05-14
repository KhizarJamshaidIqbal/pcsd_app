// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';

class CustomNavigationBarMain extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onIndexChanged;
  const CustomNavigationBarMain(
      {super.key, required this.initialIndex, required this.onIndexChanged});

  @override
  State<CustomNavigationBarMain> createState() =>
      _CustomNavigationBarMainState();
}

class _CustomNavigationBarMainState extends State<CustomNavigationBarMain> {
  int currentPageIndex = 0;
  User? currentuser = FirebaseAuth.instance.currentUser;
  List<Widget> navigationItemsIcon = <Widget>[
    const Icon(Icons.home_outlined),
    const Icon(CupertinoIcons.play_rectangle),
    const Icon(CupertinoIcons.lightbulb_fill),
    // FirebaseAuthServices.isLoggedIn != null
    //     ? Container(
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           border: Border.all(color: globalColors.WhiteColor, width: 1.5),
    //         ),
    //         child: CircleAvatar(
    //           radius:15,
    //           backgroundImage: NetworkImage(
    //             FirebaseAuth.instance.currentUser?.photoURL ?? 'P',
    //           ),
    //         ),
    //       )
    //     : const Icon(CupertinoIcons.settings_solid),
    FutureBuilder<bool>(
      future: FirebaseAuthServices.isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: globalColors.primaryColor,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.data!
              ? FirebaseAuth.instance.currentUser!.photoURL != null
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: globalColors.WhiteColor,
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: globalColors.WhiteColor,
                        backgroundImage: NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!),
                      ),
                    )
                  : const Icon(CupertinoIcons.settings_solid)
              : const Icon(CupertinoIcons.settings_solid);
        }
      },
    ),
// >>>>>>> beta
  ];
  List<String> navigationItemsText = <String>[
    'Home',
    'Video',
    'UV Light',
    'setting',
  ];
  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 70.0,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      indicatorColor:
          currentPageIndex == -1 ? Colors.transparent : globalColors.WhiteColor,
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
        widget.onIndexChanged(index);
      },
      destinations: navigationItemsIcon.asMap().entries.map((entry) {
        int idx = entry.key;
        Widget icon = entry.value;
        return NavigationDestination(
          icon: icon,
          label: navigationItemsText[idx],
        );
      }).toList(),
    );
  }
}
