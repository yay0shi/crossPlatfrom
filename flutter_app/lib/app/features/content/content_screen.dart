import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({required this.contentId, super.key});

  final int contentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/test_image.jpg',
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            20.ph,
            Text(
              'Title $contentId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            12.ph,
            Text(
              'Детальная информация для записи $contentId. '
              'Страница отображает картинку, заголовок, описание '
              'выбранной записи.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
