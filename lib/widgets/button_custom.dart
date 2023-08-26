import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final Color color;
  final Color textColor;
  final double radius;
  final Color sideColor;
  final double minWidth;
  final double height;
  ButtonCustom({
    required this.onPressed,
    required this.textButton,
    required this.color,
    required this.textColor,
    required this.radius,
    required this.sideColor,
    this.minWidth = 30,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(width: 1, color: sideColor)),
      minWidth: minWidth,
      height: height,
      child: Text(
        textButton,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoMono(
            fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
