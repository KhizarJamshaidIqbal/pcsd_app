// ignore_for_file: use_super_parameters, prefer_const_constructors, deprecated_member_use, avoid_print, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/user/features/Setting/profile_screen/update_profile_info/change_profile_picture.dart';
import 'package:pcsd_app/user/features/Setting/profile_screen/update_profile_info/update_name.dart';
import 'package:pcsd_app/user/features/Setting/profile_screen/update_profile_info/update_email.dart';
import 'package:pcsd_app/user/features/auth/auth.dart';
import 'package:pcsd_app/widgets/CustomSnackbar.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
import 'package:pcsd_app/constants/app_size.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  final FirebaseAuthServices authServices = FirebaseAuthServices();
  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String currentUserId = currentUser!.uid;

    String initial = widget.user!.displayName?.isNotEmpty == true
        ? widget.user!.displayName![0].toUpperCase()
        : '';
    return Scaffold(
      backgroundColor: Color(0xff24953D),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  color: globalColors.WhiteColor, size: 35.0),
            ),
            backgroundColor: Color(0xff24953D),
            title: CustomText(
              text: 'My Profile',
              color: globalColors.WhiteColor,
              fontsize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 62,
                          backgroundColor: globalColors.WhiteColor,
                          child: widget.user?.photoURL != null
                              ? ClipOval(
                                  child: Image.network(
                                    widget.user!.photoURL!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.user!.uid)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      if (data['profilePicture'] == null ||
                                          data['profilePicture'].isEmpty) {
                                        return Text(
                                          initial,
                                          style: TextStyle(
                                            fontSize: 40.0,
                                            color: globalColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return ClipOval(
                                          child: Image.network(
                                            data['profilePicture'],
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }
                                    }

                                    return CircularProgressIndicator(
                                      color: globalColors.primaryColor,
                                    );
                                  },
                                ),
                        ),
                        15.h,
                        TextButton(
                          onPressed: () async {
                            final User? currentUser =
                                FirebaseAuth.instance.currentUser;
                            final String currentUserId = currentUser!.uid;
                            print('Custom User Id: ' + currentUserId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChageProfilePicture(
                                  userId: currentUserId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5,),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(color: globalColors.WhiteColor),
                            ),
                            child: CustomText(
                              text: 'Change Profile Picture',
                              color: globalColors.WhiteColor,
                              fontsize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  40.h,
                  CustomText(
                    text: 'Personal Information',
                    color: globalColors.WhiteColor,
                    fontsize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  20.0.h,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: globalColors.WhiteColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        20.w,
                        Icon(
                          Icons.person,
                          color: globalColors.WhiteColor,
                        ),
                        20.w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.h,
                            CustomText(
                              text: 'Your Name',
                              color: globalColors.WhiteColor,
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            FittedBox(
                              child: CustomText(
                                text: widget.user?.displayName ?? '',
                                color: globalColors.WhiteColor,
                                fontsize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.h,
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateNameScreen(
                                  user: widget.user!,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            FontAwesomeIcons.edit,
                            color: globalColors.WhiteColor,
                          ),
                        ),
                        20.0.w,
                      ],
                    ),
                  ),
                  20.h,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: globalColors.WhiteColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          20.w,
                          Icon(
                            Icons.email_outlined,
                            color: globalColors.WhiteColor,
                          ),
                          20.w,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.h,
                              CustomText(
                                text: 'Email Address',
                                color: globalColors.WhiteColor,
                                fontsize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              5.h,
                              CustomText(
                                text: widget.user?.email ?? '',
                                color: globalColors.WhiteColor,
                                fontsize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              10.h,
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateEmailScreen(
                                    user: widget.user!,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              FontAwesomeIcons.edit,
                              color: globalColors.WhiteColor,
                            ),
                          ),
                          20.0.w,
                        ],
                      ),
                    ),
                  ),
                  20.h,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: globalColors.WhiteColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        20.w,
                        Icon(
                          Icons.security,
                          color: globalColors.WhiteColor,
                        ),
                        20.w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.h,
                            CustomText(
                              text: 'Reset Password',
                              color: globalColors.WhiteColor,
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            5.h,
                            CustomText(
                              text: '**********',
                              color: globalColors.RedColor,
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            10.h,
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            try {
                              widget.authServices
                                  .resetPassword(widget.user!.email!);
                              CustomSnackbar.show(
                                  context, 'Password reset email sent',
                                  backgroundColor: Colors.green);
                            } catch (e) {
                              CustomSnackbar.show(context,
                                  'Error sending password reset email: $e',
                                  backgroundColor: Colors.red);
                            }
                          },
                          icon: Icon(
                            FontAwesomeIcons.upload,
                            color: globalColors.WhiteColor,
                          ),
                        ),
                        20.0.w,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
