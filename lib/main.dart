import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/controllers/cart_controller.dart';
import 'package:shop_project/controllers/settings_controller.dart';
import 'package:shop_project/utils/routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CartController());
  Get.put(SettingsController());

  runApp(const NeemaShopApp());
}

class NeemaShopApp extends StatelessWidget {
  const NeemaShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Neema Milk Shop',
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
      ),
      initialRoute: '/',
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
