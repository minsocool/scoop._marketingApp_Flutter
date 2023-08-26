import 'package:app_marketing_version_2/helpers/validation.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/gesture_text.dart';
import 'package:app_marketing_version_2/widgets/text_form_field_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class ForgotScreen extends StatelessWidget {
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/forgot.png',
              scale: 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _height * 0.05, horizontal: _width * 0.1),
              child: Column(
                children: [
                  Text(
                    'Forgot your password?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                    child: Text(
                      'If you have forgotten your password, you can see reset it here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Form(
                    key: _formState,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormFieldCustom(
                        chooseStyle: false,
                        validator: Validation.validateEmail,
                        onChanged: Validation.saveMail,
                        hintText: 'Please enter your email',
                        icon: Icon(Icons.email)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                    child: ButtonCustom(
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            context
                                .read<Authenicator>()
                                .forgotPassword(Validation.email!, context);
                          }
                        },
                        textButton: 'Reset Password',
                        color: Colors.blue,
                        textColor: Colors.white,
                        radius: 30,
                        sideColor: Colors.blue,
                        height: _height * 0.065),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do you remember the password?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                      GestureText(
                          label: ' Login',
                          colorText: Colors.pink.shade200,
                          onTap: () => Navigator.pop(context))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
