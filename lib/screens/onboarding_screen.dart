import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/models/onboarding_info.dart';
import 'package:sushi_shukan_app/screens/home_screen.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  Widget _buildOnboardingPage(OnboardingInfo info, int index) {
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.1),
              Image.asset(
                info.imageAssetPath,
                width: screenSize.height * 0.22,
                height: screenSize.height * 0.22,
              ),
              SizedBox(height: screenSize.height * 0.05),
              Text(
                info.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Text(
                info.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: screenSize.height * 0.07),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: i == index ? 50 : 17,
                      height: 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(8.5),
                        color: i == index ? kSecondaryColor : kPrimaryColor,
                      ),
                    )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 13),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                ),
                onPressed: () async {
                  if (index == onboardingInfoList.length - 1) {
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    return;
                  }
                  await _pageController.nextPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      info.buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: PageView(
        controller: _pageController,
        children: [
          for (int i = 0; i < onboardingInfoList.length; i++)
            _buildOnboardingPage(onboardingInfoList[i], i),
        ],
      ),
    );
  }
}
