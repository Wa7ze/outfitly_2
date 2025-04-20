import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Main%20pages/magic_page.dart';
import 'package:table_calendar/table_calendar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // Example events
  final Map<DateTime, List<String>> _events = {
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);
    if (events.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No outfit for this day.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MagicPage(
                    onThemeChange: () {}, // Pass a dummy callback or your actual theme change function
                    fromCalendar: true, // Indicate that this navigation is from the calendar
                  ),
                ),
              );
            },
            child: const Text('Create Your Outfit'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Add functionality for "Choose Your Outfit"
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Choose Your Outfit selected')),
              );
            },
            child: const Text('Choose Your Outfit'),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(events[index]),
          leading: const Icon(Icons.event),
        );
      },
    );
  }
}