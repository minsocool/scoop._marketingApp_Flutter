import 'package:flutter/material.dart';

import 'button_custom.dart';

class DialogCustom {
  static diaglogcustom(
          BuildContext context, bool choose, String content) async =>
      await showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) => Dialog(
            child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      choose ? 'Success' : 'Error',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonCustom(
                      onPressed: () => Navigator.of(context).pop(),
                      color: choose ? Colors.green : Colors.redAccent,
                      height: 35,
                      radius: 30,
                      sideColor: choose ? Colors.green : Colors.redAccent,
                      textButton: choose ? 'Ok' : 'Retry',
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: -40,
                child: CircleAvatar(
                  backgroundColor: choose ? Colors.green : Colors.redAccent,
                  radius: 40,
                  child: Icon(
                    choose ? Icons.check_circle : Icons.error,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        )),
      );
}
