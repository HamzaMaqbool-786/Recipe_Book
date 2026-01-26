import 'package:flutter/material.dart';

class HelperFunction{

  static Color getSpiceColor(String spiceLevel) {
    switch (spiceLevel.toLowerCase()) {
      case 'spicy':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  static   Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'italian':
        return Colors.green;
      case 'indian':
        return Colors.orange;
      case 'mexican':
        return Colors.red;
      case 'asian':
        return Colors.purple;
      case 'dessert':
        return Colors.pink;
      case 'salad':
        return Colors.lightGreen;
      default:
        return Colors.blue;
    }
  }


static void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

}