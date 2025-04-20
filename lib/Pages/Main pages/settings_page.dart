import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onThemeChange;

  const SettingsPage({super.key, required this.onThemeChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Close the settings page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Profile Info Option
            ListTile(
              title: const Text('Profile Info'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Add functionality here in the future
              },
            ),
            const SizedBox(height: 16),

            // Theme Change Button
            ElevatedButton(
              onPressed: onThemeChange,
              child: const Text('Change Theme'),
            ),
          ],
        ),
      ),
    );
  }
}