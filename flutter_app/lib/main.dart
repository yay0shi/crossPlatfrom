import 'package:flutter/material.dart';

import 'di/di.dart';
import 'flutter_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };

  runApp(const FlutterApp());
}
