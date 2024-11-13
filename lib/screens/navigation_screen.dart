import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_shukan_app/screens/home_screen.dart';
import 'package:sushi_shukan_app/screens/location_screen.dart';
import 'package:sushi_shukan_app/screens/profile_screen.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentPageIndex = 0;

  final List<Widget> _pagesList = [
    const HomeScreen(),
    const LocationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          _pagesList[_currentPageIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: CupertinoTabBar(
              backgroundColor: Colors.white,
              currentIndex: _currentPageIndex,
              activeColor: kSecondaryColor,
              inactiveColor: Colors.grey,
              onTap: (value) {
                setState(() {
                  _currentPageIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.placemark),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.map),
                  label: "Location",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
