import 'package:flutter/material.dart';
import 'package:multigame/src/app/main_navigation.dart';
import 'package:multigame/src/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MainNavigation(),
    );
  }
}
