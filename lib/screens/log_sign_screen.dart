import 'package:app_marketing_version_2/screens/signup_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/share_preference.dart';
import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/circle_avatar_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class LogSignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _width * 0.1, vertical: _height * 0.08),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/welcome_4.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height * 0.03, bottom: _height * 0.01),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'this app is social media platform for artists - and it\'s all about visuals',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonCustom(
                            onPressed: () async {
                              await context
                                  .read<SharePreference>()
                                  .save('welcome', 'first');
                              await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            radius: 30,
                            sideColor: Colors.blue,
                            height: _height * 0.07,
                            minWidth: _width * 0.35,
                            textButton: 'Login',
                            color: Colors.blue,
                            textColor: Colors.white),
                        ButtonCustom(
                            onPressed: () async {
                              await context
                                  .read<SharePreference>()
                                  .save('welcome', 'first');
                              await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()));
                            },
                            radius: 30,
                            sideColor: Colors.blue,
                            height: _height * 0.07,
                            minWidth: _width * 0.35,
                            textButton: 'Sign Up',
                            color: Colors.white,
                            textColor: Colors.black)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: _height * 0.02),
                  child: Text(
                    'Or via Social Media',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatarCustom(
                        onTap: () {},
                        images: 'assets/images/facebook.png',
                        radius: 30),
                    SizedBox(
                      width: _width * 0.1,
                    ),
                    CircleAvatarCustom(
                        onTap: () => context
                            .read<Authenicator>()
                            .signInWithGoogle(context),
                        images: 'assets/images/google.png',
                        radius: 30),
                  ],
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
