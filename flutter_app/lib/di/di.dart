import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/features/home/bloc/home_bloc.dart';
import '../data/dio/set_up.dart';
import '../domain/repositories/movies/movie_repository.dart';
import '../domain/repositories/movies/movie_repository_interface.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  getIt.registerSingleton(talker);
  final dio = Dio();
  setUpDio(dio, talker);
  getIt.registerSingleton<Dio>(dio, dispose: (client) => client.close());
  getIt.registerSingleton<MovieRepositoryInterface>(MovieRepository(dio: dio));
  Bloc.observer = TalkerBlocObserver(talker: talker);
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      movieRepository: getIt<MovieRepositoryInterface>(),
      talker: talker,
    ),
  );
}
