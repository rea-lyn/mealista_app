import 'package:flutter/material.dart';

// Demonstration of receiving passed arguments via Navigator
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extracting passed arguments (Requirement 3: Passing of Data)
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    final name = args?['userName'] ?? 'User Profile';
    final email = args?['email'] ?? 'No email provided';
    final goal = args?['goal'] ?? 'Maintenance';

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.flag, color: Colors.green),
              title: const Text('Dietary Goal'),
              subtitle: Text(goal),
            ),
          ],
        ),
      ),
    );
  }
}
