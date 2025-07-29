import 'package:flutter/material.dart';
import 'package:crossapp/screens/coach/coach_dashboard_screen.dart';
import 'package:crossapp/screens/coach/workout_creator_screen.dart';
import 'package:crossapp/screens/coach/athlete_progress_screen.dart';
import 'package:crossapp/screens/coach/coach_profile_screen.dart';

class CoachHomeScreen extends StatefulWidget {
  @override
  _CoachHomeScreenState createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CoachDashboardScreen(),
    WorkoutCreatorScreen(),
    AthleteProgressScreen(),
    CoachProfileScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Athletes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
