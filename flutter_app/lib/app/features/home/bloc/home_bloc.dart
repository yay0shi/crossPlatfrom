import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

import '../../../../domain/repositories/movies/model/movie.dart';
import '../../../../domain/repositories/movies/movie_repository_interface.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.movieRepository, required this.talker})
    : super(const HomeInitial()) {
    on<HomeLoad>(_loadMovies);
  }

  final MovieRepositoryInterface movieRepository;
  final Talker talker;

  Future<void> _loadMovies(HomeLoad event, Emitter<HomeState> emit) async {
    emit(const HomeLoadInProgress());
    try {
      final movies = await movieRepository.getMovies();
      emit(HomeLoadSuccess(movies: movies));
    } catch (exception, stackTrace) {
      talker.handle(exception, stackTrace);
      emit(HomeLoadFailure(exception: exception));
    }
  }
}
