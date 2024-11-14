import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/models/sushi_item.dart';
import 'package:sushi_shukan_app/screens/cook_recipe_info_screen.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class SushiInfoScreen extends StatefulWidget {
  final SushiItem sushiItemInfo;

  const SushiInfoScreen({
    super.key,
    required this.sushiItemInfo,
  });

  @override
  State<SushiInfoScreen> createState() => _SushiInfoScreenState();
}

class _SushiInfoScreenState extends State<SushiInfoScreen> {
  Widget _buildNutritionRow(String title, String value) {
    return Row(
      children: [
        const Text(
          "•",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  endIndent: 10,
                ),
              ),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
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
            children: [
              SizedBox(height: screenSize.height * 0.08),
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
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.sushiItemInfo.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 34,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.sushiItemInfo.imageAssetPath,
                    width: screenSize.width,
                    height: screenSize.height * 0.22,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 31,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.clock,
                          color: kPrimaryColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "${widget.sushiItemInfo.cookingTime} minutes",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                widget.sushiItemInfo.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color(0xFF114960),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nutrition Info (4 servings)",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _buildNutritionRow("Calories",
                            "${widget.sushiItemInfo.nutritionInfo.calories}g"),
                        _buildNutritionRow("Fat",
                            "${widget.sushiItemInfo.nutritionInfo.fat}g"),
                        _buildNutritionRow("Carbs",
                            "${widget.sushiItemInfo.nutritionInfo.carbs}g"),
                        _buildNutritionRow("Fiber",
                            "${widget.sushiItemInfo.nutritionInfo.fiber}g"),
                        _buildNutritionRow("Sugar",
                            "${widget.sushiItemInfo.nutritionInfo.sugar}g"),
                        _buildNutritionRow("Protein",
                            "${widget.sushiItemInfo.nutritionInfo.protein}g"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kSecondaryColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => CookRecipeInfoScreen(
                        cookRecipeInfo: widget.sushiItemInfo.cookRecipe,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cook recipe",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
