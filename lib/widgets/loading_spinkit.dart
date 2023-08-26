import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinkit {
  static loadingSpinkit(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SpinKitPouringHourglass(
            duration: Duration(seconds: 1),
            color: Colors.white,
            size: 50,
          ));
}
