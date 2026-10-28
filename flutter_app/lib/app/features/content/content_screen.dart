import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/dio/set_up.dart';
import '../../../di/di.dart';
import '../../../domain/repositories/movies/model/movie.dart';
import '../../widgets/widgets.dart';
import 'bloc/content_bloc.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({required this.contentId, super.key});

  final int contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(contentId),
      create: (_) =>
          getIt<ContentBloc>()..add(ContentLoad(contentId: contentId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Подробности фильма')),
        body: BlocBuilder<ContentBloc, ContentState>(
          builder: (context, state) => switch (state) {
            ContentInitial() => const SizedBox.shrink(),
            ContentLoadInProgress() => const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Загрузка фильма',
              ),
            ),
            ContentLoadSuccess() => _MovieDetails(movie: state.movie),
            ContentLoadFailure() => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    FilledButton(
                      onPressed: () => context.read<ContentBloc>().add(
                        ContentLoad(contentId: contentId),
                      ),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            ),
          },
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  const _MovieDetails({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return AdaptivePageBody(
      maxWidth: 960,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                resolvePosterUrl(movie.posterUrl),
                width: 280,
                height: 360,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox(
                  width: 280,
                  height: 360,
                  child: Center(
                    child: Icon(Icons.broken_image_outlined, size: 48),
                  ),
                ),
              ),
            ),
          ),
          Text(movie.title, style: Theme.of(context).textTheme.headlineLarge),
          Text(
            movie.originalTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(movie.description, style: Theme.of(context).textTheme.bodyLarge),
          Text('Год выпуска: ${movie.releaseYear}'),
          Text('Жанры: ${movie.genres.join(', ')}'),
          Text('Режиссёр: ${movie.director}'),
          Text('Актёры: ${movie.actors.join(', ')}'),
          Text('Длительность: ${movie.durationMinutes} мин'),
          Text('Страна: ${movie.country}'),
          Text('Возрастное ограничение: ${movie.ageRating}'),
          if (movie.rating != null) Text('Рейтинг: ${movie.rating}'),
        ],
      ),
    );
  }
}
