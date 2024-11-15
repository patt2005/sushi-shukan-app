import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/models/cook_recipe.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class CookRecipeInfoScreen extends StatelessWidget {
  final CookRecipeInfo recipeDetails;
  final String title;
  final String imageAssetPath;

  const CookRecipeInfoScreen({
    super.key,
    required this.recipeDetails,
    required this.title,
    required this.imageAssetPath,
  });

  Widget _createIngredientRow(String ingredient) {
    return Row(
      children: [
        const Text(
          "•",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            ingredient,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Cook recipe",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.055),
          ],
        ),
        Positioned(
          left: 0,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: "sushiImage-$title",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imageAssetPath,
          width: size.width,
          height: size.height * 0.25,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 30,
        color: Color(0xFF114960),
      ),
    );
  }

  Widget _buildIngredientsList() {
    return Column(
      children: recipeDetails.ingredients
          .map((ingredient) => _createIngredientRow(ingredient))
          .toList(),
    );
  }

  Widget _buildPreparationText() {
    return Text(
      recipeDetails.preparationText,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.08),
              _buildHeader(context),
              SizedBox(height: size.height * 0.03),
              _buildHeroImage(), // Use Hero widget for the image
              SizedBox(height: size.height * 0.03),
              _buildSectionTitle("Ingredients"),
              SizedBox(height: size.height * 0.01),
              _buildIngredientsList(),
              SizedBox(height: size.height * 0.02),
              _buildSectionTitle("Preparation"),
              _buildPreparationText(),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
