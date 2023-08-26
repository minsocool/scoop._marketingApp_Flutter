import 'package:app_marketing_version_2/helpers/validation.dart';
import 'package:app_marketing_version_2/screens/forgot_screen.dart';
import 'package:app_marketing_version_2/screens/signup_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/obscure.dart';
import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/circle_avatar_custom.dart';
import 'package:app_marketing_version_2/widgets/dialog_custom.dart';
import 'package:app_marketing_version_2/widgets/gesture_text.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';
import 'package:app_marketing_version_2/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formState = GlobalKey<FormState>();
  final Function? toggle;
  LoginScreen({this.toggle});
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!
              .unfocus(); //currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _width * 0.05, vertical: _height * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Image.asset('assets/images/login.png'),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: _height * 0.03),
                      child: Text(
                        'Welcome Shopper',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextFormFieldCustom(
                      chooseStyle: true,
                      validator: Validation.validateEmail,
                      onChanged: Validation.saveMail,
                      hintText: 'Enter your email',
                      icon: Icon(Icons.email),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    TextFormFieldCustom(
                      chooseStyle: true,
                      validator: Validation.validatePassword,
                      onChanged: Validation.savePassword,
                      hintText: 'Enter your password',
                      icon: Icon(Icons.lock),
                      obscureText:
                          context.select((Obscure value) => value.obscureLogin),
                      suffixIcon: true,
                      onTap: () => context.read<Obscure>().changeObscureLogin(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: _height * 0.01),
                      child: GestureText(
                          label: 'Forgot password?',
                          colorText: Colors.blue,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotScreen(),
                              ))),
                    ),
                    ButtonCustom(
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            context.read<Authenicator>().signIn(
                                Validation.email!,
                                Validation.password!,
                                context);
                          }
                        },
                        textButton: 'Sign in',
                        color: Colors.blue,
                        textColor: Colors.white,
                        radius: 30,
                        sideColor: Colors.blue,
                        minWidth: double.infinity,
                        height: _height * 0.065),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        GestureText(
                            label: ' Sign up',
                            colorText: Colors.pink.shade200,
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()))),
                      ],
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
