import 'package:flutter/material.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _username = '';
  String _phoneNumber = '';
  String _email = '';
  int _points = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _phoneNumber = prefs.getString('phone_number') ?? '';
      _email = prefs.getString('email') ?? '';
      _points = prefs.getInt('points') ?? 0;
    });
  }

  Future<void> updateUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('http://localhost:8000/api/update-user/');
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      // Update shared preferences with the new data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'username', userData['first_name'] + ' ' + userData['last_name']);
      await prefs.setString('phone_number', userData['phone_number']);
      await prefs.setString('email', userData['email']);
      // Add other fields as needed
    } else {
      throw Exception('Failed to update user data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _buildProfileInfo('Name', _username),
              _buildProfileInfo('Phone Number', _phoneNumber),
              _buildProfileInfo('Email', _email),
              _buildProfileInfo('Points', _points.toString()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showEditProfileDialog(context);
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

  void _showEditProfileDialog(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: _username);
    TextEditingController phoneController =
        TextEditingController(text: _phoneNumber);
    TextEditingController emailController = TextEditingController(text: _email);

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
                  await updateUser({
                    'first_name': nameController.text.split(' ')[0],
                    'last_name': nameController.text.split(' ')[1],
                    'phone_number': phoneController.text,
                    'email': emailController.text,
                  });
                  // Reload user data after update
                  _loadUserData();
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
