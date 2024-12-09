import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../configs/theme.dart';

class SignUpController extends GetxController {
  final ApiService _apiService = ApiService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var obscureText = true.obs;
  var errorMessage = ''.obs;

  bool isHoveredFirstName = false;
  bool isHoveredLastName = false;
  bool isHoveredUsername = false;
  bool isHoveredPhoneNumber = false;
  bool isHoveredEmail = false;
  bool isHoveredPassword = false;
  bool isHoveredConfirmPassword = false;

  void register() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      final response = await _apiService.registerUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        username: usernameController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Registration successful!',
          backgroundColor: AppTheme.successColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Get.toNamed("/login");
      } else {
        Get.snackbar(
          'Error',
          response.body.toString(),
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
    }
  }
}
