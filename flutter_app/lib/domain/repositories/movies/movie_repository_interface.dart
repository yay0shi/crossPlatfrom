import 'model/movie.dart';

abstract interface class MovieRepositoryInterface {
  Future<List<Movie>> getMovies();
}
