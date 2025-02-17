import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_project/screens/registration.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/screens/forgot_password.dart';
import 'package:shop_project/controllers/login_controller.dart';
import 'package:shop_project/widgets/custom_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

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
              Obx(() => loginController.errorMessage.isNotEmpty
                  ? Text(
                      loginController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),
              CustomTextField(
                controller: loginController.emailController,
                labelText: "Email",
                isHovered: loginController.isHoveredEmail,
                onEnter: () => loginController.isHoveredEmail = true,
                onExit: () => loginController.isHoveredEmail = false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              Obx(() => CustomTextField(
                    controller: loginController.passwordController,
                    labelText: "Password",
                    obscureText: loginController.obscureText.value,
                    isHovered: loginController.isHoveredPassword,
                    onEnter: () => loginController.isHoveredPassword = true,
                    onExit: () => loginController.isHoveredPassword = false,
                    onPressed: () => loginController.obscureText.value =
                        !loginController.obscureText.value,
                  )),
              const SizedBox(height: 20),
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
              Obx(
                () => loginController.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: loginController.login,
                        child: const Text("Login"),
                      ),
              ),
              const SizedBox(height: 20),
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
