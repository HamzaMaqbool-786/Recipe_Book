
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget buildInfoItem({
  required IconData icon,
  required String label,
  Color? color,
  required BuildContext context,
}) {
  return Column(
    children: [
      Icon(icon, color: color ?? Get.theme.colorScheme.primary),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}