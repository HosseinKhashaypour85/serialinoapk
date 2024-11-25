import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavMovie extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String releaseYear;

  FavMovie({required this.title, required this.imagePath, required this.releaseYear});
}
