import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/models/cook_recipe.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class CookRecipeInfoScreen extends StatelessWidget {
  final CookRecipe cookRecipeInfo;

  const CookRecipeInfoScreen({
    super.key,
    required this.cookRecipeInfo,
  });

  Widget _buildIngredientInfo(String value) {
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
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
      ],
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
              SizedBox(height: screenSize.height * 0.08),
              Row(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
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
                      SizedBox(width: screenSize.width * 0.14),
                      Text(
                        "Cook recipe",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 34,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.03),
              const Text(
                "Ingredients",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Color(0xFF114960),
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Column(
                children: [
                  for (var data in cookRecipeInfo.ingredients)
                    _buildIngredientInfo(data),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              const Text(
                "Preparation",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Color(0xFF114960),
                ),
              ),
              Text(
                cookRecipeInfo.preparationText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
