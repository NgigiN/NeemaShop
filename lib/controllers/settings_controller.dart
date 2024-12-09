import 'package:flutter/material.dart';
import 'package:shop_project/models/user_model.dart';
import 'package:shop_project/services/api_service.dart';
import 'package:shop_project/services/shared_preferences_service.dart';

class SettingsController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  UserModel _user = UserModel(
    id: '',
    firstName: '',
    lastName: '',
    phoneNumber: '',
    email: '',
  );

  UserModel get user => _user;

  Future<void> loadUserData() async {
    _user = await _sharedPreferencesService.getUserData();
    notifyListeners();
  }

  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      UserModel updatedUserData = await _apiService.updateUser(updatedUser);
      await _sharedPreferencesService.saveUserData(updatedUserData.toJson());
      _user = updatedUserData;
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }
}
