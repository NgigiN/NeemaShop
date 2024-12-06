import 'package:flutter/material.dart';
import '../../configs/theme.dart';

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
        style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
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
