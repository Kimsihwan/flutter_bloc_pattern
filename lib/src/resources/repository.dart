import 'package:flutter_bloc_pattern/src/models/item_model.dart';
import 'package:flutter_bloc_pattern/src/resources/movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fechAllMovies() => moviesApiProvider.fetchMovieList();
}
