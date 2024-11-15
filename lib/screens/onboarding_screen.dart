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

  bool _isIpad(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = size.width / size.height;
    return size.width >= 768 && aspectRatio < 1.6;
  }

  Widget _buildImage(String assetPath, BuildContext context) {
    final isIpad = _isIpad(context);
    return Image.asset(
      assetPath,
      width: size.height * (isIpad ? 0.3 : 0.22),
      height: size.height * (isIpad ? 0.3 : 0.22),
    );
  }

  Widget _buildPageTitle(String title, BuildContext context) {
    final isIpad = _isIpad(context);
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kTextColor,
        fontWeight: FontWeight.w400,
        fontSize: isIpad ? 45 : 35,
      ),
    );
  }

  Widget _buildDescription(String description, BuildContext context) {
    final isIpad = _isIpad(context);
    return Text(
      description,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: isIpad ? 24 : 20,
      ),
    );
  }

  Widget _buildIndicators(int total, int current, BuildContext context) {
    final isIpad = _isIpad(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: index == current ? (isIpad ? 60 : 50) : (isIpad ? 25 : 17),
          height: isIpad ? 20 : 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isIpad ? 10 : 8.5),
            color: index == current ? kSecondaryColor : kPrimaryColor,
          ),
        );
      }),
    );
  }

  Widget _buildOnboardingContent(
      OnboardingInfo info, int pageIndex, BuildContext context) {
    final isIpad = _isIpad(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isIpad ? 40 : 20),
      child: Column(
        children: [
          SizedBox(height: size.height * (isIpad ? 0.07 : 0.1)),
          _buildImage(info.imageAssetPath, context),
          SizedBox(height: size.height * (isIpad ? 0.07 : 0.05)),
          _buildPageTitle(info.title, context),
          SizedBox(height: size.height * (isIpad ? 0.02 : 0.01)),
          _buildDescription(info.description, context),
          SizedBox(height: size.height * (isIpad ? 0.1 : 0.07)),
          _buildIndicators(onboardingInfoList.length, pageIndex, context),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: isIpad ? 18 : 13),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isIpad ? 24 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * (isIpad ? 0.06 : 0.04)),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
      OnboardingInfo info, int pageIndex, BuildContext context) {
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: _buildOnboardingContent(info, pageIndex, context),
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
          return _buildOnboardingPage(
              onboardingInfoList[index], index, context);
        },
      ),
    );
  }
}
