import 'package:flutter/material.dart';

class CircleAvatarCustom extends StatelessWidget {
  final VoidCallback onTap;
  final String images;
  final double radius;

  CircleAvatarCustom({
    required this.onTap,
    required this.images,
    required this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: AssetImage(images),
        radius: radius,
      ),
    );
  }
}
