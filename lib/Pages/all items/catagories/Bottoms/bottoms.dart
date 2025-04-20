// ignore_for_file: deprecated_member_use, unused_element

import 'package:flutter/material.dart';
import 'dart:io';

class BottomsPage extends StatefulWidget {
  final List<File> jeans;
  final List<File> shorts;
  final List<File> joggers;

  const BottomsPage({
    super.key,
    required this.jeans,
    required this.shorts,
    required this.joggers, required List<File> bottoms,
  });

  @override
  State<BottomsPage> createState() => _BottomsPageState();
}

class _BottomsPageState extends State<BottomsPage> {
  final Map<String, bool> _isEditingMap = {}; // Tracks editing state for each category
  final Set<int> _selectedItems = {}; // Tracks selected items for deletion
  bool _isUniversalEditing = false; // Tracks universal edit mode

  void _toggleEditMode(String categoryName) {
    setState(() {
      _isEditingMap[categoryName] = !(_isEditingMap[categoryName] ?? false);
      _selectedItems.clear(); // Clear selections when toggling modes
    });
  }

  void _toggleUniversalEditMode() {
    setState(() {
      _isUniversalEditing = !_isUniversalEditing;
      _isEditingMap.clear(); // Clear individual edit states
      _selectedItems.clear(); // Clear selections
    });
  }

  void _deleteSelectedItems(String categoryName, List<File> items) {
    setState(() {
      items.removeWhere((file) => _selectedItems.contains(items.indexOf(file)));
      _selectedItems.clear();
      _isEditingMap[categoryName] = false; // Exit edit mode after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button color set to white
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text(
          'Bottoms',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.black, // Set background color to black
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: SizedBox(
              width: 36,
              height: 36,
              child: IconButton(
                icon: Icon(
                  _isUniversalEditing ? Icons.delete : Icons.edit,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: _toggleUniversalEditMode,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Jeans Section
              _buildCategorySection('Jeans', widget.jeans),
              const SizedBox(height: 16),

              // Shorts Section
              _buildCategorySection('Shorts', widget.shorts),
              const SizedBox(height: 16),

              // Joggers Section
              _buildCategorySection('Joggers', widget.joggers),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Handle edit mode
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Container(
                height: 150,
                color: Colors.grey[200],
                child: const Center(
                  child: Text('No items to display'),
                ),
              )
            : SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        items[index],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}

