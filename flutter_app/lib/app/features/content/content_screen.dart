import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../widgets/widgets.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({required this.contentId, super.key});

  final int contentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Подробности')),
      body: AdaptivePageBody(
        maxWidth: 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/test_image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            20.ph,
            Text(
              'Заголовок $contentId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            12.ph,
            Text(
              'Подробная информация об элементе $contentId. '
              'На этой странице показаны изображение, заголовок и описание '
              'выбранного элемента.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
