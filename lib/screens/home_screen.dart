import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:sushi_shukan_app/components/sushi_card.dart';
import 'package:sushi_shukan_app/models/sushi_item.dart';
import 'package:sushi_shukan_app/screens/info_screen.dart';
import 'package:sushi_shukan_app/screens/sushi_info_screen.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  List<SushiItemInfo> filteredSushiItems = sushiItemsList;
  final List<String> _categories = ["All", "Maki", "Nigiri", "Sashimi"];
  String _selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _filterSushiItems(_searchController.text);
    });
  }

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _filterSushiItems(String query) {
    setState(() {
      if (query.isEmpty && _selectedCategory == "All") {
        filteredSushiItems = sushiItemsList;
      } else {
        filteredSushiItems = sushiItemsList.where((item) {
          final matchesQuery = query.isEmpty ||
              item.title.toLowerCase().contains(query.toLowerCase());
          final matchesCategory =
              _selectedCategory == "All" || item.category == _selectedCategory;
          return matchesQuery && matchesCategory;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 768;

    return GestureDetector(
      onTap: () => _dismissKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        drawer: _buildDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 20),
                  _buildCarousel(),
                  const SizedBox(height: 20),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildCategories(),
                  const SizedBox(height: 20),
                  _buildRecipeGrid(isLargeScreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              CupertinoIcons.square_grid_2x2,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Sushi Shukan!",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Text(
                "Discover new recipes and master sushi at home.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isIpad(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = size.width / size.height;

    return size.width >= 768 && aspectRatio < 1.6;
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      items: [
        _buildCarouselItem("assets/images/featured1.png", "Special Maki Roll"),
        _buildCarouselItem("assets/images/featured2.png", "Nigiri Masterclass"),
        _buildCarouselItem("assets/images/featured3.png", "Sashimi Secrets"),
      ],
      options: CarouselOptions(
        height: _isIpad(context) ? 300 : 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: kSecondaryColor,
          size: 28,
        ),
        hintText: 'Search sushi recipes',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        filled: true,
        fillColor: kBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories
            .map((category) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                      _filterSushiItems(_searchController.text);
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: _selectedCategory == category
                          ? kSecondaryColor
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: _selectedCategory == category
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildRecipeGrid(bool isLargeScreen) {
    return GridView.builder(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 3 : 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.1,
      ),
      itemCount: filteredSushiItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) =>
                    SushiInfoScreen(sushiItemInfo: filteredSushiItems[index]),
              ),
            );
          },
          child: SushiCard(
            name: filteredSushiItems[index].title,
            imageUrl: filteredSushiItems[index].imageAssetPath,
          ),
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF582D14),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                const Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 34,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            ListTile(
              onTap: () async {
                await Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const InfoScreen(
                        url:
                            "https://docs.google.com/document/d/1QZHHNKDJNJqUBTeGoIxs_aclRqd8KLLYuZ5TQehTyRU/edit?usp=sharing",
                        showAppBar: true),
                  ),
                );
              },
              leading: const Icon(
                CupertinoIcons.lock_shield,
                color: Colors.white,
              ),
              title: const Text(
                "Privacy Policy",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                final InAppReview inAppReview = InAppReview.instance;

                if (await inAppReview.isAvailable()) {
                  await inAppReview.requestReview();
                }
              },
              leading: const Icon(
                CupertinoIcons.hand_thumbsup,
                color: Colors.white,
              ),
              title: const Text(
                "Rate us",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const InfoScreen(
                        url:
                            "https://docs.google.com/document/d/1kqEF1_yFJdzOOAS5zfhxcvJueg--noc6yc3Ivo_QKQY/edit?usp=sharing",
                        showAppBar: true),
                  ),
                );
              },
              leading: const Icon(
                CupertinoIcons.info_circle,
                color: Colors.white,
              ),
              title: const Text(
                "About the app",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                final emailUrl = Uri(
                  scheme: 'mailto',
                  path: "leahreyestr@gmx.com",
                );

                await launchUrl(emailUrl);
              },
              leading: const Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.white,
              ),
              title: const Text(
                "Contact us",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/sushi_drawer.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
