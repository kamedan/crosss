import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/models/athlete.dart';
import 'package:crossapp/services/data_service.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: FutureBuilder<List<Athlete>>(
        future: dataService.getAthletes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final athlete = snapshot.data![0]; // Using the first athlete for demo
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Personal Records", style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 16),
                _buildPRList(athlete.prs),
                SizedBox(height: 24),
                Text("Recent Workouts", style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 16),
                _buildRecentWorkouts(athlete.recentWorkouts),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPRList(List<Map<String, String>> prs) {
    return Column(
      children: prs
          .map((pr) => Card(
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(Icons.emoji_events, color: Color(0xFFFF6B35)),
                  title: Text(pr['exercise']!),
                  subtitle: Text(pr['date']!),
                  trailing: Text(pr['weight'] ?? pr['time']!, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildRecentWorkouts(List<Map<String, String>> recentWorkouts) {
    return Column(
      children: recentWorkouts.map((workout) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.check_circle_outline, color: Color(0xFFFF6B35)),
            title: Text(workout['wod']!),
            subtitle: Text(workout['date']!),
            trailing: Text(workout['result']!, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        );
      }).toList(),
    );
  }
}