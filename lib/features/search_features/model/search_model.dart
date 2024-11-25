
class Movie {
  final String title;
  final String releaseYear;
  final String imagePath;

  Movie({
    required this.title,
    required this.releaseYear,
    required this.imagePath,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      title: json['Title'],
      releaseYear: json['Year'],
      imagePath: json['Poster'],
    );
  }

}
