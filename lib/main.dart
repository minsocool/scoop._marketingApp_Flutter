import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/main/drawer_screen.dart';
import 'package:app_marketing_version_2/screens/main/main_screen.dart';
import 'package:app_marketing_version_2/screens/welcome_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/cloud_firestore.dart';
import 'package:app_marketing_version_2/view_models/obscure.dart';
import 'package:app_marketing_version_2/view_models/pick_image.dart';
import 'package:app_marketing_version_2/view_models/share_preference.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<SharePreference>(
        create: (context) => SharePreference(),
      ),
      Provider<CloudFirestore>(
        create: (_) => CloudFirestore(FirebaseFirestore.instance),
      ),
      ChangeNotifierProvider<Obscure>(
        create: (_) => Obscure(),
      ),
      Provider<Authenicator>(
        create: (_) => Authenicator(FirebaseAuth.instance),
      ),
      ChangeNotifierProvider<PickImage>(
        create: (_) => PickImage(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 5)),
      builder: (context, snapshot) => FutureBuilder(
        future: context.read<SharePreference>().read('welcome'),
        builder: (context, snapshot1) => FutureBuilder(
          future: context.read<SharePreference>().read('login'),
          builder: (context, snapshot2) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(home: SplashScreen());
            } else {
              if (snapshot1.hasData && snapshot1.data != null) {
                if (snapshot2.hasData && snapshot1.data != null) {
                  return MaterialApp(
                      home: MainScreen(
                    uid: snapshot2.data.toString(),
                  ));
                } else
                  return MaterialApp(home: LoginScreen());
              }
              return MaterialApp(home: WelcomeScreen());
            }
          },
        ),
      ),
    );
  }
}
