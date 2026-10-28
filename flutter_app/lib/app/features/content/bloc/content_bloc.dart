import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

import '../../../../domain/repositories/movies/model/movie.dart';
import '../../../../domain/repositories/movies/movie_repository_interface.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc({required this.movieRepository, required this.talker})
    : super(const ContentInitial()) {
    on<ContentLoad>(_loadMovie);
  }

  final MovieRepositoryInterface movieRepository;
  final Talker talker;

  Future<void> _loadMovie(ContentLoad event, Emitter<ContentState> emit) async {
    emit(const ContentLoadInProgress());
    try {
      final movie = await movieRepository.getMovieById(event.contentId);
      emit(ContentLoadSuccess(movie: movie));
    } catch (exception, stackTrace) {
      talker.handle(exception, stackTrace);
      emit(ContentLoadFailure(exception: exception));
    }
  }
}
