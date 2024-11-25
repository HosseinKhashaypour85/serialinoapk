import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/search_model.dart';

Future<List<Movie>> fetchMovies(String query) async {
  const String apiKey = 'b86016ec';
  final String url = 'https://www.omdbapi.com/?s=$query&apikey=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['Response'] == 'True') {
      final moviesJson = data['Search'] as List;
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception(data['Error']);
    }
  } else {
    throw Exception('Failed to load movies');
  }
}
