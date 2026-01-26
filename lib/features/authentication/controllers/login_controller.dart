import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/utils/popups/loader.dart';
import '../../recipie/screens/main/main_screen.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final AuthController authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      TLoaders.errorSnackBar(title: "Error",message: "All fields are required");
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      TLoaders.errorSnackBar(title: "Error", message: "Invalid email");

      return;
    }

    isLoading.value = true;

    final success = await authController.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (success) {
      TLoaders.successSnackBar(title: "Welcome Back",message: "Hello,${authController.currentUser.value}");
      Get.offAll(() => const MainScreen());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
