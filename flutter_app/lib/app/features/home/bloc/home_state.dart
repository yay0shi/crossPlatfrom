part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

final class HomeLoadSuccess extends HomeState {
  HomeLoadSuccess({required List<Movie> movies})
    : movies = List.unmodifiable(movies);

  final List<Movie> movies;

  @override
  List<Object?> get props => [movies];
}

final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({required this.exception});

  final Object exception;

  String get message {
    if (exception is DioException) {
      final error = exception as DioException;
      return switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.sendTimeout =>
          'Сервер не ответил вовремя. Повторите попытку.',
        DioExceptionType.badResponse =>
          'Сервер вернул ошибку. Повторите попытку.',
        _ => 'Не удалось подключиться к серверу. Проверьте соединение и повторите попытку.',
      };
    }
    return 'Не удалось прочитать данные фильмов. Повторите попытку.';
  }

  @override
  List<Object?> get props => [exception];
}
