import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controller.dart';
import '../../configs/theme.dart';
import '../widgets/custom_text_field.dart';
import '../screens/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/neema_logo1.png',
              ),
              const SizedBox(height: 50),
              Obx(() => signUpController.errorMessage.isNotEmpty
                  ? Text(
                      signUpController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),
              CustomTextField(
                controller: signUpController.firstNameController,
                labelText: "First Name",
                isHovered: signUpController.isHoveredFirstName,
                onEnter: () => signUpController.isHoveredFirstName = true,
                onExit: () => signUpController.isHoveredFirstName = false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: signUpController.lastNameController,
                labelText: "Last Name",
                isHovered: signUpController.isHoveredLastName,
                onEnter: () => signUpController.isHoveredLastName = true,
                onExit: () => signUpController.isHoveredLastName = false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: signUpController.emailController,
                labelText: "Email",
                isHovered: signUpController.isHoveredEmail,
                onEnter: () => signUpController.isHoveredEmail = true,
                onExit: () => signUpController.isHoveredEmail = false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: signUpController.usernameController,
                labelText: "Username",
                isHovered: signUpController.isHoveredUsername,
                onEnter: () => signUpController.isHoveredUsername = true,
                onExit: () => signUpController.isHoveredUsername = false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: signUpController.phoneNumberController,
                labelText: "Phone Number",
                isHovered: signUpController.isHoveredPhoneNumber,
                onEnter: () => signUpController.isHoveredPhoneNumber = true,
                onExit: () => signUpController.isHoveredPhoneNumber = false,
              ),
              const SizedBox(height: 20),
              Obx(() => CustomTextField(
                    controller: signUpController.passwordController,
                    labelText: "Password",
                    obscureText: signUpController.obscureText.value,
                    isHovered: signUpController.isHoveredPassword,
                    onEnter: () => signUpController.isHoveredPassword = true,
                    onExit: () => signUpController.isHoveredPassword = false,
                    onPressed: () => signUpController.obscureText.value =
                        !signUpController.obscureText.value,
                  )),
              const SizedBox(height: 20),
              Obx(() => CustomTextField(
                    controller: signUpController.confirmPasswordController,
                    labelText: "Re-enter Password",
                    obscureText: signUpController.obscureText.value,
                    isHovered: signUpController.isHoveredConfirmPassword,
                    onEnter: () =>
                        signUpController.isHoveredConfirmPassword = true,
                    onExit: () =>
                        signUpController.isHoveredConfirmPassword = false,
                    onPressed: () => signUpController.obscureText.value =
                        !signUpController.obscureText.value,
                  )),
              const SizedBox(height: 20),
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
                onPressed: signUpController.register,
                child: const Text("Register"),
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}
