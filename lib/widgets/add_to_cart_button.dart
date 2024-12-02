import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  const AddToCartButton({
    super.key,
    required this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Add to Cart",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
