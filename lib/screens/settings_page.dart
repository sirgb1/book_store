// settings_page.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String username = 'Сергей Большаков'; // Default username

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки профиля'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Изменить имя пользователя:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Имя пользователя',
                hintText: 'Введите новое имя',
              ),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Return the new username to the ProfilePage
                Navigator.of(context).pop(username);
              },
              child: const Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }
}
