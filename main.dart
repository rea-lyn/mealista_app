import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/meal_provider.dart';
import 'screens/home_screen.dart';
import 'screens/plan_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MealProvider(),
      child: const MealistaApp(),
    ),
  );
}

class MealistaApp extends StatelessWidget {
  const MealistaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mealista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Inter',
      ),
      // Requirement 2: Named Routes Navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const NavigationContainerScreen(),
        '/home': (context) => const HomeScreen(),
        '/plan': (context) => const PlanScreen(),
        '/reminders': (context) => const RemindersScreen(),
        '/notes': (context) => const NotesScreen(),
        '/profile': (context) => const ProfileScreen(), // Requirement 1 & 3: Navigator with Profile Page
      },
    );
  }
}

// Container Screen with Bottom Navigation Bar & Scrollable View
class NavigationContainerScreen extends StatefulWidget {
  const NavigationContainerScreen({Key? key}) : super(key: key);

  @override
  State<NavigationContainerScreen> createState() => _NavigationContainerScreenState();
}

class _NavigationContainerScreenState extends State<NavigationContainerScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    PlanScreen(),
    RemindersScreen(),
    NotesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: const [
            Icon(Icons.eco, color: Colors.green),
            SizedBox(width: 8),
            Text('Mealista', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black87),
            onPressed: () {
              // Requirement 3: Passing Data through Named Routes
              Navigator.pushNamed(
                context, 
                '/profile',
                arguments: {
                  'userName': 'Realyn A. Maraña',
                  'email': 'realyn@example.com',
                  'goal': 'Healthy Weight Maintenance',
                },
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Requirement 4: setState() usage for bottom tab bar index
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Reminders'),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: 'Notes'),
        ],
      ),
    );
  }
}

