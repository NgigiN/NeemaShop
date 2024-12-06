import 'package:flutter/material.dart';
import '../../configs/theme.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: AppTheme.lightTheme.textTheme.bodyLarge!
            .copyWith(color: Colors.white),
      ),
      backgroundColor: isError ? AppTheme.errorColor : AppTheme.successColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
