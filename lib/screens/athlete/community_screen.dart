import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/models/athlete.dart';
import 'package:crossapp/services/data_service.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Community'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Leaderboard'),
              Tab(text: 'Feed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLeaderboard(context),
            _buildFeed(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboard(BuildContext context) {
    final dataService = Provider.of<DataService>(context);
    return FutureBuilder<List<Athlete>>(
      future: dataService.getAthletes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final athletes = snapshot.data!;
        return ListView.builder(
          itemCount: athletes.length,
          itemBuilder: (context, index) {
            final athlete = athletes[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(athlete.name),
                trailing: Text(athlete.recentWorkouts[0]['result']!, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFeed() {
    return Center(
      child: Text("Community feed coming soon!"),
    );
  }
}