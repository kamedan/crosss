import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/models/wod.dart';
import 'package:crossapp/services/data_service.dart';
import 'package:crossapp/widgets/wod_card.dart';
import 'package:crossapp/screens/athlete/log_workout_screen.dart';

class WODScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Today's WODs", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<WOD>>(
        future: dataService.getWODs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final wods = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: wods.length,
              itemBuilder: (context, index) {
                return WODCard(
                  wod: wods[index],
                  onLogWorkout: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogWorkoutScreen(wod: wods[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading WODs'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}