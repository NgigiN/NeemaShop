import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const CustomAppBar(
      {super.key, required this.title, this.automaticallyImplyLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: AppTheme.textColor,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
