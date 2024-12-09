import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:shop_project/screens/cart.dart';
import 'package:shop_project/screens/homepage.dart';
import 'package:shop_project/screens/settings.dart';
import 'cart_controller.dart';

class MainScreenController extends GetxController {
  final FlutterCart cart = FlutterCart();
  final CartController cartController = Get.put(CartController());

  var _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartScreen(),
    const SettingsPage(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    update();
  }

  int get selectedIndex => _selectedIndex;
  List<Widget> get pages => _pages;
}
