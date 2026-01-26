import 'package:flutter/material.dart';
import 'package:recipe_book/features/recipie/screens/main/widgets/custom_bottom_bar.dart';

import '../../../profile/screens/setting/setting_screen.dart';
import '../favourite/favourite_screen.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
     const HomeScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display current screen
//custom navigator bar
      bottomNavigationBar:CustomBottomNavigationBar(currentIndex: _currentIndex, onTap: (index){
        setState(() {
          _currentIndex = index;
        });
      })
    );
  }
}
