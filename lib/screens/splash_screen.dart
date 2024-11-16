import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_shukan_app/screens/info_screen.dart';
import 'package:sushi_shukan_app/screens/onboarding_screen.dart';
import 'package:sushi_shukan_app/utilities/app_provider.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _initialize();
      },
    );
  }

  void _initialize() async {
    String? url;
    final provider = Provider.of<AppStateManager>(context, listen: false);
    if (await provider.isFirstOpen()) {
      url = await provider.onFirstAppOpen();
    } else {
      url = await provider.initApp();
    }

    if (url != null) {
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          await Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => InfoScreen(
                url: url!,
                showAppBar: false,
              ),
            ),
          );
        },
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          await Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
