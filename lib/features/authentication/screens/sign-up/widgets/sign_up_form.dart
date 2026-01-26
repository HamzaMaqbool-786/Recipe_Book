import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controllers/signup_controller.dart';
import '../../login_in/login.dart';

class SignupForm extends StatelessWidget {
  final SignupController controller;
  const SignupForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: controller.nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: controller.emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            Obx(() => _buildTextField(
              controller: controller.passwordController,
              label: 'Password',
              icon: Icons.lock_outline,
              obscureText: controller.obscurePassword.value,
              suffix: IconButton(
                icon: Icon(controller.obscurePassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: controller.togglePassword,
              ),
            )),
            const SizedBox(height: 16),
            Obx(() => _buildTextField(
              controller: controller.confirmPasswordController,
              label: 'Confirm Password',
              icon: Icons.lock_outline,
              obscureText: controller.obscureConfirmPassword.value,
              suffix: IconButton(
                icon: Icon(controller.obscureConfirmPassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: controller.toggleConfirmPassword,
              ),
            )),
            const SizedBox(height: 24),
            Obx(() => ElevatedButton(
              onPressed:
              controller.isLoading.value ? null : controller.signup,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                TextButton(
                  onPressed: () => Get.off(() => const LoginScreen()),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
