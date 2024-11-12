class OnboardingInfo {
  final String imageAssetPath;
  final String title;
  final String buttonText;
  final String description;

  OnboardingInfo({
    required this.imageAssetPath,
    required this.title,
    required this.buttonText,
    required this.description,
  });
}

List<OnboardingInfo> onboardingInfoList = [
  OnboardingInfo(
    imageAssetPath: "assets/images/image1.png",
    title: "Master Sushi at Home",
    buttonText: "Next",
    description:
        "Learn to create delicious sushi dishes right in your own kitchen with our easy-to-follow recipes.",
  ),
  OnboardingInfo(
    imageAssetPath: "assets/images/image2.png",
    title: "Healthy and Nutritious",
    buttonText: "Next",
    description:
        "Our recipes are packed with essential nutrients and low in calories, making sushi a delicious and healthy choice.",
  ),
  OnboardingInfo(
    imageAssetPath: "assets/images/image3.png",
    title: "Step-by-Step Guidance",
    buttonText: "Get Started",
    description:
        "Our detailed instructions and clear visuals will guide you through every step of the sushi-making process.",
  ),
];
