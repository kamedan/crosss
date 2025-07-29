import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/services/auth_service.dart';
import 'package:crossapp/screens/athlete/personal_records_screen.dart';
import 'package:crossapp/screens/athlete/workout_history_screen.dart';
import 'package:crossapp/screens/athlete/goals_screen.dart';
import 'package:crossapp/screens/athlete/body_measurements_screen.dart';
import 'package:crossapp/screens/athlete/achievements_screen.dart';
import 'package:crossapp/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;

    final menuItems = [
      {"title": "Personal Records", "icon": Icons.emoji_events, "page": PersonalRecordsScreen()},
      {"title": "Workout History", "icon": Icons.history, "page": WorkoutHistoryScreen()},
      {"title": "Goals & Targets", "icon": Icons.flag, "page": GoalsScreen()},
      {"title": "Body Measurements", "icon": Icons.straighten, "page": BodyMeasurementsScreen()},
      {"title": "Achievements", "icon": Icons.military_tech, "page": AchievementsScreen()},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(user?.email ?? 'Anonymous'),
              background: Image.network(
                'https://i.pravatar.cc/300?u=athlete',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = menuItems[index];
                return ListTile(
                  leading: Icon(item["icon"] as IconData, color: Color(0xFFFF6B35)),
                  title: Text(item["title"] as String),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item["page"] as Widget),
                    );
                  },
                );
              },
              childCount: menuItems.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  authService.signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text("Sign Out"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}