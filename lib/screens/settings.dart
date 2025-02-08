import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:shop_project/controllers/login_controller.dart';
import 'package:shop_project/controllers/settings_controller.dart';
import 'package:shop_project/models/user_model.dart';
import 'package:provider/provider.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late final SettingsController settingsController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    settingsController = Get.find<SettingsController>();
    _loadUserData();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        firstNameController.text = prefs.getString('firstname') ?? '';
        lastNameController.text = prefs.getString('lastname') ?? '';
        emailController.text = prefs.getString('email') ?? '';
        phoneController.text = prefs.getString('phone') ?? '';
      });
    } catch (e) {
      _showErrorSnackbar('Error loading user data');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _updateUserData(UserModel updatedUser) async {
    setState(() => isLoading = true);
    try {
      await settingsController.updateUserData(updatedUser);

      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstname', updatedUser.firstName);
      await prefs.setString('lastname', updatedUser.lastName);
      await prefs.setString('email', updatedUser.email);
      await prefs.setString('phone', updatedUser.phoneNumber);

      // Refresh the page data
      await _loadUserData();

      _showSuccessSnackbar('Profile updated successfully');
    } catch (e) {
      _showErrorSnackbar('Error updating profile: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Settings",
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileInfo('Name',
                        '${firstNameController.text} ${lastNameController.text}'),
                    _buildProfileInfo('Phone Number', phoneController.text),
                    _buildProfileInfo('Email', emailController.text),
                    _buildProfileInfo('Points', '1200'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _showEditProfileDialog(context),
                      child: const Text('Update Profile'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await settingsController.logout();
                        Get.offAllNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final dialogFirstNameController =
        TextEditingController(text: firstNameController.text);
    final dialogLastNameController =
        TextEditingController(text: lastNameController.text);
    final dialogPhoneController =
        TextEditingController(text: phoneController.text);
    final dialogEmailController =
        TextEditingController(text: emailController.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('First Name', dialogFirstNameController),
                const SizedBox(height: 8),
                _buildTextField('Last Name', dialogLastNameController),
                const SizedBox(height: 8),
                _buildTextField('Phone Number', dialogPhoneController),
                const SizedBox(height: 8),
                _buildTextField('Email', dialogEmailController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs(
                  dialogFirstNameController.text,
                  dialogLastNameController.text,
                  dialogEmailController.text,
                  dialogPhoneController.text,
                )) {
                  _updateUserData(UserModel(
                    id: settingsController.user.value.id,
                    email: dialogEmailController.text,
                    phoneNumber: dialogPhoneController.text,
                    firstName: dialogFirstNameController.text,
                    lastName: dialogLastNameController.text,
                  ));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  bool _validateInputs(
      String firstName, String lastName, String email, String phone) {
    if (firstName.isEmpty || lastName.isEmpty) {
      _showErrorSnackbar('Please enter both first and last name');
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      _showErrorSnackbar('Please enter a valid email address');
      return false;
    }
    if (!GetUtils.isPhoneNumber(phone)) {
      _showErrorSnackbar('Please enter a valid phone number');
      return false;
    }
    return true;
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
