import 'package:app_marketing_version_2/helpers/validation.dart';
import 'package:app_marketing_version_2/screens/login_screen.dart';
import 'package:app_marketing_version_2/screens/success_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/obscure.dart';
import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/dialog_custom.dart';
import 'package:app_marketing_version_2/widgets/gesture_text.dart';
import 'package:app_marketing_version_2/widgets/text_form_field_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('2');
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: _width * 0.1, right: _width * 0.1, top: _height * 0.05),
            child: Form(
              key: _formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * 0.04),
                    child: Text(
                      'Create Your account by filling up the form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormFieldCustom(
                    validator: Validation.validateName,
                    chooseStyle: false,
                    hintText: 'Enter your name',
                    icon: Icon(Icons.person),
                    onChanged: Validation.saveName,
                  ),
                  TextFormFieldCustom(
                    validator: Validation.validateEmail,
                    onChanged: Validation.saveMail,
                    chooseStyle: false,
                    hintText: 'Enter your email',
                    icon: Icon(Icons.email),
                  ),
                  TextFormFieldCustom(
                    validator: Validation.validatePassword,
                    chooseStyle: false,
                    onChanged: Validation.savePassword,
                    hintText: 'Enter your password',
                    icon: Icon(Icons.lock),
                    obscureText:
                        context.select((Obscure value) => value.obscureSignup),
                    suffixIcon: true,
                    onTap: () => context.read<Obscure>().changeObscureSignup(),
                  ),
                  TextFormFieldCustom(
                    chooseStyle: false,
                    validator: Validation.validateRePassword,
                    hintText: 'Re-type password',
                    icon: Icon(Icons.lock),
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _height * 0.05),
                    child: ButtonCustom(
                      textButton: 'Sign up',
                      color: Colors.blue,
                      textColor: Colors.white,
                      radius: 30,
                      sideColor: Colors.blue,
                      height: _height * 0.07,
                      minWidth: _width * 0.4,
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          context.read<Authenicator>().signUp(Validation.email!,
                              Validation.password!, Validation.name!, context);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        GestureText(
                            label: ' Login',
                            colorText: Colors.pink.shade200,
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/signup.png',
                  fit: BoxFit.cover,
                )),
          ),
        ],
      )),
    );
  }
}
