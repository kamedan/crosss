import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: CrossFitApp(),
    ),
  );
}

class CrossFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossFit Pro',
      debugShowCheckedModeBanner: false,
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
      darkTheme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Color(0xFFFF6B35),
        brightness: Brightness.dark,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.light, // This can be updated based on user preferences
      home: AuthWrapper(),
    );
  }
}

class AuthService with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signIn(String email, String password) async {
    if (email == 'demo1' && password == 'demo1') {
      _user = UserModel(uid: '1', email: 'demo1', role: 'athlete');
      notifyListeners();
    } else if (email == 'demo2' && password == 'demo2') {
      _user = UserModel(uid: '2', email: 'demo2', role: 'coach');
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
}

class UserModel {
  final String uid;
  final String email;
  final String role;

  UserModel({required this.uid, required this.email, required this.role});
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    if (authService.isLoggedIn) {
      return MainScreen(isCoach: authService.user!.role == 'coach');
    } else {
      return LoginScreen();
    }
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isCoach = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                size: 80,
                color: Color(0xFFFF6B35),
              ),
              SizedBox(height: 24),
              Text(
                "CrossFit By Malek",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B35),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Train. Track. Transform.",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 48),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isCoach = false),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isCoach
                                ? Color(0xFFFF6B35)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "Athlete",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: !isCoach ? Colors.white : Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isCoach = true),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isCoach
                                ? Color(0xFFFF6B35)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "Coach",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isCoach ? Colors.white : Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              _buildTextField("Username", Icons.person, controller: _emailController),
              SizedBox(height: 16),
              _buildTextField("Password", Icons.lock, isPassword: true, controller: _passwordController),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    authService.signIn(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6B35),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 16),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {bool isPassword = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFFF6B35)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFF6B35)),
        ),
      ),
    );
  }
}



class MainScreen extends StatefulWidget {
  final bool isCoach;

  MainScreen({required this.isCoach});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: Color(0xFFFF6B35),
          unselectedItemColor: Colors.grey,
          items: widget.isCoach ? _coachNavItems : _athleteNavItems,
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    if (widget.isCoach) {
      switch (index) {
        case 0:
          return CoachDashboard();
        case 1:
          return WorkoutCreator();
        case 2:
          return AthleteProgress();
        case 3:
          return CoachProfile();
        default:
          return CoachDashboard();
      }
    } else {
      switch (index) {
        case 0:
          return WODScreen();
        case 1:
          return ProgressScreen();
        case 2:
          return CommunityScreen();
        case 3:
          return ProfileScreen();
        default:
          return WODScreen();
      }
    }
  }

  List<BottomNavigationBarItem> get _athleteNavItems => [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'WODs'),
        BottomNavigationBarItem(
            icon: Icon(Icons.trending_up), label: 'Progress'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ];

  List<BottomNavigationBarItem> get _coachNavItems => [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Athletes'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ];
}

class WODScreen extends StatelessWidget {
  final List<WOD> wods = [
    WOD(name: 'Fran', description: '21-15-9 reps for time of: Thrusters (95/65 lb) Pull-ups', type: 'For Time', timeCapMinutes: 10, movements: ['Thrusters', 'Pull-ups']),
    WOD(name: 'Cindy', description: 'As Many Rounds As Possible in 20 minutes of: 5 Pull-ups, 10 Push-ups, 15 Air Squats', type: 'AMRAP', timeCapMinutes: 20, movements: ['Pull-ups', 'Push-ups', 'Air Squats']),
    WOD(name: 'Murph', description: 'For time: 1 mile Run, 100 Pull-ups, 200 Push-ups, 300 Air Squats, 1 mile Run', type: 'For Time', timeCapMinutes: 60, movements: ['Run', 'Pull-ups', 'Push-ups', 'Air Squats']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Today's WODs", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: wods.length,
        itemBuilder: (context, index) {
          return WODCard(wod: wods[index]);
        },
      ),
    );
  }
}

class WOD {
  final String name;
  final String description;
  final String type;
  final int timeCapMinutes;
  final List<String> movements;

  WOD({
    required this.name,
    required this.description,
    required this.type,
    required this.timeCapMinutes,
    required this.movements,
  });

  factory WOD.fromMap(Map<String, dynamic> map) {
    return WOD(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      timeCapMinutes: map['timeCapMinutes'] ?? 0,
      movements: List<String>.from(map['movements'] ?? []),
    );
  }
}

class WODCard extends StatelessWidget {
  final WOD wod;

