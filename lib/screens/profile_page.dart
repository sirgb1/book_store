import 'package:flutter/material.dart';
import 'auth_page.dart'; // Import the AuthPage
import 'settings_page.dart'; // Import the SettingsPage
import '../data/pickup_points.dart'; // Import the pickup points

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'Сергей Большаков'; // Default username
  String selectedPickupPoint = pickupPoints[0]; // Default selected pickup point

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Профиль'),
      //   backgroundColor: Colors.blueGrey, // Consistent app bar color
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: const NetworkImage(
                  'https://cdn-icons-png.flaticon.com/128/3024/3024605.png',
                ),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 20),

            // Username
            Center(
              child: Text(
                username, // Dynamic username
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Email
            Center(
              child: Text(
                'Email: sergeybolshakov@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Edit Profile Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8D6E63), // Consistent button color
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
              child: const Center(
                child: Text(
                  'Редактировать профиль',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Pickup Point Label
            const Text(
              'Адрес пункта выдачи:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Dropdown for Pickup Points
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                value: selectedPickupPoint,
                isExpanded: true, // Full width
                underline: Container(), // Remove default underline
                items: pickupPoints.map((String point) {
                  return DropdownMenuItem<String>(
                    value: point,
                    child: Text(
                      point,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPickupPoint = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),

            // Logout Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF451407), // Consistent button color
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // Log out and navigate to the AuthPage
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              },
              child: const Center(
                child: Text(
                  'Выйти',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
