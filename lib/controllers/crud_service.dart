// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDService {
// save fcm token to firstore
  static Future saveUserToken(String token) async {
    User? users = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(users!.uid)
          .update({
        "token": token,
      });

      print("Document Added to: ${users.uid}");
      print("Document token to: $token");
    } catch (e) {
      print("error in saving to firestore");
      print(e.toString());
    }
  }
}
