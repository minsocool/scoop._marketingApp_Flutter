import 'dart:math';

import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/welcome_content.dart';

import 'package:flutter/material.dart';

import 'log_sign_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late List<WelcomeContent> _content;
  late PageController _pageController;
  late int _numPage;
  late AnimationController _animationController;
  late Animation _animation;
  @override
  void initState() {
    _numPage = 0;
    _pageController = PageController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animation = Tween(begin: 0.0, end: pi / 2).animate(_animationController);
    _content = [
      WelcomeContent(
        image: 'assets/images/welcome_1.png',
        edgeInsets: true,
        text: 'Distinguish between gentle man and lady',
        choose: true,
      ),
      WelcomeContent(
        image: 'assets/images/welcome_2.png',
        edgeInsets: true,
        text: 'Detection age',
        choose: false,
      ),
      WelcomeContent(
        animation: _animation,
        animationController: _animationController,
        image: 'assets/images/welcome_3.png',
        edgeInsets: false,
        text: 'Detection',
        choose: false,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(vertical: _height * 0.02),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: _content,
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _numPage = value;
                });
                if (_content.length - 1 != value) {
                  _animationController.reverse();
                } else
                  _animationController.forward();
              },
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(_content.length, (int index) {
                return AnimatedContainer(
                    duration: Duration(microseconds: 300),
                    height: 15,
                    width: (index == _numPage) ? 15 : 15,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (index == _numPage)
                            ? Colors.black
                            : Colors.black.withOpacity(0.5)));
              })),
          ButtonCustom(
              onPressed: () {
                _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linearToEaseOut);
                if (_numPage == _content.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LogSignScreen()),
                  );
                }
              },
              height: _height * 0.08,
              minWidth: _width * 0.4,
              radius: 15,
              sideColor:
                  (_numPage == _content.length - 1) ? Colors.red : Colors.blue,
              textColor: (_numPage == _content.length - 1)
                  ? Colors.white
                  : Colors.black,
              textButton:
                  (_numPage == _content.length - 1) ? 'Let\'s go' : 'Next',
              color:
                  (_numPage == _content.length - 1) ? Colors.red : Colors.white)
        ],
      ),
    )));
  }
}
