import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.surfaceColor, width: 2.0)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
      ),
    );
  }
}
