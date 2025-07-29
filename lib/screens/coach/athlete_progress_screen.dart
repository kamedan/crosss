import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/models/athlete.dart';
import 'package:crossapp/services/data_service.dart';
import 'package:crossapp/screens/coach/athlete_detail_screen.dart';

class AthleteProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Athlete Progress'),
      ),
      body: FutureBuilder<List<Athlete>>(
        future: dataService.getAthletes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final athletes = snapshot.data!;
            return ListView.builder(
              itemCount: athletes.length,
              itemBuilder: (context, index) {
                final athlete = athletes[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(athlete.name[0]),
                  ),
                  title: Text(athlete.name),
                  subtitle: Text(athlete.email),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AthleteDetailScreen(athlete: athlete),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading athletes'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}