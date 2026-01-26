import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChoiceChipSelector extends StatelessWidget {
  final String title;
  final List<String> items;
  final RxString selectedItem;
  final Function(String) onChanged;

  const ChoiceChipSelector({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Obx(
              () => Wrap(
            spacing: 8,
            children: items.map((item) {
              final isSelected = selectedItem.value == item;
              return ChoiceChip(
                label: Text(item),
                selected: isSelected,
                onSelected: (selected) => onChanged(item),
                selectedColor: Get.theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
