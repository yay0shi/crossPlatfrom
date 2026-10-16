import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../extensions/extensions.dart';
import '../../widgets/widgets.dart';
import 'bloc/home_bloc.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _home;

  @override
  void initState() {
    super.initState();
    _home = getIt<HomeBloc>()..add(const HomeLoad());
  }

  @override
  void dispose() {
    _home.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _home,
        builder: (context, state) => switch (state) {
          HomeInitial() => const SizedBox.shrink(),
          HomeLoadInProgress() => const Center(
            child: CircularProgressIndicator(
              semanticsLabel: 'Загрузка фильмов',
            ),
          ),
          HomeLoadSuccess() => _buildMovies(state),
          HomeLoadFailure() => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  Text(state.message, textAlign: TextAlign.center),
                  FilledButton(
                    onPressed: () => _home.add(const HomeLoad()),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            ),
          ),
        },
      ),
    );
  }

  Widget _buildMovies(HomeLoadSuccess state) {
    return AdaptivePageBody(
      maxWidth: 960,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Список фильмов',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          if (state.movies.isEmpty)
            const Text('Фильмы не найдены')
          else
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: state.movies.length,
              itemBuilder: (_, index) =>
                  ContentCard(movie: state.movies[index]),
              separatorBuilder: (_, _) => 16.ph,
            ),
        ],
      ),
    );
  }
}
