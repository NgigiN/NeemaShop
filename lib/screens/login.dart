import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/screens/main_screen.dart';
import 'package:shop_project/screens/registration.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/screens/forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool _isHoveredEmail = false;
  bool _isHoveredPassword = false;
  String? _errorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    _emailController.text = email;
  }

  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Basic validation
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password';
      });
      return;
    }

    // Sample hardcoded credentials
    const hardcodedEmail = 'user@example.com';
    const hardcodedPassword = 'password123';

    // Authentication logic
    if (email == hardcodedEmail && password == hardcodedPassword) {
      // Save the email
      _saveEmail(email);

      // Navigate to the homepage
      Get.to(() => const MainScreen());
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/neema_logo1.png'),
              const SizedBox(height: 30),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredEmail = true),
                onExit: (_) => setState(() => _isHoveredEmail = false),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isHoveredEmail
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
              const SizedBox(height: 30),
              // Password TextField
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredPassword = true),
                onExit: (_) => setState(() => _isHoveredPassword = false),
                child: TextField(
                  controller: _passwordController,
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
              // Forgot Password TextButton Widget
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Login Button
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
                onPressed: _login,
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30.0),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                    child: const Text("Sign up",
                        style: TextStyle(color: AppTheme.textColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
