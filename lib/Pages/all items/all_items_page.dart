// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_application_1/Pages/all%20items/item_details_page.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Tops/tops.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Bottoms/bottoms.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Accessories/accessories.dart';
import 'package:flutter_application_1/Pages/all%20items/catagories/Shoes/shoes.dart';
import 'package:flutter_application_1/Pages/clothing_item.dart';
import 'package:flutter_application_1/Pages/clothing_storage.dart';

class AllItemsPage extends StatefulWidget {
  final List<File> items;
  final List<File> tops;
  final List<File> bottoms;
  final List<File> accessories;
  final List<File> shoes;

  const AllItemsPage({
    super.key,
    required this.items,
    required this.tops,
    required this.bottoms,
    required this.accessories,
    required this.shoes,
  });

  @override
  State<AllItemsPage> createState() => _AllItemsPageState();
}

class _AllItemsPageState extends State<AllItemsPage> {
  final Map<String, bool> _isEditingMap = {}; // Tracks editing state for each category
  final Set<int> _selectedItems = {}; // Tracks selected items for deletion
  bool _isUniversalEditing = false; // Tracks universal edit mode

  List<ClothingItem> allItems = [];
  List<ClothingItem> tops = [];
  List<ClothingItem> tShirts = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    // Load all items from ClothingStorage
    allItems = await ClothingStorage.loadItems();

    // Filter items into categories and subcategories
    setState(() {
      tops = allItems.where((item) => item.category == 'Tops').toList();
      tShirts = tops.where((item) => item.subcategory == 'T-Shirts').toList();
    });
  }

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
          'All Items',
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
              width: 36, // Adjusted width
              height: 36, // Adjusted height
              child: IconButton(
                icon: Icon(
                  _isUniversalEditing ? Icons.delete : Icons.edit,
                  color: Colors.black,
                  size: 20, // Adjusted icon size
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
              // Tops Section
              _buildCategorySection(
                'Tops',
                tops.map((item) => File(item.imagePath)).toList(),
                TopsPage(
                  tops: widget.tops,
                  tShirts: tShirts.map((item) => File(item.imagePath)).toList(),
                  shirts: [],
                  longSleeves: [],
                ),
              ),
              const SizedBox(height: 16),

              // Bottoms Section
              _buildCategorySection(
                'Bottoms',
                widget.bottoms,
                BottomsPage(
                  bottoms: widget.bottoms,
                  jeans: [],
                  shorts: [],
                  joggers: [],
                ),
              ),
              const SizedBox(height: 16),

              // Accessories Section
              _buildCategorySection(
                'Accessories',
                widget.accessories,
                AccessoriesPage(
                  accessories: widget.accessories,
                  bracelets: [],
                  handBags: [],
                  rings: [],
                  necklaces: [],
                ),
              ),
              const SizedBox(height: 16),

              // Shoes Section
              _buildCategorySection(
                'Shoes',
                widget.shoes,
                ShoesPage(
                  shoes: widget.shoes,
                  sneakers: [],
                  sandals: [],
                  highKneels: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<File> items, Widget destinationPage) {
    final isEditing = _isUniversalEditing || (_isEditingMap[categoryName] ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the related page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destinationPage),
                );
              },
              child: Text(
                categoryName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
                color: const Color.fromARGB(255, 255, 255, 255), // Placeholder for items
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
                          : () {
                              // Handle item click (e.g., navigate to details page)
                            },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              items[index],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              color: isSelected
                                  ? Colors.black.withOpacity(0.5)
                                  : null,
                              colorBlendMode: isSelected
                                  ? BlendMode.darken
                                  : null,
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