import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/models/sushi_item.dart';
import 'package:sushi_shukan_app/screens/cook_recipe_info_screen.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class SushiInfoScreen extends StatefulWidget {
  final SushiItemInfo sushiItemInfo;

  const SushiInfoScreen({
    super.key,
    required this.sushiItemInfo,
  });

  @override
  State<SushiInfoScreen> createState() => _SushiInfoScreenState();
}

class _SushiInfoScreenState extends State<SushiInfoScreen> {
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.055),
            Text(
              widget.sushiItemInfo.title,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
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
      tag: "sushiImage-${widget.sushiItemInfo.title}",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          widget.sushiItemInfo.imageAssetPath,
          width: size.width,
          height: size.height * 0.25,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

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

  Widget _buildNutritionInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            "Nutrition Info (4 servings)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildNutritionRow("Calories",
                  "${widget.sushiItemInfo.nutritionInfo.calories}g"),
              _buildNutritionRow(
                  "Fat", "${widget.sushiItemInfo.nutritionInfo.fat}g"),
              _buildNutritionRow(
                  "Carbs", "${widget.sushiItemInfo.nutritionInfo.carbs}g"),
              _buildNutritionRow(
                  "Fiber", "${widget.sushiItemInfo.nutritionInfo.fiber}g"),
              _buildNutritionRow(
                  "Sugar", "${widget.sushiItemInfo.nutritionInfo.sugar}g"),
              _buildNutritionRow(
                  "Protein", "${widget.sushiItemInfo.nutritionInfo.protein}g"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCookRecipeButton() {
    return ElevatedButton(
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
              recipeDetails: widget.sushiItemInfo.cookRecipe,
              imageAssetPath: widget.sushiItemInfo.imageAssetPath,
              title: widget.sushiItemInfo.title,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.08),
            _buildHeader(context),
            SizedBox(height: size.height * 0.03),
            _buildHeroImage(),
            SizedBox(height: size.height * 0.03),
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
            SizedBox(height: size.height * 0.02),
            Text(
              widget.sushiItemInfo.description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color(0xFF114960),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _buildNutritionInfo(),
            SizedBox(height: size.height * 0.03),
            _buildCookRecipeButton(),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
