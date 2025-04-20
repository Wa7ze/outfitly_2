import 'package:flutter/material.dart';

class MagicPage extends StatelessWidget {
  final VoidCallback onThemeChange;
  final bool fromCalendar; // Add this parameter to differentiate navigation

  const MagicPage({super.key, required this.onThemeChange, this.fromCalendar = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Magic',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Magic Page!',
              style: TextStyle(fontSize: 20),
            ),
            if (fromCalendar) // Show this only if navigated from the calendar
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'You were redirected here from the Calendar page.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}