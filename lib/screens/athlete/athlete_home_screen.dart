import 'package:flutter/material.dart';
import 'package:crossapp/screens/athlete/wod_screen.dart';
import 'package:crossapp/screens/athlete/progress_screen.dart';
import 'package:crossapp/screens/athlete/community_screen.dart';
import 'package:crossapp/screens/athlete/profile_screen.dart';

class AthleteHomeScreen extends StatefulWidget {
  @override
  _AthleteHomeScreenState createState() => _AthleteHomeScreenState();
}

class _AthleteHomeScreenState extends State<AthleteHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WODScreen(),
    ProgressScreen(),
    CommunityScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'WODs'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
