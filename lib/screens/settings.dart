import 'package:flutter/material.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:shop_project/controllers/settings_controller.dart';
import 'package:shop_project/models/user_model.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Settings",
        automaticallyImplyLeading: false, // Disable leading widget for HomePage
      ),
      body: Center(
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
                  '${settingsController.user.firstName} ${settingsController.user.lastName}'),
              _buildProfileInfo(
                  'Phone Number', settingsController.user.phoneNumber),
              _buildProfileInfo('Email', settingsController.user.email),
              _buildProfileInfo(
                  'Points', '1200'), // Assuming points are static for now
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showEditProfileDialog(context, settingsController);
                },
                child: const Text('Update'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
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
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showEditProfileDialog(
      BuildContext context, SettingsController settingsController) {
    TextEditingController nameController = TextEditingController(
        text:
            '${settingsController.user.firstName} ${settingsController.user.lastName}');
    TextEditingController phoneController =
        TextEditingController(text: settingsController.user.phoneNumber);
    TextEditingController emailController =
        TextEditingController(text: settingsController.user.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Name', nameController),
              _buildTextField('Phone Number', phoneController),
              _buildTextField('Email', emailController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await settingsController.updateUserData(UserModel(
                    id: settingsController.user.id,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    firstName: nameController.text.split(' ')[0],
                    lastName: nameController.text.split(' ')[1],
                  ));
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating user data: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
