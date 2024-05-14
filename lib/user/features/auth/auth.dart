// ignore_for_file: unused_field, avoid_print, dead_code, prefer_final_fields, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pcsd_app/model/UserModel.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final id = DateTime.now().millisecondsSinceEpoch.toString();

  Future<User?> signUpWithEmailAndPassword(UserModel userModel) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
      });

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email address is already in use.');
      } else {
        print('An error occurred: ${e.code}');
      }
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // showToast(message: 'Invalid email or password.');
        print('Invalid email or password.');
      } else {
        // showToast(message: 'An error occurred: ${e.code}');
        print(e.code);
      }
    }
    return null;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Sign in successful
          print('User signed in: ${user.displayName}');
          // Save user data in Firestore
          // Check if user data already exists in Firestore
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (!userData.exists) {
            // Save user data in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'name': user.displayName,
              'email': user.email,
              'profilePicture': user.photoURL,
              'token': ''
            });
          }
          return user;
        } else {
          // Handle sign in failure
          print('Failed to sign in');
          return null;
        }
      } else {
        // Handle sign in failure
        print('Failed to sign in');
        return null;
      }
    } catch (e) {
      // Handle sign in error
      print('Error signing in: $e');
      return null;
    }
  }

//signInWithFacebook
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final AccessToken accessToken = result.accessToken!;
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        // Sign in successful
        print('User signed in with Facebook: ${user.displayName}');
        // Save user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'password': '',
          'photoUrl': user.photoURL,
          'token': ''
        });
        return user;
      } else {
        // Handle sign in failure
        print('Failed to sign in with Facebook');
        return null;
      }
    } catch (e) {
      // Handle sign in error
      print('Error signing in with Facebook: $e');
      return null;
    }
  }

  Future<bool> checkIfAccountExists(String email) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: 'randompassword',
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      }
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error sending reset email: $e');
    }
  }

  // Future<void> updatePassword(String email, String newPassword) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: 'randompassword',
  //     );
  //     if (userCredential.user != null) {
  //       await userCredential.user!.updatePassword(newPassword);
  //     }
  //   } catch (e) {
  //     print('Error updating password: $e');
  //   }
  // }
// check whether the user is sign in or not
  static Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
    await FacebookAuth.instance.logOut();
  }

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      await FacebookAuth.instance.logOut();
      await user?.delete();
    } catch (e) {
      print('Error deleting account: $e');
    }
  }
}
