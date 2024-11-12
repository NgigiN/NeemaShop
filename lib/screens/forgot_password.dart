import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/screens/login.dart'; // Import the AppTheme

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _obscureText = true;
  Color _emailFieldColor = Colors.white;
  Color _passwordFieldColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/neema_logo1.png'),
            ),
            const SizedBox(height: 20),
            MouseRegion(
              onEnter: (_) =>
                  setState(() => _emailFieldColor = Colors.grey[300]!),
              onExit: (_) => setState(() => _emailFieldColor = Colors.white),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: _emailFieldColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MouseRegion(
              onEnter: (_) =>
                  setState(() => _passwordFieldColor = Colors.grey[300]!),
              onExit: (_) => setState(() => _passwordFieldColor = Colors.white),
              child: TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "New Password",
                  filled: true,
                  fillColor: _passwordFieldColor,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
