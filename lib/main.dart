// ignore_for_file: deprecated_member_use, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/The+Button/AddItemOptionsPage.dart';
import 'package:flutter_application_1/Pages/Main%20pages/clalender%20page.dart';
import 'package:flutter_application_1/Pages/Main%20pages/magic_page.dart';
import 'package:flutter_application_1/Pages/Main%20pages/profile_page.dart';
import 'package:flutter_application_1/Pages/Main%20pages/wardrobe_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _cycleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outfit App',
      theme: ThemeData.light().copyWith(
        splashColor: Color.fromARGB(255, 243, 225, 88).withOpacity(0.2), // Ripple effect color
        highlightColor: Color.fromARGB(255, 243, 225, 88).withOpacity(0), // Highlight effect color
        iconTheme: const IconThemeData(
          size: 24.0, // Example property, adjust as needed
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        splashColor: Color.fromARGB(255, 243, 225, 88).withOpacity(0.2), // Ripple effect color for dark mode
        highlightColor: Color.fromARGB(255, 243, 225, 88).withOpacity(0.5), // Highlight effect color for dark mode
      ),
      themeMode: _themeMode, // Dynamically change theme
      debugShowCheckedModeBanner: false,
      home: MainPage(
        onThemeChange: _cycleTheme, // Pass the theme change callback
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final VoidCallback onThemeChange;

  const MainPage({super.key, required this.onThemeChange});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 3; // Default to 'Profile'
  final List<File> _items = []; // Initialize the shared items list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 172, 163, 90),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'Outfitly',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 254, 254, 254),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Stack(
        children: [
          // Pass the shared items list to the pages
          IndexedStack(
            index: _currentIndex,
            children: [
              WardrobePage(items: _items), // Pass the items list
              MagicPage(
                onThemeChange: widget.onThemeChange,
                fromCalendar: false, // Indicate this is from the bottom nav bar
              ),
              const FeedPage(),
              ProfilePage(items: _items, onThemeChange: widget.onThemeChange), // Pass the items list
            ],
          ),

          // Floating Navigation Bar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                selectedItemColor: const Color.fromARGB(255, 243, 225, 88),
                unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 10,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.blinds_closed),
                    label: 'Wardrobe',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.auto_awesome),
                    label: 'Magic',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.article),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),

          // Floating Circular Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: _showAddItemOptions, // Call the new method
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 216, 120),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddItemOptions() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose Photo from Library'),
              onTap: () async {
                Navigator.pop(context); // Close the bottom sheet
                showDialog(
                  context: context,
                  builder: (_) => const AddItemOptionsPage(), // Navigate to AddItemOptionsPage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                showDialog(
                  context: context,
                  builder: (_) => const AddItemOptionsPage(), // Navigate to AddItemOptionsPage
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showCategorySelection(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedCategory;
        String? selectedSubCategory;
        List<String> subCategories = []; // List to hold subcategories based on the selected category

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Category and Subcategory'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Main Category Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: {
                      'Tops': ['T-Shirts', 'LongSleeves', 'Shirts'],
                      'Bottoms': ['Jeans', 'Shorts', 'Joggers'],
                      'Accessories': ['Bracelets', 'Necklaces', 'Rings', 'HandBags'],
                      'Shoes': ['Sneakers', 'Sandals', 'Boots'],
                    }.keys.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        subCategories = {
                          'Tops': ['T-Shirts', 'LongSleeves', 'Shirts'],
                          'Bottoms': ['Jeans', 'Shorts', 'Joggers'],
                          'Accessories': ['Bracelets', 'Necklaces', 'Rings', 'HandBags'],
                          'Shoes': ['Sneakers', 'Sandals', 'Boots'],
                        }[value]!;
                        selectedSubCategory = null; // Reset subcategory when category changes
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Subcategory Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Subcategory'),
                    items: subCategories.map((String subCategory) {
                      return DropdownMenuItem<String>(
                        value: subCategory,
                        child: Text(subCategory),
                      );
                    }).toList(),
                    onChanged: selectedCategory == null
                        ? null // Disable dropdown if no category is selected
                        : (value) {
                            setState(() {
                              selectedSubCategory = value;
                            });
                          },
                    value: selectedSubCategory,
                    disabledHint: const Text('Select a category first'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedCategory != null && selectedSubCategory != null) {
                      setState(() {
                        _items.add(imageFile); // Add the image to the items list
                      });
                      Navigator.pop(context); // Close the dialog
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select both category and subcategory.')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _addItem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _items.add(File(pickedFile.path)); // Add the selected image to the list
      });
    }
  }
}