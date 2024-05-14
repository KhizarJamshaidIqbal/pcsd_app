import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';

class CustomNavigationBar extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onIndexChanged;
  const CustomNavigationBar(
      {super.key, required this.initialIndex, required this.onIndexChanged});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentPageIndex = 0;
  List<Widget> navigationItemsIcon = <Widget>[
    const Icon(Icons.home_outlined),
    const Icon(CupertinoIcons.add_circled),
    const Icon(Icons.person),
  ];
  List<String> navigationItemsText = <String>[
    'Home',
    'Add',
    'Users',
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
