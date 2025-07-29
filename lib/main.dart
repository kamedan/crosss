import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crossapp/services/auth_service.dart';
import 'package:crossapp/services/data_service.dart';
import 'package:crossapp/screens/auth/login_screen.dart';
import 'package:crossapp/screens/athlete/athlete_home_screen.dart';
import 'package:crossapp/screens/coach/coach_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => DataService()),
      ],
      child: MaterialApp(
        title: 'CrossFit By Malek',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Color(0xFFFF6B35),
          brightness: Brightness.light,
          fontFamily: 'SF Pro Display',
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    if (authService.isLoggedIn) {
      if (authService.user!.role == 'coach') {
        return CoachHomeScreen();
      } else {
        return AthleteHomeScreen();
      }
    } else {
      return LoginScreen();
    }
  }
}