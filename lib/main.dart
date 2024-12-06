import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/controllers/settings_controller.dart';
import 'package:shop_project/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);

  runApp(const NeemaShopApp());
}

class NeemaShopApp extends StatelessWidget {
  const NeemaShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsController()),
      ],
      child: GetMaterialApp(
        title: 'Neema Milk Shop',
        theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
        ),
        initialRoute: '/',
        getPages: Routes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
