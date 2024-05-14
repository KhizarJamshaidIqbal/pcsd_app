import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
import '../../../widgets/custom_Text_Widget.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final auth = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        30.h,
        const Align(
          alignment: Alignment.topCenter,
          child: CustomText(
            text: 'User Details',
            color: globalColors.WhiteColor,
            fontsize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: auth,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.h,
                    const CircularProgressIndicator(
                      color: globalColors.WhiteColor,
                    ),
                    10.h,
                    const Text('Loading...'),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Text('Have Some Eror');
            }
            return Expanded(
                child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: globalColors.WhiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: snapshot.data!.docs[index]['profilePicture'] !=
                                    null &&
                                snapshot.data!.docs[index]['profilePicture']
                                    .isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: globalColors.primaryColor,
                                child: ClipOval(
                                    child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.network(
                                          snapshot.data!
                                              .docs[index]['profilePicture']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // This function is called when the image fails to load
                                            return Center(
                                              child: Text(
                                                snapshot
                                                    .data!.docs[index]['name']
                                                    .toString()[0]
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 25.0,
                                                  color:
                                                      globalColors.WhiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          },
                                        ))))
                            : CircleAvatar(
                                backgroundColor: globalColors.primaryColor,
                                child: Text(
                                  snapshot.data!.docs[index]['name']
                                      .toString()[0]
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    color: globalColors.WhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        title: Row(
                          children: [
                            const CustomText(
                              text: "Name: ",
                              color: globalColors.BlackColor,
                              fontsize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            FittedBox(
                              child: CustomText(
                                text: snapshot.data!.docs[index]['name']
                                    .toString(),
                                color: globalColors.BlackColor,
                                fontsize: 14,
                              ),
                            ),
                          ],
                        ),
                        subtitle: FittedBox(
                          child: Row(
                            children: [
                              const CustomText(
                                text: "Email: ",
                                color: globalColors.BlackColor,
                                fontsize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: snapshot.data!.docs[index]['email']
                                    .toString(),
                                color: globalColors.BlackColor,
                                fontsize: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ],
    );
  }
}
