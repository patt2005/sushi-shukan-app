import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/models/onboarding_info.dart';
import 'package:sushi_shukan_app/screens/navigation_screen.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _carouselController = PageController();

  Widget _buildImage(String assetPath) {
    return Image.asset(
      assetPath,
      width: size.height * 0.22,
      height: size.height * 0.22,
    );
  }

  Widget _buildPageTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 35,
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    );
  }

  Widget _buildIndicators(int total, int current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: index == current ? 50 : 17,
          height: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.5),
            color: index == current ? kSecondaryColor : kPrimaryColor,
          ),
        );
      }),
    );
  }

  Widget _buildOnboardingContent(OnboardingInfo info, int pageIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          _buildImage(info.imageAssetPath),
          SizedBox(height: size.height * 0.05),
          _buildPageTitle(info.title),
          SizedBox(height: size.height * 0.01),
          _buildDescription(info.description),
          SizedBox(height: size.height * 0.07),
          _buildIndicators(onboardingInfoList.length, pageIndex),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: kPrimaryColor,
            ),
            onPressed: () async {
              if (pageIndex == onboardingInfoList.length - 1) {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const NavigationPage(),
                  ),
                );
                return;
              }
              await _carouselController.nextPage(
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
          SizedBox(height: size.height * 0.04),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingInfo info, int pageIndex) {
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: _buildOnboardingContent(info, pageIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: PageView.builder(
        controller: _carouselController,
        itemCount: onboardingInfoList.length,
        itemBuilder: (context, index) {
          return _buildOnboardingPage(onboardingInfoList[index], index);
        },
      ),
    );
  }
}
