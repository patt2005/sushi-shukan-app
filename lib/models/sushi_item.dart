import 'package:sushi_shukan_app/models/cook_recipe.dart';
import 'package:sushi_shukan_app/models/nutrition_info.dart';

class SushiItemInfo {
  final String title;
  final String imageAssetPath;
  final String description;
  final NutritionInfo nutritionInfo;
  final int cookingTime;
  final CookRecipeInfo cookRecipe;
  final String category;

  SushiItemInfo({
    required this.category,
    required this.title,
    required this.imageAssetPath,
    required this.description,
    required this.nutritionInfo,
    required this.cookingTime,
    required this.cookRecipe,
  });
}

List<SushiItemInfo> sushiItemsList = [
  SushiItemInfo(
    category: "Maki",
    cookingTime: 15,
    title: "California Rolls",
    imageAssetPath: "assets/images/sushi1.png",
    description:
        """California rolls are a popular sushi roll that features a unique combination of ingredients:
Crabmeat: Typically imitation crab, which is made from surimi (fish paste) and is shaped into crab-like pieces.
Avocado: Sliced ​​avocado adds a creamy and buttery texture.
Cucumber: Thin strips of cucumber provide a refreshing crunch.
Nori: A sheet of dried seaweed that wraps the roll.
Sushi rice: Seasoned rice that forms the base of the roll.
The distinctive feature of California rolls is that the nori is on the inside, while the sushi rice is on the outside. This creates a visually appealing roll that is also easier to eat for those who are new to sushi.
California rolls are often topped with masago (orange fish roe) or sesame seeds and served with soy sauce and wasabi. They are a popular choice for those who prefer milder flavors and are often considered a good introduction to sushi.""",
    nutritionInfo: NutritionInfo(
      calories: 565,
      fat: 7,
      carbs: 94,
      fiber: 3,
      sugar: 67,
      protein: 16,
    ),
    cookRecipe: CookRecipeInfo(
      ingredients: [
        "2 cups sushi rice(460 g), cooked",
        "¼ cup seasoned rice vinegar(60 mL)",
        "4 half sheets sushi grade nori",
        "1 teaspoon sesame seed, optional",
        "8 pieces imitation crab",
        "1 small cucumber, cut into matchsticks",
        "1 avocado, thinly sliced",
      ],
      preparationText:
          """Season the sushi rice with the rice vinegar, fanning and stirring until room temperature.
On a rolling mat, place one sheet of nori with the rough side facing upwards.
Wet your hands and grab a handful of rice and place it on the nori. Spread the rice evenly throughout the nori without mashing the rice down. Season rice with a pinch of sesame seeds, if using, then flip it over so the nori is facing upwards.
Arrange, in a horizontal row 1 inch (2.5 cm) from the bottom, the crab followed by a row of avocado and a row of cucumber.
Grabbing both nori and the mat, roll the mat over the filling so the extra space at the bottom touches the other side, squeezing down to make a nice tight roll. Squeeze down along the way to keep the roll from holding its shape.
Transfer the roll onto a cutting board. Rub a knife on a damp paper towel before slicing the roll into six equal portions.""",
    ),
  ),
  SushiItemInfo(
    category: "Nigiri",
    cookingTime: 30,
    title: "Salmon Nigiri",
    imageAssetPath: "assets/images/sushi2.png",
    description: """Salmon Nigiri
A classic sushi dish, salmon nigiri showcases the delicate flavor of fresh salmon. The sushi consists of:
Fresh salmon: Sliced ​​salmon, typically fatty salmon for a richer flavor.
Shari: Seasoned sushi rice, molded into a small rectangular shape.
The salmon is placed on top of the shari, often with a small dollop of wasabi on top. Salmon nigiri is a popular choice for sushi lovers who appreciate the simple yet elegant presentation of this traditional dish. It is often enjoyed with soy sauce and ginger, which complement the rich flavor of the salmon.""",
    nutritionInfo: NutritionInfo(
      calories: 317,
      fat: 6,
      carbs: 44,
      fiber: 2,
      sugar: 3,
      protein: 20,
    ),
    cookRecipe: CookRecipeInfo(
      ingredients: [
        "2 cups sushi rice(460 g)",
        "¼ cup seasoned rice vinegar(60 mL)",
        "4 half sheets sushi grade nori",
        "4 oz smoked salmon(115 g)",
        "4 oz cream cheese(115 g), cut into matchsticks",
        "1 small cucumber, cut into matchsticks",
      ],
      preparationText:
          """Season the sushi rice with the rice vinegar, fanning and stirring until room temperature.
On the rolling mat place one sheet of nori with the rough side facing upwards.
Wet your hands and grab a handful of rice and place it on the nori. Spread the rice evenly throughout the nori without smushing the rice down.
Arrange, in a horizontal row 1 inch (2 cm) from the bottom, smoked salmon, cream cheese, and cucumber.
Grabbing both nori and the mat, roll the mat over the filling so the extra space at the bottom touches the other side, squeezing down to make a nice tight roll. Squeeze down along the way to keep the roll from holding its shape.
Transfer the roll onto a cutting board. Rub a knife on a damp paper towel before slicing the roll into six equal portions.""",
    ),
  ),
  SushiItemInfo(
    category: "Sashimi",
    cookingTime: 30,
    title: "Spicy Tuna Rolls",
    imageAssetPath: "assets/images/sushi3.png",
    description:
        """A vibrant and flavorful sushi roll, spicy tuna rolls offer a tantalizing blend of textures and tastes. The roll typically features:
Fresh tuna: Sliced ​​tuna provides a delicate and umami-rich flavor.
Spicy mayonnaise or sriracha: A fiery kick that adds a touch of heat.
Nori: A sheet of dried seaweed that wraps the roll.
Sushi rice: Seasoned rice that forms the base of the roll.
Sesame seeds and scallions: Optional additions that provide extra crunch and flavor.
Spicy tuna rolls are a popular choice for those who enjoy bold flavors and are looking for a more adventurous sushi experience. They are often served with soy sauce and wasabi, but can also be enjoyed on their own.""",
    nutritionInfo: NutritionInfo(
      calories: 410,
      fat: 6,
      carbs: 60,
      fiber: 0,
      sugar: 54,
      protein: 11,
    ),
    cookRecipe: CookRecipeInfo(
      ingredients: [
        "2 cups sushi rice(460 g), cooked",
        "¼ cup seasoned rice vinegar(60 mL)",
        "4 half sheets sushi grade nori",
        "1 can tuna, drained",
        "1 ½ tablespoons mayonnaise",
        "1 ½ teaspoons sriracha",
        "1 green onion, thinly sliced",
        "1 teaspoon sesame oil",
      ],
      preparationText:
          """Season the sushi rice with the rice vinegar, fanning and stirring until room temperature.
On the rolling mat place one sheet of nori with the rough side facing upwards.
In a small bowl, combine tuna filling ingredients. Set aside.
Wet your hands and grab a handful of rice and place it on the nori. Spread the rice evenly throughout the nori without smushing the rice down.
Arrange, in a horizontal row 1 inch (2.5 cm) from the bottom, a large spoonful of the tuna filling.
Grabbing both nori and the mat, roll the mat over the filling so the extra space at the bottom touches the other side, squeezing down to make a nice tight roll. Squeeze down along the way to keep the roll from holding its shape.
Transfer the roll onto a cutting board. Rub a knife on a damp paper towel before slicing the roll into six equal portions.""",
    ),
  ),
  SushiItemInfo(
    category: "Maki",
    cookingTime: 30,
    title: "Philadelphia Rolls",
    imageAssetPath: "assets/images/sushi4.png",
    description:
        """Philadelphia rolls are a popular sushi roll that features a unique combination of ingredients:
Smoked salmon: Sliced ​​smoked salmon adds a savory and smoky flavor.
Avocado: Sliced ​​avocado provides a creamy and buttery texture.
Cream cheese: Optional, but often added for a rich and tangy flavor.
Nori: A sheet of dried seaweed that wraps the roll.
Sushi rice: Seasoned rice that forms the base of the roll.
The distinctive feature of Philadelphia rolls is that the nori is on the outside, while the sushi rice is on the inside. This creates a visually appealing roll that is also easier to eat for those who are new to sushi.
Philadelphia rolls are often served with soy sauce and wasabi. They are a popular choice for those who prefer milder flavors and are often considered a good introduction to sushi.""",
    nutritionInfo: NutritionInfo(
      calories: 424,
      fat: 9,
      carbs: 62,
      fiber: 0,
      sugar: 55,
      protein: 7,
    ),
    cookRecipe: CookRecipeInfo(
      ingredients: [
        "¼ cup unseasoned rice vinegar",
        "1 tablespoon granulated sugar",
        "1 teaspoon kosher salt",
        "1 cup uncooked sushi rice",
        "¾ pounds sushi-grade salmon, thinly sliced",
        "Wasabi paste",
        "Soy sauce or tamari",
      ],
      preparationText:
          """Stir vinegar, sugar, and salt in a small bowl until dissolved.
Thoroughly rinse rice with running water and then cook according to package directions.
Spread rice in a large glass baking dish, drizzle with vinegar mixture, and then gently fold in to incorporate.
Form rice mixture into 16 (3-by-1-inch) pieces. Spread wasabi (to taste) on the underside of each piece of salmon. Lay the salmon on the rice. Serve with soy sauce or tamari for drizzling on the salmon.

You can top the seasoned rice portions with virtually any seafood or vegetable (or even fruit!). Just make sure the topping is trimmed to fit over the rice. Here are a few ideas.
Sliced, raw sushi-grade tuna
Cooked shrimp
Omelet
Fresh cut mango
Grilled shiitake mushroom caps
Cooked snow peas
Cooked asparagus""",
    ),
  ),
  SushiItemInfo(
    category: "Sashimi",
    title: 'Cucumber Rolls',
    imageAssetPath: 'assets/images/sushi5.png',
    description:
        """Salmon and Cucumber Rolls are a classic sushi roll that combines the fresh, delicate flavor of salmon with the crisp crunch of cucumber. 
These rolls feature:
- Fresh salmon: Rich in omega-3 fatty acids, fresh salmon provides a delicate, savory flavor that pairs perfectly with the other ingredients.
- Cucumber: Sliced cucumber adds a refreshing crunch and a subtle, cooling taste.
- Nori: A sheet of dried seaweed that wraps around the roll, holding the ingredients together.
- Sushi rice: The sushi rice is seasoned with vinegar, sugar, and salt, creating the perfect slightly tangy balance to the roll.
Salmon and Cucumber Rolls are a popular choice for sushi lovers due to their simplicity and balance of flavors. The roll is often served with soy sauce, wasabi, and pickled ginger for an added burst of flavor. It's a great choice for those who prefer lighter, fresher sushi options.""",
    nutritionInfo: NutritionInfo(
      calories: 250,
      fat: 7,
      carbs: 30,
      fiber: 2,
      sugar: 1,
      protein: 18,
    ),
    cookingTime: 30,
    cookRecipe: CookRecipeInfo(
      ingredients: [
        "1 cup sushi rice, cooked and seasoned",
        "4 sheets nori",
        "100g fresh salmon, thinly sliced",
        "1 cucumber, julienned",
        "Soy sauce, wasabi, and pickled ginger for serving",
      ],
      preparationText:
          """1. Cook the sushi rice and season it with rice vinegar, sugar, and salt. Let it cool.
2. On a bamboo sushi mat, place one sheet of nori with the rough side facing up.
3. Wet your hands and spread a thin layer of sushi rice evenly on the nori.
4. Arrange a line of salmon slices and julienned cucumber near the bottom edge of the nori.
5. Roll the sushi tightly, using the bamboo mat to shape the roll.
6. Slice the roll into bite-sized pieces and serve with soy sauce, wasabi, and pickled ginger.""",
    ),
  ),
  SushiItemInfo(
    category: "Nigiri",
    title: 'Temari Balls',
    imageAssetPath: 'assets/images/sushi6.png',
    description:
        """Temari Balls with Salmon are a beautiful and festive sushi dish that is both elegant and delicious. These sushi balls are perfect for special occasions and gatherings, offering a delightful twist on traditional sushi. 
Each Temari Ball is crafted with:
- Fresh salmon: Thin slices of fresh salmon are carefully placed on top of the sushi ball, providing a rich, buttery flavor.
- Sushi rice: The seasoned sushi rice is formed into small, round balls that are easy to eat in one bite.
- Toppings: Temari balls can be garnished with a variety of toppings, such as sesame seeds, avocado slices, or thin strips of cucumber, adding both flavor and texture.
Temari Balls with Salmon are not only a treat for the taste buds but also a visual delight, often served on elegant platters. The round shape makes them easy to handle, and they are commonly accompanied by soy sauce, wasabi, and pickled ginger. The combination of the soft rice and the silky salmon creates a melt-in-your-mouth experience that sushi lovers will appreciate.""",
    nutritionInfo: NutritionInfo(
      calories: 220,
      fat: 6,
      carbs: 28,
      fiber: 1,
      sugar: 1,
      protein: 16,
    ),
    cookingTime: 20,
    cookRecipe: CookRecipeInfo(
      ingredients: [
        "2 cups sushi rice, cooked and seasoned",
        "200g fresh salmon, thinly sliced",
        "Soy sauce, wasabi, and pickled ginger for serving",
        "Sesame seeds for garnish",
        "Optional: Avocado slices, thin cucumber strips",
      ],
      preparationText:
          """1. Cook the sushi rice and season it with rice vinegar, sugar, and salt. Let it cool.
2. Wet your hands and form the sushi rice into small, round balls about the size of a golf ball.
3. Place a slice of fresh salmon over each rice ball, gently pressing to mold the salmon onto the ball.
4. Garnish with sesame seeds or additional toppings like avocado or cucumber if desired.
5. Serve the Temari Balls on a platter with soy sauce, wasabi, and pickled ginger on the side.""",
    ),
  ),
];
