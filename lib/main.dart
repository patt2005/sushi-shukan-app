import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_shukan_app/screens/onboarding_screen.dart';
import 'package:sushi_shukan_app/utilities/app_provider.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Harmattan"),
      home: const OnboardingScreen(),
    );
  }
}
