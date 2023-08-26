import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'scoop .',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: _height * 0.04),
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/splash_screen.png'),
                  radius: 100,
                ),
              ),
              Text(
                'All you need',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(10, 10),
                        blurRadius: 7,
                      ),
                    ]),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              SpinKitPouringHourglass(
                color: Colors.pink.shade300,
                duration: Duration(seconds: 1),
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
