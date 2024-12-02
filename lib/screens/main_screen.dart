import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shop_project/screens/homepage.dart';
import 'package:shop_project/screens/settings.dart';
import 'package:shop_project/screens/cart.dart';
import 'package:shop_project/configs/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final FlutterCart cart = FlutterCart();
  static final ValueNotifier<int> cartLengthNotifier =
      ValueNotifier<int>(FlutterCart().cartLength);

  // List of main pages for bottom navigation
  final List<Widget> _pages = [
    const HomePage(),
    const CartScreen(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.yellow[300],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: AppTheme.specialColor,
            unselectedColor: AppTheme.textColor.withOpacity(0.6),
          ),
          SalomonBottomBarItem(
            icon: ValueListenableBuilder(
              valueListenable: cartLengthNotifier,
              builder: (context, cartLength, _) {
                return Badge(
                  label: Text('$cartLength'),
                  child: const Icon(Icons.shopping_cart),
                );
              },
            ),
            title: const Text("Cart"),
            selectedColor: AppTheme.specialColor,
            unselectedColor: AppTheme.textColor.withOpacity(0.6),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text("Settings"),
            selectedColor: AppTheme.specialColor,
            unselectedColor: AppTheme.textColor.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
