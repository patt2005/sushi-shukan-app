import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:sushi_shukan_app/components/sushi_card.dart';
import 'package:sushi_shukan_app/models/sushi_item.dart';
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
  List<SushiItem> filteredSushiItems = sushiItemsList;

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
      if (query.isEmpty) {
        filteredSushiItems = sushiItemsList;
      } else {
        filteredSushiItems = sushiItemsList
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
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
    return GestureDetector(
      onTap: () => _dismissKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: const Color(0xFF582D14),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.1),
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
                    SizedBox(width: screenSize.width * 0.04),
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
                SizedBox(height: screenSize.height * 0.05),
                ListTile(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(
                          "https://docs.google.com/document/d/1QZHHNKDJNJqUBTeGoIxs_aclRqd8KLLYuZ5TQehTyRU/edit?usp=sharing"),
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
                    await launchUrl(
                      Uri.parse(
                          "https://docs.google.com/document/d/1kqEF1_yFJdzOOAS5zfhxcvJueg--noc6yc3Ivo_QKQY/edit?usp=sharing"),
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
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.03),
                  Row(
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
                      SizedBox(width: screenSize.width * 0.04),
                      Text(
                        "Master Sushi at Home",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: kSecondaryColor,
                        size: 28,
                      ),
                      hintText: 'Search sushi recipes',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: kBackgroundColor,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF114960),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Master Sushi Making",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              const Text(
                                "Learn more tips and tricks at mastering sushi making at home!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 7),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(kSecondaryColor),
                                ),
                                onPressed: () async {
                                  await launchUrl(
                                    Uri.parse(
                                        "https://schoolofwok.co.uk/blog/show/how-to-master-making-sushi"),
                                  );
                                },
                                child: const Text(
                                  "Learn more",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "assets/images/sushi.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    "Discover",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: kSecondaryColor),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: filteredSushiItems.length, // Use filtered list
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => SushiInfoScreen(
                                sushiItemInfo: filteredSushiItems[index],
                              ),
                            ),
                          );
                        },
                        child: SushiCard(
                          name: filteredSushiItems[index].title,
                          imageUrl: filteredSushiItems[index].imageAssetPath,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
