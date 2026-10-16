import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/dio/set_up.dart';
import '../../../../domain/repositories/movies/model/movie.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final imageSize = 100.0;

    return InkWell(
      onTap: () => context.push('/content/${movie.id}'),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                resolvePosterUrl(movie.posterUrl),
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: Text(
                      '${movie.releaseYear} · ${movie.genres.join(', ')}\n'
                      '${movie.description}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
