// settings_controller.dart

import 'package:get/get.dart';
import 'package:shop_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/services/api_service.dart';

class SettingsController extends GetxController {
  final Rx<UserModel> user = UserModel(
    id: '',
    email: '',
    phoneNumber: '',
    firstName: '',
    lastName: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      user.value = UserModel(
        id: prefs.getString('id') ?? '',
        email: prefs.getString('email') ?? '',
        phoneNumber: prefs.getString('phone') ?? '',
        firstName: prefs.getString('firstname') ?? '',
        lastName: prefs.getString('lastname') ?? '',
      );
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      var apiService = ApiService();
      var response = await apiService.updateUser('/update-user/', {
        "first_name": updatedUser.firstName,
        "last_name": updatedUser.lastName,
        "email": updatedUser.email,
        "phone_number": updatedUser.phoneNumber,
      });

      if (response.statusCode == 200) {
        user.value = updatedUser;
      } else {
        throw "Failed to update user data: ${response.body}";
      }
    } catch (e) {
      throw "Failed to update profile: ${e.toString()}";
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all stored data
      user.value = UserModel(
        id: '',
        email: '',
        phoneNumber: '',
        firstName: '',
        lastName: '',
      );
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
