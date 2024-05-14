// // ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, use_key_in_widget_constructors, unused_import, unused_local_variable, deprecated_member_use

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:pcsd_app/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pcsd_app/user/features/Dashboard/HomeScreen.dart';
// import 'package:pcsd_app/user/features/Setting/Setting.dart';
// import 'package:pcsd_app/user/features/UVLight/UVLightScreen.dart';
// import 'package:pcsd_app/user/features/scanner/pickImage.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:pcsd_app/user/features/video_screen/video_screen.dart';
// import 'package:pcsd_app/user/share/scroll_to_hide_bottom_navigation_bar/scroll_to_hide_bottom_navigation_bar.dart';
// import 'package:pcsd_app/widgets/CustomAppbar.dart';
// import 'package:pcsd_app/widgets/CustomDrawer.dart';
// import 'package:pcsd_app/widgets/floating_action_button.dart';
// class BottomNavigationbar extends StatefulWidget {
//   const BottomNavigationbar({super.key});

//   @override
//   State<BottomNavigationbar> createState() => _BottomNavigationbarState();
// }

// class _BottomNavigationbarState extends State<BottomNavigationbar> {
//   late ScrollController controller;
//   int _currentindex = 0;
//   // late List<Widget> ScreenList;
//   @override
//   void initState() {
//     super.initState();

//     controller = ScrollController();

//     // ScreenList = [
//     //   HomeScreen(
//     //     scrollController: controller,
//     //   ),
//     //   // Scanner(),
//     //   PickImage(),
//     //   UVLightScreen(),
//     //   Setting(),
//     // ];
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }

//   List<Widget> ScreenList = [
//     HomeScreen(
//         // scrollController: controller,
//         ),
//     // Scanner(),
//     // PickImage(),
//     VideoScreen(),
//     UVLightScreen(),
//     Setting(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: HomeAppBar(),
//       drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser),
//       body: NestedScrollView(
//         floatHeaderSlivers: true,
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           HomeAppBar(AppLocalizations.of(context)!.appBarTitle,),
//         ],
//         body: Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: globalColors.primaryGradient,
//             ),
//             child: ScreenList[_currentindex]),
//       ),
//       extendBody: true,
//       backgroundColor: globalColors.primaryColor,

//       // bottomNavigationBar
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           child: Theme(
//             data: ThemeData(
//               canvasColor: globalColors.primaryColor,
//             ),
//             child: BottomNavigationBar(
              
//               backgroundColor: globalColors.primaryColor,
//               selectedItemColor: globalColors.SecondaryColor,
//               unselectedItemColor: globalColors.WhiteColor,
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: _currentindex == 0
//                       ? SvgPicture.asset('assets/images/SelectedHome.svg')
//                       : SvgPicture.asset('assets/images/UnSelectedHome.svg'),
//                   label: AppLocalizations.of(context)!.h,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.play_rectangle),
//                   // _currentindex == 1
//                   //     ? SvgPicture.asset('assets/images/SelectedScanner.svg')
//                   //     : SvgPicture.asset(
//                   //         'assets/images/UnSelectedScanner.svg'),
//                   label: AppLocalizations.of(context)!.sc,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: _currentindex == 2
//                       ? SvgPicture.asset('assets/images/blub_Icon_1.svg')
//                       : SvgPicture.asset('assets/images/blub_Icon_2.svg'),
//                   label: AppLocalizations.of(context)!.ul,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: _currentindex == 3
//                       ? SvgPicture.asset('assets/images/UnSsettings.svg')
//                       : SvgPicture.asset('assets/images/Ssettings.svg'),
//                   label: AppLocalizations.of(context)!.st,
//                 ),
//               ],
//               currentIndex: _currentindex,
//               onTap: (value) {
//                 setState(() {
//                   _currentindex = value;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),

//       // floatingActionButton
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterFloat,
//       floatingActionButton: _currentindex == 0
//           ? CustomFloatingActionButton()
//           // FloatingActionButton(
//           //     shape: CircleBorder(eccentricity: 0.5),
//           //     backgroundColor: globalColors.primaryColor,
//           //     elevation: 0.5,
//           //     onPressed: () {
//           //       Navigator.push(
//           //         context,
//           //         MaterialPageRoute(
//           //           builder: (context) => PickImage(),
//           //         ),
//           //       );
//           //     },
//           //     child: SvgPicture.asset(
//           //       'assets/images/SelectedScanner.svg',
//           //       color: globalColors.WhiteColor,
//           //     ),
//           //   )
//           : null,
//     );
//   }
// }
