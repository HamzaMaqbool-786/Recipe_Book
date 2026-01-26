import 'package:recipe_book/utils/constants/images.dart';

import 'models/recipe.dart';

class SampleData{

  static final List<Recipe> sampleRecipes = [
    Recipe(
      id: '1',
      name: 'Spaghetti Carbonara',
      description: 'Classic Italian pasta with eggs, cheese, pancetta, and pepper.',
      category: 'Italian',
      cookingTime: 25,
      difficulty: 'Easy',
      servings: 2,
      ingredients: [
        '200g Spaghetti',
        '100g Pancetta',
        '2 Eggs',
        '50g Parmesan Cheese',
        'Black Pepper'
      ],
      instructions: [
        'Boil the spaghetti in salted water.',
        'Fry the pancetta until crispy.',
        'Mix eggs and parmesan in a bowl.',
        'Combine spaghetti, pancetta, and egg mixture.',
        'Serve immediately with black pepper.'
      ],
      imagePath:RImages.spaghettiCarbonara,
      isFavorite: false,
      rating: 4.5,
      spiceLevel: 'Mild',
    ),
    Recipe(
      id: '2',
      name: 'Chicken Tikka Masala',
      description:
      'Marinated chicken cooked in creamy tomato sauce with spices.',
      category: 'Pakistani',
      cookingTime: 45,
      difficulty: 'Medium',
      servings: 4,
      ingredients: [
        '500g Chicken',
        '150g Yogurt',
        '2 tbsp Tikka Masala Paste',
        '1 Onion',
        '200ml Cream',
        'Spices'
      ],
      instructions: [
        'Marinate chicken in yogurt and tikka paste.',
        'Fry onions until golden.',
        'Add marinated chicken and cook thoroughly.',
        'Add cream and simmer for 10 minutes.',
        'Serve with rice or naan.'
      ],
      imagePath:
      RImages.chickenTikkaMasala,
      isFavorite: true,
      rating: 5.0,
      spiceLevel: 'Medium',
    ),
    Recipe(
      id: '3',
      name: 'Layers Chocolate Cake',
      description: 'Rich and moist chocolate cake with ganache frosting.',
      category: 'Dessert',
      cookingTime: 60,
      difficulty: 'Hard',
      servings: 8,
      ingredients: [
        '200g Flour',
        '200g Sugar',
        '100g Cocoa Powder',
        '3 Eggs',
        '200g Butter',
        '100ml Milk'
      ],
      instructions: [
        'Preheat oven to 180°C.',
        'Mix dry ingredients in a bowl.',
        'Add eggs, butter, and milk and mix well.',
        'Pour into baking pan and bake for 40-45 minutes.',
        'Cool and frost with chocolate ganache.'
      ],
      imagePath:
      RImages.layersCake,
      isFavorite: false,
      rating: 4.8,
      spiceLevel: 'Mild',
    ),
  ];

}