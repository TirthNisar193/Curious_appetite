import 'package:flutter/material.dart';
import 'package:mine/Screens/NavPages/add_to_menu.dart';
import 'package:mine/Screens/NavPages/favorites.dart';
import 'package:mine/Screens/NavPages/homescreen.dart';
import 'package:mine/Screens/NavPages/search_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  List<Widget> pages = const <Widget> [
    HomeScreen(),
    SearchPage(),
    Favorites(),
    AddToMenu(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CURIOUS APETITE'),
      ),
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'HOME',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'CUiSINES',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_border_outlined),
            label: 'FAVORITE',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_box_rounded),
            icon: Icon(Icons.add),
            label: 'ADD',
          ),
        ],
      ),
    );
  }
}
