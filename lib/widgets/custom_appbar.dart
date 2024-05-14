// import 'package:flutter/material.dart';
// import 'package:pcsd_app/constants/colors.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Icon leadingIcon;
//   final Icon actionIcon;
//   final VoidCallback onpress;

//   const CustomAppBar({
//     Key? key,
//     this.title = '',
//     this.leadingIcon = const Icon(Icons.arrow_back_ios_new_rounded),
//     this.actionIcon = const Icon(
//       Icons.home_outlined,
//       size: 30,
//     ),
//     required this.onpress,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       title: Text(title),
//       backgroundColor: globalColors.primaryColor,
//       leading: IconButton(
//         icon: leadingIcon,
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       actions: [
//         IconButton(
//           icon: actionIcon,
//           onPressed: onpress,
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
