import 'package:hive/hive.dart';


part 'recipe.g.dart';



@HiveType(typeId: 1) // Unique typeId for enum
enum ImageType {
  @HiveField(0)
  network,
  @HiveField(1)
  asset,
  @HiveField(2)
  file,
  @HiveField(3)
  none,
}
@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  int cookingTime;

  @HiveField(5)
  String difficulty;

  @HiveField(6)
  int servings;

  @HiveField(7)
  List<String> ingredients;

  @HiveField(8)
  List<String> instructions;

  @HiveField(9)
  String? imagePath;

  @HiveField(10)
  bool isFavorite;

  @HiveField(11)
  double rating;

  @HiveField(12)
  String spiceLevel;

  @HiveField(13)
  ImageType imageType;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.cookingTime,
    required this.difficulty,
    required this.servings,
    required this.ingredients,
    required this.instructions,
    this.imagePath,
    this.imageType = ImageType.network,
    this.isFavorite = false,
    this.rating = 0.0,
    this.spiceLevel = 'Mild',
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'cookingTime': cookingTime,
      'difficulty': difficulty,
      'servings': servings,
      'ingredients': ingredients,
      'instructions': instructions,
      'imagePath': imagePath,
      'isFavorite': isFavorite,
      'rating': rating,
      'spiceLevel': spiceLevel,
      'imageType': imageType.index, // store enum as int
    };
  }

  // Create from Map
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      cookingTime: map['cookingTime'],
      difficulty: map['difficulty'],
      servings: map['servings'],
      ingredients: List<String>.from(map['ingredients']),
      instructions: List<String>.from(map['instructions']),
      imagePath: map['imagePath'],
      isFavorite: map['isFavorite'] ?? false,
      rating: map['rating']?.toDouble() ?? 0.0,
      spiceLevel: map['spiceLevel'] ?? 'Mild',
      imageType: map['imageType'] != null
          ? ImageType.values[map['imageType']] // convert int back to enum
          : ImageType.network,
    );
  }
}




