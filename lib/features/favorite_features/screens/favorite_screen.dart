import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../search_features/model/search_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  static const String screenId = 'favorite_screen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Box<Movie> movieTitleBox;
  bool _isLoading = true;
  List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    try {
      movieTitleBox = await Hive.openBox<Movie>('FavMovieName');
      _loadFavoriteMovies();
    } catch (e) {
      print("Error opening Hive box: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadFavoriteMovies() {
    setState(() {
      _favoriteMovies = movieTitleBox.values.toList();
    });
  }

  void _toggleFavorite(Movie movie) async {
    final movieKey = movieTitleBox.keys.firstWhere(
          (key) => movieTitleBox.get(key)!.title == movie.title,
      orElse: () => null,
    );

    setState(() {
      if (movieKey != null) {
        movieTitleBox.delete(movieKey);
        _favoriteMovies.removeWhere((m) => m.title == movie.title);
      } else {
        movieTitleBox.add(movie);
        _favoriteMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فیلم‌های مورد علاقه", style: TextStyle(fontFamily: 'vazir')),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _favoriteMovies.isEmpty
            ? Center(child: Text("هیچ فیلمی به علاقه‌مندی‌ها افزوده نشده است"))
            : ListView.builder(
          itemCount: _favoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = _favoriteMovies[index];

            return ListTile(
              leading: movie.imagePath.isNotEmpty
                  ? Image.network(movie.imagePath, fit: BoxFit.cover)
                  : Icon(Icons.movie),
              title: Text(movie.title),
              subtitle: Text(movie.releaseYear),
              trailing: IconButton(
                onPressed: () {
                  _toggleFavorite(movie);
                },
                icon: Icon(
                  Icons.favorite,
                  color: _favoriteMovies.any((m) => m.title == movie.title)
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    movieTitleBox.close();
    super.dispose();
  }
}
