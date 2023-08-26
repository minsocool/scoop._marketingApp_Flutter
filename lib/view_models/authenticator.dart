import 'package:app_marketing_version_2/models/info_user.dart';
import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/main/main_screen.dart';
import 'package:app_marketing_version_2/view_models/cloud_firestore.dart';
import 'package:app_marketing_version_2/view_models/share_preference.dart';
import 'package:app_marketing_version_2/widgets/dialog_custom.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenicator {
  final FirebaseAuth _firebaseAuth;
  Authenicator(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  //log out
  dynamic signOut(BuildContext context) async {
    await context.read<SharePreference>().remove('login');
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();

    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  //sign up
  void signUp(
      String email, String password, String name, BuildContext context) async {
    LoadingSpinkit.loadingSpinkit(context);
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await userCredential.user!.updateProfile(displayName: name);
        await context.read<CloudFirestore>().addUser(
            context: context,
            id: userCredential.user!.uid,
            name: name,
            email: userCredential.user!.email);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        return await DialogCustom.diaglogcustom(
            context, false, 'The account already exists for that email.');
      } else {
        Navigator.of(context).pop();
        return await DialogCustom.diaglogcustom(
            context, false, 'Network no working');
      }
    } catch (e) {
      Navigator.of(context).pop();
      return await DialogCustom.diaglogcustom(context, false, e.toString());
    }
  }

  //sign in
  dynamic signIn(String email, String password, BuildContext context) async {
    LoadingSpinkit.loadingSpinkit(context);
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await context
            .read<SharePreference>()
            .save('login', userCredential.user!.uid);

        Navigator.of(context).pop();
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                uid: userCredential.user!.uid,
              ),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        return await DialogCustom.diaglogcustom(
            context, false, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        return await DialogCustom.diaglogcustom(
            context, false, 'Wrong password provided for that user.');
      } else {
        Navigator.of(context).pop();
        return await DialogCustom.diaglogcustom(
            context, false, 'Network no working');
      }
    } catch (e) {
      Navigator.of(context).pop();
      return await DialogCustom.diaglogcustom(context, false, e.toString());
    }
  }

  Future forgotPassword(String email, BuildContext context) async {
    LoadingSpinkit.loadingSpinkit(context);
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop();
      await DialogCustom.diaglogcustom(
          context, true, 'Please your check email');
      return Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        return await DialogCustom.diaglogcustom(
            context, false, 'User not found');
      } else {
        Navigator.of(context).pop();

        return await DialogCustom.diaglogcustom(
            context, false, 'Network no working');
      }
    } catch (e) {
      Navigator.of(context).pop();
      return await DialogCustom.diaglogcustom(context, false, e.toString());
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    LoadingSpinkit.loadingSpinkit(context);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    Navigator.of(context).pop();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    LoadingSpinkit.loadingSpinkit(context);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.of(context).pop();
        await context
            .read<SharePreference>()
            .save('login', userCredential.user!.uid);
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                uid: userCredential.user!.uid,
              ),
            ));
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      return await DialogCustom.diaglogcustom(
          context, false, 'Network no working');
    } catch (e) {
      Navigator.of(context).pop();
      return await DialogCustom.diaglogcustom(context, false, e.toString());
    }
  }
}
