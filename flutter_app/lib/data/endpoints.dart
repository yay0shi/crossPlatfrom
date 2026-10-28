class Endpoints {
  Endpoints._();

  static const movies = '/api/movies';
  static String movieById(int id) => '$movies/$id';
}
