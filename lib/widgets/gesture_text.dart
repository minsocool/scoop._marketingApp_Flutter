import 'package:flutter/material.dart';

class GestureText extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color colorText;

  GestureText({
    required this.label,
    required this.colorText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
            color: colorText, fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
