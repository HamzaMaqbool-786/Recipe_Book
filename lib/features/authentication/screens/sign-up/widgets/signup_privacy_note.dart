import 'package:flutter/material.dart';

class SignUpPrivacyNote extends StatelessWidget {
  const SignUpPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'By signing up, you agree to our Terms & Privacy Policy',
      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
      textAlign: TextAlign.center,
    );
  }
}
