import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';
import '../../controllers/main_screen_controller.dart';
import '../../configs/theme.dart';
import '../../controllers/cart_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainScreenController = Get.put(MainScreenController());
    final cartController = Get.find<CartController>();

    return GetBuilder<MainScreenController>(
      builder: (controller) {
        return Scaffold(
          body: controller.pages[controller.selectedIndex],
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: Colors.yellow[300],
            currentIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: AppTheme.specialColor,
                unselectedColor: AppTheme.textColor.withOpacity(0.6),
              ),
              SalomonBottomBarItem(
                icon: Obx(() => Badge(
                      label: Text('${cartController.cartLength.value}'),
                      child: const Icon(Icons.shopping_cart),
                    )),
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
      },
    );
  }
}
