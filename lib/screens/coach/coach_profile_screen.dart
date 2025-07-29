import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/services/auth_service.dart';

class CoachProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=coachmalek'),
            ),
            SizedBox(height: 16),
            Text("Coach Malek", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Head Coach", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => authService.signOut(),
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}