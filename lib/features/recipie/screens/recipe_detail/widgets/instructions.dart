import 'package:flutter/material.dart';

import '../../../../../data/models/recipe.dart';
import 'instructions_steps.dart';

Widget buildInstructions(Recipe recipe, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.format_list_numbered, size: 20),
            SizedBox(width: 8),
            Text(
              'Instructions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(
          recipe.instructions.length,
              (index) => buildInstructionStep(
            index + 1,
            recipe.instructions[index],
            context,
          ),
        ),
      ],
    ),
  );
}
