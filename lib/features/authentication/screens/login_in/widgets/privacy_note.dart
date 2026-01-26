import 'package:flutter/material.dart';

class PrivacyNote extends StatelessWidget {
  const PrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your data is stored securely on your device',
      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
      textAlign: TextAlign.center,
    );
  }
}
