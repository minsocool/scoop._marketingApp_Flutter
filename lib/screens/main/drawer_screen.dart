import 'package:app_marketing_version_2/screens/main/settings_screen.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  static const List<Color> colorsDrawer = [
    Color(0xFF1B191D),
    Color(0xFF191622),
    Color(0xFF14102B),
    Color(0xFF130F2C),
    Color(0xFF0B0538),
  ];

  static const List<double> stopColorsDrawer = [
    0.1,
    0.2,
    0.4,
    0.7,
    0.6,
  ];
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(
          top: _height * 0.05, left: _width * 0.04, bottom: _height * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: stopColorsDrawer,
          colors: colorsDrawer,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: context.watch<PickImage>().pathImage != null
                    ? CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.redAccent,
                        backgroundImage:
                            FileImage(context.watch<PickImage>().pathImage!),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.redAccent,
                        backgroundImage:
                            AssetImage('assets/images/icon_person.png'),
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                context
                    .read<Authenicator>()
                    .firebaseAuth
                    .currentUser!
                    .displayName
                    .toString(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemPage('Home', Icons.home, _width, _height, () {}),
              itemPage('Cloud', Icons.cloud, _width, _height, () {}),
              itemPage(
                  'Calendar', Icons.calendar_today, _width, _height, () {}),
              itemPage('Location', Icons.location_on, _width, _height, () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              itemPage(
                  'Settings',
                  Icons.settings,
                  _width,
                  _height,
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ))),
              Container(
                height: _height * 0.03,
                width: _width * 0.005,
                color: Colors.white,
              ),
              TextButton(
                onPressed: () => context.read<Authenicator>().signOut(context),
                child: Text(
                  'Log out',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemPage(String label, IconData icon, double width, double height,
      VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
