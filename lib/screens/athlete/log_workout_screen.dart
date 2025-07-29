import 'package:flutter/material.dart';
import 'package:crossapp/models/wod.dart';

class LogWorkoutScreen extends StatefulWidget {
  final WOD wod;

  const LogWorkoutScreen({Key? key, required this.wod}) : super(key: key);

  @override
  _LogWorkoutScreenState createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final _mainScoreController = TextEditingController();
  final _notesController = TextEditingController();
  double _difficultyRating = 5.0;
  bool _showOnLeaderboard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log ${widget.wod.name}"),
        actions: [
          TextButton(
            onPressed: _saveWorkout,
            child: Text("Save", style: TextStyle(color: Color(0xFFFF6B35))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.wod.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(widget.wod.description),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _mainScoreController,
              decoration: InputDecoration(
                labelText: 'Score (Time, Rounds/Reps, etc.)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text("Difficulty/Feel", style: Theme.of(context).textTheme.titleLarge),
            Slider(
              value: _difficultyRating,
              min: 1,
              max: 10,
              divisions: 9,
              label: _difficultyRating.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _difficultyRating = value;
                });
              },
            ),
            SizedBox(height: 24),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.photo_camera, color: Colors.grey),
                SizedBox(width: 8),
                TextButton(onPressed: () {}, child: Text("Add Photo/Video")),
              ],
            ),
            SizedBox(height: 24),
            SwitchListTile(
              title: Text("Show on Leaderboard"),
              value: _showOnLeaderboard,
              onChanged: (bool value) {
                setState(() {
                  _showOnLeaderboard = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveWorkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Workout logged successfully!"),
        backgroundColor: Color(0xFFFF6B35),
      ),
    );
    Navigator.pop(context);
  }
}