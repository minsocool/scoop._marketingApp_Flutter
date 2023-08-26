import 'package:app_marketing_version_2/screens/log_sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeContent extends StatelessWidget {
  final String image;
  final bool edgeInsets;
  final String text;
  final bool choose;

  final AnimationController? animationController;
  final Animation? animation;
  WelcomeContent({
    required this.image,
    required this.text,
    required this.choose,
    required this.edgeInsets,
    this.animation,
    this.animationController,
  });
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        choose
            ? Text(
                'Let\'s get started',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold),
              )
            : _skip(context),
        Expanded(
          flex: 5,
          child: Padding(
            padding: edgeInsets
                ? EdgeInsets.symmetric(
                    horizontal: _width * 0.15, vertical: _height * 0.04)
                : EdgeInsets.symmetric(
                    horizontal: _width * 0.20, vertical: _height * 0.08),
            child: edgeInsets
                ? _container(_width, _height)
                : _animationContainer(_width, _height),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(top: _height * 0.001),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ],
    );
  }

  Widget _skip(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MaterialApp(home: LogSignScreen()),
                )),
            child: Text(
              'Skip',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget _container(double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          width * 0.05, height * 0.05, width * 0.05, height * 0.07),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(14, 16),
            blurRadius: 10,
            color: Colors.grey.shade400,
          )
        ],
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image(
          image: AssetImage(image),
        ),
      ),
    );
  }

  Widget _animationContainer(double width, double height) {
    return AnimatedBuilder(
      animation: animationController!.view,
      builder: (context, child) => Transform.rotate(
        angle: animation!.value,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
              width * 0.05, height * 0.02, width * 0.1, height * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(14, -16),
                blurRadius: 10,
                color: Colors.grey.shade400,
              )
            ],
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage(image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
