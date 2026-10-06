import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: AdaptivePageBody(
        maxWidth: 960,
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Список элементов',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, index) => ContentCard(contentId: index + 1),
              separatorBuilder: (_, _) => 16.ph,
            ),
          ],
        ),
      ),
    );
  }
}
