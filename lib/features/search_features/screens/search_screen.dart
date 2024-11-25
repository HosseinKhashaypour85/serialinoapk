import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/search_model.dart';
import '../services/search_api_services.dart';

class SearchScreen extends StatefulWidget {
  static const String screenId = '/search_screen';

  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;
  late Box<Movie> _favoritesBox;
  List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    _favoritesBox = await Hive.openBox<Movie>('favorites');
    _loadFavoriteMovies();
  }

  void _loadFavoriteMovies() {
    setState(() {
      _favoriteMovies = _favoritesBox.values.toList();
    });
  }

  void _searchMovies() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final movies = await fetchMovies(query);
        setState(() {
          _movies = movies;
        });
      } catch (error) {
        setState(() {
          _errorMessage = error.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleFavorite(Movie movie) async {
    final isFavorite = _favoriteMovies.any((m) => m.title == movie.title);

    if (isFavorite) {
      final movieKey = _favoritesBox.keys.firstWhere((key) =>
      _favoritesBox.get(key)!.title == movie.title);
      await _favoritesBox.delete(movieKey);
      setState(() {
        _favoriteMovies.removeWhere((m) => m.title == movie.title);
      });
    } else {
      await _favoritesBox.add(movie);
      setState(() {
        _favoriteMovies.add(movie);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'جستجو...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchMovies,
                  ),
                ),
              ),
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      _errorMessage!, style: TextStyle(color: Colors.red)),
                )
              else
                if (_movies.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        final movie = _movies[index];
                        final isFavorite = _favoriteMovies.any((m) =>
                        m.title == movie.title);
                        return MoviesListTileWidget(
                          movie: movie,
                          isFavorite: isFavorite,
                          onFavoriteToggle: () => _toggleFavorite(movie),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: Center(child: Text('فیلمی پیدا نشد.')),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _favoritesBox.close();
    super.dispose();
  }
}

class MoviesListTileWidget extends StatefulWidget {
  const MoviesListTileWidget({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  final Movie movie;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  @override
  _MoviesListTileWidgetState createState() => _MoviesListTileWidgetState();
}

class _MoviesListTileWidgetState extends State<MoviesListTileWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onFavoriteToggle();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.movie.imagePath.isNotEmpty
          ? Image.network(widget.movie.imagePath, fit: BoxFit.cover)
          : const Icon(Icons.movie),
      title: Text(widget.movie.title),
      subtitle: Text(widget.movie.releaseYear),
    );
  }
}
