import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/authentication/screens/sign-up/widgets/sign_up_form.dart';
import 'package:recipe_book/features/authentication/screens/sign-up/widgets/signup_privacy_note.dart';
import 'package:recipe_book/features/authentication/screens/sign-up/widgets/signup_title.dart';
import 'package:recipe_book/features/authentication/screens/sign-up/widgets/sigup_logo.dart';
import '../../../authentication/controllers/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

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
                  const SignupLogo(),
                  const SizedBox(height: 30),
                  const SignupTitle(),
                  const SizedBox(height: 40),
                  SignupForm(controller: controller),
                  const SizedBox(height: 20),
                  const SignUpPrivacyNote(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



