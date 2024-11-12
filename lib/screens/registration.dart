import 'package:flutter/material.dart';
import 'package:shop_project/screens/login.dart';
import 'package:shop_project/configs/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
  bool _isHoveredFullName = false;
  bool _isHoveredEmail = false;
  bool _isHoveredPassword = false;
  bool _isHoveredConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/neema_logo1.png'),
            ),
            const SizedBox(height: 50),
            // Full Name TextField
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredFullName = true),
              onExit: (_) => setState(() => _isHoveredFullName = false),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isHoveredFullName
                          ? AppTheme.accentColor
                          : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.accentColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email TextField
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredEmail = true),
              onExit: (_) => setState(() => _isHoveredEmail = false),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          _isHoveredEmail ? AppTheme.accentColor : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.accentColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password TextField
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredPassword = true),
              onExit: (_) => setState(() => _isHoveredPassword = false),
              child: TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isHoveredPassword
                          ? AppTheme.accentColor
                          : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.accentColor,
                      width: 2.0,
                    ),
                  ),
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
            // Confirm Password TextField
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredConfirmPassword = true),
              onExit: (_) => setState(() => _isHoveredConfirmPassword = false),
              child: TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Re-enter Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isHoveredConfirmPassword
                          ? AppTheme.accentColor
                          : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.accentColor,
                      width: 2.0,
                    ),
                  ),
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
            const SizedBox(height: 30),
            // Register Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                print("Registered successfully!");
              },
              child: const Text("Register"),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.g_mobiledata_outlined,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: AppTheme.textColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
