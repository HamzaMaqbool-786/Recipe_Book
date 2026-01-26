// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      cookingTime: fields[4] as int,
      difficulty: fields[5] as String,
      servings: fields[6] as int,
      ingredients: (fields[7] as List).cast<String>(),
      instructions: (fields[8] as List).cast<String>(),
      imagePath: fields[9] as String?,
      imageType: fields[13] as ImageType,
      isFavorite: fields[10] as bool,
      rating: fields[11] as double,
      spiceLevel: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.cookingTime)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.servings)
      ..writeByte(7)
      ..write(obj.ingredients)
      ..writeByte(8)
      ..write(obj.instructions)
      ..writeByte(9)
      ..write(obj.imagePath)
      ..writeByte(10)
      ..write(obj.isFavorite)
      ..writeByte(11)
      ..write(obj.rating)
      ..writeByte(12)
      ..write(obj.spiceLevel)
      ..writeByte(13)
      ..write(obj.imageType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImageTypeAdapter extends TypeAdapter<ImageType> {
  @override
  final int typeId = 1;

  @override
  ImageType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ImageType.network;
      case 1:
        return ImageType.asset;
      case 2:
        return ImageType.file;
      case 3:
        return ImageType.none;
      default:
        return ImageType.network;
    }
  }

  @override
  void write(BinaryWriter writer, ImageType obj) {
    switch (obj) {
      case ImageType.network:
        writer.writeByte(0);
        break;
      case ImageType.asset:
        writer.writeByte(1);
        break;
      case ImageType.file:
        writer.writeByte(2);
        break;
      case ImageType.none:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
