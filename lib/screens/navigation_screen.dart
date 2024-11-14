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
  int _selectedTabIndex = 0;

  final List<Widget> _screenWidgets = [
    const HomeScreen(),
    const LocationScreen(),
    const ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return CupertinoTabBar(
      backgroundColor: Colors.white,
      currentIndex: _selectedTabIndex,
      activeColor: kSecondaryColor,
      inactiveColor: Colors.grey,
      onTap: _onTabSelected,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          _screenWidgets[_selectedTabIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
