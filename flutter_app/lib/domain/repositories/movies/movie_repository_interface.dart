import 'model/movie.dart';

abstract interface class MovieRepositoryInterface {
  Future<List<Movie>> getMovies();
  Future<Movie> getMovieById(int id);
}
