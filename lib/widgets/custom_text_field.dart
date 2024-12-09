import 'package:flutter/material.dart';
import '../../configs/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final bool isHovered;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.isHovered = false,
    this.onEnter,
    this.onExit,
    this.onPressed,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (onEnter != null) onEnter!();
      },
      onExit: (event) {
        if (onExit != null) onExit!();
      },
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: isHovered ? AppTheme.accentColor : Colors.grey,
              width: 2.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.accentColor,
              width: 2.0,
            ),
          ),
          suffixIcon: onPressed != null
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: onPressed,
                )
              : null,
        ),
      ),
    );
  }
}
