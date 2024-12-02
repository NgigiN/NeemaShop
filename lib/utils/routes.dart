import 'package:get/get_navigation/get_navigation.dart';
import 'package:shop_project/screens/homepage.dart';
import 'package:shop_project/screens/login.dart';
import 'package:shop_project/screens/registration.dart';
import 'package:shop_project/screens/cart.dart';
import 'package:shop_project/screens/settings.dart';
import 'package:shop_project/screens/main_screen.dart';
import 'package:shop_project/screens/splashscreen.dart';

class Routes {
  static var routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/mainscreen', page: () => const MainScreen()),
    GetPage(name: '/homepage', page: () => const HomePage()),
    GetPage(name: '/signup', page: () => const SignUp()),
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/homepage', page: () => const HomePage()),
    GetPage(name: '/cart', page: () => const CartScreen()),
    GetPage(name: '/settings', page: () => const SettingsPage())
  ];
}
