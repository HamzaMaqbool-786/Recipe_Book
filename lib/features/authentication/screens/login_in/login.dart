import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/authentication/screens/login_in/widgets/login_form.dart';
import 'package:recipe_book/features/authentication/screens/login_in/widgets/login_logo.dart';
import 'package:recipe_book/features/authentication/screens/login_in/widgets/login_title.dart';
import 'package:recipe_book/features/authentication/screens/login_in/widgets/privacy_note.dart';
import '../../../authentication/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Get.theme.colorScheme.primary,
              Get.theme.colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoginLogo(),
                  const SizedBox(height: 40),
                  const LoginTitle(),
                  const SizedBox(height: 60),
                  LoginForm(controller: controller),
                  const SizedBox(height: 30),
                  const PrivacyNote(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




