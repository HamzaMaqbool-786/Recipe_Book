import 'package:flutter/cupertino.dart';

import 'custom_text_field.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const NumberField({
    required this.controller,
    required this.label,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: label,
      icon: icon,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        if (int.tryParse(value) == null) return 'Enter number';
        return null;
      },
    );
  }
}
