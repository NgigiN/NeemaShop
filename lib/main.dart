import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/utils/routes.dart';

// void main() => runApp(GetMaterialApp(
//       theme: AppTheme.lightTheme,
//       initialRoute: "/login",
//       getPages: [GetPage(name: "/login", page: () => const Login())],
//     ));

void main() {
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
    );
  }
}
