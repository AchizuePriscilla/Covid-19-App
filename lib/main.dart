import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scamp_assesment/views/home.dart';

import 'utils/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19 App',
        debugShowCheckedModeBanner: false,
      theme: themeData(context),
      home: MyAppState(),
    );
  }
}
