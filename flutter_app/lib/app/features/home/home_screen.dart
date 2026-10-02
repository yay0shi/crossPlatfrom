import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
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
      appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Header', style: Theme.of(context).textTheme.headlineLarge),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, _) => ContentCard(),
              separatorBuilder: (_, _) => 16.ph,
            ),
          ],
        ),
      ),
    );
  }
}
