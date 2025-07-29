import 'package:flutter/material.dart';
import 'package:crossapp/models/athlete.dart';

class AthleteDetailScreen extends StatelessWidget {
  final Athlete athlete;

  const AthleteDetailScreen({Key? key, required this.athlete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(athlete.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${athlete.id}'),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(athlete.name, style: Theme.of(context).textTheme.headlineSmall),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(athlete.email, style: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(height: 24),
            Text(
              'Personal Records',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...athlete.prs.map((pr) => Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                    leading: Icon(Icons.emoji_events, color: Color(0xFFFF6B35)),
                    title: Text(pr['exercise']!),
                    subtitle: Text(pr['date']!),
                    trailing: Text(pr['weight'] ?? pr['time']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  ))),
            SizedBox(height: 24),
            Text(
              'Recent Workouts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...athlete.recentWorkouts.map((workout) => Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                    leading: Icon(Icons.check_circle_outline, color: Color(0xFFFF6B35)),
                    title: Text(workout['wod']!),
                    subtitle: Text(workout['date']!),
                    trailing: Text(workout['result']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  ))),
          ],
        ),
      ),
    );
  }
}