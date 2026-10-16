import 'package:dio/dio.dart';

import '../../../data/endpoints.dart';
import 'model/movie.dart';
import 'movie_repository_interface.dart';

class MovieRepository implements MovieRepositoryInterface {
  MovieRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Movie>> getMovies() async {
    final response = await dio.get<Map<String, dynamic>>(Endpoints.movies);
    final data = response.data?['data'];
    if (data is! List) {
      throw const FormatException('Сервер вернул некорректный список фильмов.');
    }
    return data
        .map((item) => Movie.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }
}
