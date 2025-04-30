// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Outfits/OutfitpageDyn.dart';
import 'dart:io';

import 'Catagories/Summer.dart';
import 'Catagories/Winter.dart';
import 'Catagories/Fall.dart';
import 'Catagories/Spring.dart';

class AllOutfitsPage extends StatefulWidget {
  final List<File> summerOutfits;
  final List<File> winterOutfits;
  final List<File> fallOutfits;
  final List<File> springOutfits;

  const AllOutfitsPage({
    super.key,
    required this.summerOutfits,
    required this.winterOutfits,
    required this.fallOutfits,
    required this.springOutfits, required List<File> outfits,
  });

  @override
  State<AllOutfitsPage> createState() => _AllOutfitsPageState();
}

class _AllOutfitsPageState extends State<AllOutfitsPage> {
  final Map<String, bool> _isEditingMap = {};
  final Set<int> _selectedItems = {};
  bool _isUniversalEditing = false;

  void _toggleEditMode(String categoryName) {
    setState(() {
      _isEditingMap[categoryName] = !(_isEditingMap[categoryName] ?? false);
      _selectedItems.clear();
    });
  }

  void _toggleUniversalEditMode() {
    setState(() {
      _isUniversalEditing = !_isUniversalEditing;
      _isEditingMap.clear();
      _selectedItems.clear();
    });
  }

  void _deleteSelectedItems(String categoryName, List<File> items) {
    setState(() {
      items.removeWhere((file) => _selectedItems.contains(items.indexOf(file)));
      _selectedItems.clear();
      _isEditingMap[categoryName] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('All Outfits'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: theme.iconTheme.color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: SizedBox(
              width: 36,
              height: 36,
              child: IconButton(
                icon: Icon(
                  _isUniversalEditing ? Icons.delete : Icons.edit,
                  color: theme.primaryColor,
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
              _buildCategorySection('Summer', widget.summerOutfits),
              const SizedBox(height: 16),
              _buildCategorySection('Winter', widget.winterOutfits),
              const SizedBox(height: 16),
              _buildCategorySection('Fall', widget.fallOutfits),
              const SizedBox(height: 16),
              _buildCategorySection('Spring', widget.springOutfits),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items) {
    final theme = Theme.of(context);
    final isEditing = _isUniversalEditing || (_isEditingMap[categoryName] ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OutfitCategoryPage(
                      categoryName: categoryName, // Pass the category name dynamically
                      outfits: items,
                    ),
                  ),
                );
              },
              child: Text(
                categoryName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.iconTheme.color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: IconButton(
                icon: Icon(isEditing ? Icons.delete : Icons.edit),
                onPressed: isEditing
                    ? () => _deleteSelectedItems(categoryName, items)
                    : () => _toggleEditMode(categoryName),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        items.isEmpty
            ? Container(
                height: 150,
                color: theme.scaffoldBackgroundColor,
                child: const Center(
                  child: Text('No outfits to display'),
                ),
              )
            : SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedItems.contains(index);
                    return GestureDetector(
                      onTap: isEditing
                          ? () {
                              setState(() {
                                if (isSelected) {
                                  _selectedItems.remove(index);
                                } else {
                                  _selectedItems.add(index);
                                }
                              });
                            }
                          : () {},
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              items[index],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              color: isSelected ? theme.primaryColor.withOpacity(0.5) : null,
                              colorBlendMode: isSelected ? BlendMode.darken : null,
                            ),
                          ),
                          if (isSelected)
                            const Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}