  WODCard({required this.wod});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6B35).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    wod.type,
                    style: TextStyle(
                      color: Color(0xFFFF6B35),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  "${wod.timeCapMinutes} min cap",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              wod.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              wod.description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.fitness_center, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  wod.movements.join(", "),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LogWorkoutScreen(wod: wod),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6B35),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("Log Workout"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogWorkoutScreen extends StatefulWidget {
  final WOD wod;

  LogWorkoutScreen({required this.wod});

  @override
  _LogWorkoutScreenState createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();
  String selectedScale = "RX";
  bool isCompleted = false;

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
            Text(
              "Scale",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: ["RX", "Scaled", "Modified"].map((scale) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedScale = scale),
                    child: Container(
                      margin:
                          EdgeInsets.only(right: scale != "Modified" ? 8 : 0),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedScale == scale
                            ? Color(0xFFFF6B35)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        scale,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedScale == scale
                              ? Colors.white
                              : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            Text(
              "Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                hintText: "MM:SS",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFFF6B35)),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) => setState(() => isCompleted = value!),
                  activeColor: Color(0xFFFF6B35),
                ),
                Text("Completed as written"),
              ],
            ),
            SizedBox(height: 24),
            Text(
              "Notes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "How did it feel? Any modifications?",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFFF6B35)),
                ),
              ),
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

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Progress", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: 24),
            Text(
              "Personal Records",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildPRList(),
            SizedBox(height: 24),
            Text(
              "Recent Workouts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildRecentWorkouts(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
            child: _buildStatCard(
                "Workouts\nThis Week", "3", Icons.fitness_center)),
        SizedBox(width: 12),
        Expanded(
            child: _buildStatCard("PRs\nThis Month", "1", Icons.trending_up)),
        SizedBox(width: 12),
        Expanded(
            child: _buildStatCard("Total\nWorkouts", "58", Icons.analytics)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8A50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPRList() {
    final prs = [
      {"exercise": "Back Squat", "weight": "225 lbs", "date": "3 days ago"},
      {"exercise": "Deadlift", "weight": "315 lbs", "date": "1 week ago"},
      {"exercise": "Fran", "time": "3:42", "date": "2 weeks ago"},
    ];

    return Column(
      children: prs
          .map((pr) => Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.emoji_events, color: Color(0xFFFF6B35)),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pr["exercise"]!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            pr["date"]!,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      pr.containsKey("weight") ? pr["weight"]! : pr["time"]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildRecentWorkouts() {
    final recentWorkouts = [
      {"wod": "Fran", "result": "3:42 RX", "date": "3 days ago"},
      {"wod": "Cindy", "result": "20 rounds + 5 reps", "date": "5 days ago"},
      {"wod": "Murph", "result": "55:12 Scaled", "date": "1 week ago"},
    ];

    return Column(
      children: recentWorkouts.map((workout) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Color(0xFFFF6B35)),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout["wod"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      workout["date"]!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                workout["result"]!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B35),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelColor: Color(0xFFFF6B35),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFFFF6B35),
              tabs: [
                Tab(text: "Feed"),
                Tab(text: "Leaderboard"),
                Tab(text: "Athletes"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFeed(),
                  _buildLeaderboard(),
                  _buildAthletes(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeed() {
    return Center(child: Text("The community feed will be displayed here."));
  }

  Widget _buildLeaderboard() {
    final leaderboard = [
      {"rank": 1, "name": "Alex Johnson", "score": "3:15", "workout": "Fran"},
      {"rank": 2, "name": "Sarah Miller", "score": "3:42", "workout": "Fran"},
      {"rank": 3, "name": "David Chen", "score": "4:01", "workout": "Fran"},
      {"rank": 4, "name": "Emma Wilson", "score": "4:18", "workout": "Fran"},
      {"rank": 5, "name": "Mike Torres", "score": "4:33", "workout": "Fran"},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        final entry = leaderboard[index];
        final rank = entry["rank"] as int;

        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: rank <= 3
                ? Border.all(
                    color: rank == 1
                        ? Colors.amber
                        : rank == 2
                            ? Colors.grey
                            : Colors.brown,
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: rank <= 3
                      ? (rank == 1
                          ? Colors.amber
                          : rank == 2
                              ? Colors.grey
                              : Colors.brown)
                      : Color(0xFFFF6B35).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: rank <= 3
                      ? Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 20,
                        )
                      : Text(
                          "$rank",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B35),
                          ),
                        ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry["name"] as String,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      entry["workout"] as String,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                entry["score"] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B35),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAthletes() {
    return Center(child: Text("A list of athletes will be displayed here."));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(user),
            SizedBox(height: 24),
            _buildStatsGrid(),
            SizedBox(height: 24),
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserModel? user) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8A50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Color(0xFFFF6B35),
            ),
          ),
          SizedBox(height: 16),
          Text(
            user?.email ?? 'Anonymous',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Member since Jan 2023",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat("Current Streak", "7 days"),
              _buildProfileStat("Total PRs", "23"),
              _buildProfileStat("Rank", "#12"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard("Total\nWorkouts", "142", Icons.fitness_center),
        _buildStatCard("This Month", "18", Icons.calendar_today),
        _buildStatCard("Avg/Week", "4.2", Icons.trending_up),
        _buildStatCard("Favorite", "Fran", Icons.favorite),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFFFF6B35), size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6B35),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {
        "title": "Personal Records",
        "icon": Icons.emoji_events,
        "subtitle": "View all your PRs"
      },
      {
        "title": "Workout History",
        "icon": Icons.history,
        "subtitle": "See past workouts"
      },
      {
        "title": "Goals & Targets",
        "icon": Icons.flag,
        "subtitle": "Set and track goals"
      },
      {
        "title": "Body Measurements",
        "icon": Icons.straighten,
        "subtitle": "Track body metrics"
      },
      {
        "title": "Achievements",
        "icon": Icons.military_tech,
        "subtitle": "Unlock badges"
      },
    ];

    return Column(
      children: menuItems
          .map((item) => Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6B35).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(item["icon"] as IconData,
                        color: Color(0xFFFF6B35)),
                  ),
                  title: Text(
                    item["title"] as String,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(item["subtitle"] as String),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {},
                ),
              ))
          .toList(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;
  bool workoutReminders = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSection("Appearance", [
            _buildToggleTile(
              "Dark Mode",
              "Switch to dark theme",
              darkMode,
              (value) => setState(() => darkMode = value),
              Icons.dark_mode,
            ),
          ]),
          _buildSection("Notifications", [
            _buildToggleTile(
              "Push Notifications",
              "Receive workout and community updates",
              notifications,
              (value) => setState(() => notifications = value),
              Icons.notifications,
            ),
            _buildToggleTile(
              "Workout Reminders",
              "Daily reminders to log workouts",
              workoutReminders,
              (value) => setState(() => workoutReminders = value),
              Icons.alarm,
            ),
          ]),
          _buildSection("Account", [
            _buildMenuTile("Edit Profile", "Update your information",
                Icons.person_outline),
            _buildMenuTile("Privacy Settings", "Control your data",
                Icons.privacy_tip_outlined),
            _buildMenuTile("Connected Apps", "Manage integrations", Icons.apps),
          ]),
          _buildSection("Support", [
            _buildMenuTile(
                "Help & FAQ", "Get help and answers", Icons.help_outline),
            _buildMenuTile(
                "Contact Support", "Reach out to us", Icons.support_agent),
            _buildMenuTile("Rate App", "Leave a review", Icons.star_outline),
          ]),
          _buildSection("Legal", [
            _buildMenuTile(
                "Terms of Service", "Read our terms", Icons.description),
            _buildMenuTile(
                "Privacy Policy", "Read our privacy policy", Icons.policy),
          ]),
          SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () {
                authService.signOut();
              },
              child: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6B35),
            ),
          ),
        ),
        ...items,
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildToggleTile(String title, String subtitle, bool value,
      Function(bool) onChanged, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        secondary: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFF6B35).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFFFF6B35)),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFFFF6B35),
      ),
    );
  }

  Widget _buildMenuTile(String title, String subtitle, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFF6B35).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFFFF6B35)),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

class CoachDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coach Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickStats(),
            SizedBox(height: 24),
            _buildTodayOverview(),
            SizedBox(height: 24),
            _buildRecentActivity(),
            SizedBox(height: 24),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
            child: _buildStatCard(
                "Active\nAthletes", "42", Icons.people, Color(0xFFFF6B35))),
        SizedBox(width: 12),
        Expanded(
            child: _buildStatCard("Today's\nAttendance", "28",
                Icons.check_circle, Color(0xFF4ECDC4))),
        SizedBox(width: 12),
        Expanded(
            child: _buildStatCard("This Week\nWorkouts", "156",
                Icons.fitness_center, Color(0xFF45B7D1))),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTodayOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Overview",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("WOD: Fran", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("10 min cap"),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildOverviewStat("Completed", "18"),
                  _buildOverviewStat("RX", "12"),
                  _buildOverviewStat("Scaled", "6"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF6B35))),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildActivityItem("Sarah M. logged Fran", "3:42 RX", Icons.check_circle, Colors.green),
        _buildActivityItem("Mike T. achieved a new PR", "225lb Back Squat", Icons.emoji_events, Colors.amber),
        _buildActivityItem("Emma W. joined the 6am class", "", Icons.add, Colors.blue),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildActionCard("Create WOD", Icons.add, () {})),
            SizedBox(width: 12),
            Expanded(child: _buildActionCard("Message All", Icons.message, () {})),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFFFF6B35), size: 32),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}