// profile_page.dart
import 'package:flutter/material.dart';
import 'auth_page.dart'; // Import the AuthPage
import 'settings_page.dart'; // Import the SettingsPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'Сергей Большаков'; // Default username

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/128/1077/1077063.png',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              username, // Use the dynamic username
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: sergeybolshakov@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the SettingsPage and wait for the result
                final result = await Navigator.of(context).push<String>(
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );

                // If a new username was returned, update the state
                if (result != null && result.isNotEmpty) {
                  setState(() {
                    username = result;
                  });
                }
              },
              child: const Text('Редактировать профиль'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Адрес пункта выдачи:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Введите адрес пункта выдачи',
                hintText: 'Например, ул. Ленина, 10',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Log out and navigate to the AuthPage
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
