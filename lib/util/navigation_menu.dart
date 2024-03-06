import 'package:flutter/material.dart';
import '../page/about_me_page.dart';
import '../page/home_page.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _pageIndex = 0;

  final screenBody = [
    const HomePage(),
    const AboutMePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBody[_pageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(color: Color(0xFFE6E6E6), width: 2.0),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          currentIndex: _pageIndex,
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_sharp),
                activeIcon: Icon(Icons.person_sharp),
                label: 'Profile')
          ],
        ),
      ),
    );
  }
}
