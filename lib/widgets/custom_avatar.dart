import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final double radius;
  final String imagePath;

  const CustomAvatar(
      {super.key, required this.radius, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(imagePath),
    );
  }
}
