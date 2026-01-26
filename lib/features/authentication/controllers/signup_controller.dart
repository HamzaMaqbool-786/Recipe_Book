import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/utils/popups/loader.dart';
import '../../recipie/screens/main/main_screen.dart';
import 'auth_controller.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final AuthController authController = Get.find<AuthController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  Future<void> signup() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      TLoaders.errorSnackBar(title: "Error", message: "All fields are required");
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
     TLoaders.errorSnackBar(title: "Error", message: "Invalid email");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      TLoaders.errorSnackBar(title: "Error", message: "Passwords do not match");
      return;
    }

    isLoading.value = true;

    final success = await authController.signup(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (success) {
      Get.offAll(() => const MainScreen());
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
