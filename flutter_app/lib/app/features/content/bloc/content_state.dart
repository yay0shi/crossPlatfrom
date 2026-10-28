part of 'content_bloc.dart';

sealed class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object?> get props => [];
}

final class ContentInitial extends ContentState {
  const ContentInitial();
}

final class ContentLoadInProgress extends ContentState {
  const ContentLoadInProgress();
}

final class ContentLoadSuccess extends ContentState {
  const ContentLoadSuccess({required this.movie});

  final Movie movie;

  @override
  List<Object?> get props => [movie];
}

final class ContentLoadFailure extends ContentState {
  const ContentLoadFailure({required this.exception});

  final Object exception;

  String get message {
    if (exception is DioException) {
      final error = exception as DioException;
      if (error.response?.statusCode == 404) return 'Фильм не найден.';
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
    return 'Не удалось прочитать данные фильма. Повторите попытку.';
  }

  @override
  List<Object?> get props => [exception];
}
