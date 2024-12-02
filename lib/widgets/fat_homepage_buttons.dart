import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  final String imagePath;
  final double size;
  final Color color;
  final VoidCallback onPressed;
  final String label;

  const SquareIconButton(
      {super.key,
      required this.imagePath,
      required this.size,
      required this.color,
      required this.onPressed,
      required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
