import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SharedPreferencesService {
  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userData['id'].toString());
    await prefs.setString('email', userData['email']);
    await prefs.setString('phone_number', userData['phone_number']);

    await prefs.setString('first_name', userData['first_name']);
    await prefs.setString('last_name', userData['last_name']);
  }

  Future<UserModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserModel(
      id: prefs.getString('user_id') ?? '',
      firstName: prefs.getString('first_name') ?? '',
      lastName: prefs.getString('last_name') ?? '',
      phoneNumber: prefs.getString('phone_number') ?? '',
      email: prefs.getString('email') ?? '',
    );
  }
}
