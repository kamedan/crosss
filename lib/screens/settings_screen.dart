import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Edit Profile'),
            leading: Icon(Icons.person),
            onTap: () {},
          ),
          ListTile(
            title: Text('Notifications'),
            leading: Icon(Icons.notifications),
            onTap: () {},
          ),
          ListTile(
            title: Text('Privacy Policy'),
            leading: Icon(Icons.policy),
            onTap: () {},
          ),
          ListTile(
            title: Text('Terms of Service'),
            leading: Icon(Icons.description),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            textColor: Colors.red,
            onTap: () {
              authService.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
