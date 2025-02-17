import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../services/api_service.dart';
import '../services/shared_preferences_service.dart';
import '../configs/theme.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var obscureText = true.obs;
  var errorMessage = ''.obs;

  bool isHoveredEmail = false;
  bool isHoveredPassword = false;

  @override
  void onInit() {
    super.onInit();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final email = await _sharedPreferencesService.getEmail();
    emailController.text = email;
  }

  Future<void> _saveEmail(String email) async {
    await _sharedPreferencesService.saveEmail(email);
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    await _sharedPreferencesService.saveUserData(userData);
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final userData = responseData['user'];

        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: AppTheme.successColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        _saveEmail(emailController.text);
        _saveUserData(userData);
        Get.toNamed('/mainscreen');
      } else {
        Get.snackbar(
          'Error',
          'Invalid email or password',
          backgroundColor: AppTheme.errorColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
