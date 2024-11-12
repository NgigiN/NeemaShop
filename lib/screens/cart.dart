import 'package:flutter/material.dart';
import 'package:shop_project/widgets/custom_app_bar.dart'; // Import the AppTheme

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Cart"),
      body: Center(
        child: Text("Your Cart is empty"),
      ),
    );
  }
}
