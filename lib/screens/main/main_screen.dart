import 'package:app_marketing_version_2/screens/main/drawer_screen.dart';
import 'package:app_marketing_version_2/widgets/main_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  final String? uid;
  MainScreen({this.uid});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  double _xOffset = 0;
  double _yOffset = 0;
  double _scaleFactor = 1;
  bool _isDrawerOpen = false;

  void changedOpen() {
    _xOffset = 260;
    _yOffset = 100;
    _scaleFactor = 0.72;
    _isDrawerOpen = true;
  }

  void changedClose() {
    _xOffset = 0;
    _yOffset = 0;
    _scaleFactor = 1;
    _isDrawerOpen = false;
  }

  late AnimationController _animationController;
  late String date;
  late String textDate;
  CollectionReference documentStream =
      FirebaseFirestore.instance.collection('data');

  @override
  void initState() {
    date = DateFormat('MM-dd-yyyy').format(DateTime.now());
    textDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              DrawerScreen(),
              GestureDetector(
                onTap: () {
                  if (_animationController.isCompleted) {
                    setState(() {
                      changedClose();
                      _animationController.reverse();
                    });
                  }
                },
                onHorizontalDragStart: (details) {
                  if (details.localPosition.dx < 300) {
                    setState(() {
                      changedOpen();
                      _animationController.forward();
                    });
                  }
                },
                child: AnimatedContainer(
                  width: double.infinity,
                  duration: Duration(milliseconds: 500),
                  transform: Matrix4.translationValues(_xOffset, _yOffset, 0)
                    ..scale(_scaleFactor),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(_isDrawerOpen ? 40 : 0),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.03,
                        right: _width * 0.03,
                        top: _height * 0.03),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (_animationController.isCompleted) {
                                setState(() {
                                  changedClose();
                                  _animationController.reverse();
                                });
                              } else {
                                setState(() {
                                  changedOpen();
                                  _animationController.forward();
                                });
                              }
                            },
                            child: AnimatedIcon(
                                icon: AnimatedIcons.menu_home,
                                progress: _animationController),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Discover',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF15096F),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: _height * 0.02),
                                  child: Text(
                                    'Your daily dose of design inspiration',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF15096F),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Ngày lựa chọn hiện tại: ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2021),
                                                lastDate: DateTime(2030))
                                            .then((value) {
                                          setState(() {
                                            date = DateFormat('MM-dd-yyyy')
                                                .format(value!);
                                            textDate = DateFormat('dd-MM-yyyy')
                                                .format(value);
                                          });
                                        });
                                      },
                                      child: Text(
                                        textDate,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                StreamBuilder<DocumentSnapshot<dynamic>>(
                                  stream: documentStream.doc(date).snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return AspectRatio(
                                        aspectRatio: _aspectRatio * 1.5,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SpinKitPumpingHeart(
                                                color: Colors.red,
                                                duration: Duration(seconds: 1),
                                                size: 50,
                                              ),
                                              Text('Loading...',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasData &&
                                        snapshot.data!.exists) {
                                      return MainData(
                                        age: snapshot.data!.data()['age'],
                                        valueMan: snapshot.data!
                                            .data()['man']
                                            .toDouble(),
                                        valueWoman: snapshot.data!
                                            .data()['woman']
                                            .toDouble(),
                                        titleMan: snapshot.data!
                                            .data()['man']
                                            .toString(),
                                        titleWoman: snapshot.data!
                                            .data()['woman']
                                            .toString(),
                                        offSetMan:
                                            snapshot.data!.data()['woman'] == 0
                                                ? 0
                                                : 0.5,
                                        offSetWoman:
                                            snapshot.data!.data()['man'] == 0
                                                ? 0
                                                : 0.5,
                                      );
                                    }
                                    return MainData(
                                      list: 3,
                                      age: [0, 0, 0, 0],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
