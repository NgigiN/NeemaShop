import 'package:get/get_navigation/get_navigation.dart';
import 'package:shop_project/screens/homepage.dart';
import 'package:shop_project/screens/login.dart';
import 'package:shop_project/screens/registration.dart';
import 'package:shop_project/screens/cart.dart';
import 'package:shop_project/screens/profile.dart';
import 'package:shop_project/screens/main_screen.dart';

class Routes {
  static var routes = [
    GetPage(name: '/', page: () => const MainScreen()),
    GetPage(name: '/homepage', page: () => const HomePage()),
    GetPage(name: '/signup', page: () => const SignUp()),
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/homepage', page: () => const HomePage()),
    GetPage(name: '/cart', page: () => const CartContent()),
    GetPage(name: '/profile', page: () => const ProfileContent())
  ];
}
