import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/clothing_item.dart';
import 'package:flutter_application_1/Pages/clothing_storage.dart';

class ItemDetailsFormPage extends StatefulWidget {
  final File imageFile;

  final List<File> items;
  final List<File> tops;
  final List<File> tShirts;
  final List<File> shirts;
  final List<File> longSleeves;
  final List<File> bottoms;
  final List<File> jeans;
  final List<File> shorts;
  final List<File> joggers;
  final List<File> accessories;
  final List<File> bracelets;
  final List<File> necklaces;
  final List<File> rings;
  final List<File> handBags;
  final List<File> shoes;
  final List<File> sneakers;
  final List<File> sandals;
  final List<File> boots;

  const ItemDetailsFormPage({
    super.key,
    required this.imageFile,
    required this.items,
    required this.tops,
    required this.tShirts,
    required this.shirts,
    required this.longSleeves,
    required this.bottoms,
    required this.jeans,
    required this.shorts,
    required this.joggers,
    required this.accessories,
    required this.bracelets,
    required this.necklaces,
    required this.rings,
    required this.handBags,
    required this.shoes,
    required this.sneakers,
    required this.sandals,
    required this.boots,
  });

  @override
  State<ItemDetailsFormPage> createState() => _ItemDetailsFormPageState();
}

class _ItemDetailsFormPageState extends State<ItemDetailsFormPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> itemData = {
    'name': '',
    'category': '',
    'subcategory': '',
    'color': '',
    'size': '',
    'material': '',
    'occasion': '',
    'condition': '',
    'brand': '',
    'price': '',
    'location': '',
  };

  List<String> subCategories = []; // List to hold subcategories based on the selected main category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.file(widget.imageFile),
              const SizedBox(height: 10),
              _buildTextField("Name", "name"),
              _buildMainCategoryDropdown(),
              _buildSubCategoryDropdown(),
              _buildTextField("Color", "color"),
              _buildTextField("Size", "size"),
              _buildTextField("Material", "material"),
              _buildTextField("Occasion", "occasion"),
              _buildTextField("Condition", "condition"),
              _buildTextField("Brand", "brand"),
              _buildTextField("Price", "price"),
              _buildTextField("Location", "location"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text("Save Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        onChanged: (value) => itemData[key] = value,
      ),
    );
  }

  Widget _buildMainCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(labelText: "Main Category"),
        items: {
          'Tops': ['T-Shirts', 'LongSleeves', 'Shirts'],
          'Bottoms': ['Jeans', 'Shorts', 'Joggers'],
          'Shoes': ['Sneakers', 'Sandals', 'Boots'],
          'Accessories': ['Bracelets', 'Necklaces', 'Rings', 'HandBags'],
        }.keys.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            itemData['category'] = value;
            subCategories = {
              'Tops': ['T-Shirts', 'LongSleeves', 'Shirts'],
              'Bottoms': ['Jeans', 'Shorts', 'Joggers'],
              'Shoes': ['Sneakers', 'Sandals', 'Boots'],
              'Accessories': ['Bracelets', 'Necklaces', 'Rings', 'HandBags'],
            }[value]!;
            itemData['subcategory'] = null; // Reset subcategory when main category changes
          });
        },
      ),
    );
  }

  Widget _buildSubCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(labelText: "Sub-category"),
        items: subCategories.map((String subCategory) {
          return DropdownMenuItem<String>(
            value: subCategory,
            child: Text(subCategory),
          );
        }).toList(),
        onChanged: itemData['category'] == null
            ? null // Disable dropdown if no main category is selected
            : (value) {
                setState(() {
                  itemData['subcategory'] = value;
                });
              },
        value: itemData['subcategory'],
        disabledHint: const Text('Select a main category first'),
      ),
    );
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      // Save the item to its respective category and subcategory
      final File imageFile = widget.imageFile;

      // Add the item to the general items list (Wardrobe Page)
      setState(() {
        widget.items.add(imageFile); // Add to the general items list
      });

      // Add the item to the respective category and subcategory
      if (itemData['category'] == 'Tops') {
        widget.tops.add(imageFile); // Add to Tops in All Items Page

        if (itemData['subcategory'] == 'T-Shirts') {
          widget.tShirts.add(imageFile); // Add to T-Shirts in Tops Page
        } else if (itemData['subcategory'] == 'Shirts') {
          widget.shirts.add(imageFile); // Add to Shirts in Tops Page
        } else if (itemData['subcategory'] == 'LongSleeves') {
          widget.longSleeves.add(imageFile); // Add to LongSleeves in Tops Page
        }
      } else if (itemData['category'] == 'Bottoms') {
        widget.bottoms.add(imageFile); // Add to Bottoms in All Items Page

        if (itemData['subcategory'] == 'Jeans') {
          widget.jeans.add(imageFile); // Add to Jeans in Bottoms Page
        } else if (itemData['subcategory'] == 'Shorts') {
          widget.shorts.add(imageFile); // Add to Shorts in Bottoms Page
        } else if (itemData['subcategory'] == 'Joggers') {
          widget.joggers.add(imageFile); // Add to Joggers in Bottoms Page
        }
      } else if (itemData['category'] == 'Accessories') {
        widget.accessories.add(imageFile); // Add to Accessories in All Items Page

        if (itemData['subcategory'] == 'Bracelets') {
          widget.bracelets.add(imageFile); // Add to Bracelets in Accessories Page
        } else if (itemData['subcategory'] == 'Necklaces') {
          widget.necklaces.add(imageFile); // Add to Necklaces in Accessories Page
        } else if (itemData['subcategory'] == 'Rings') {
          widget.rings.add(imageFile); // Add to Rings in Accessories Page
        } else if (itemData['subcategory'] == 'HandBags') {
          widget.handBags.add(imageFile); // Add to HandBags in Accessories Page
        }
      } else if (itemData['category'] == 'Shoes') {
        widget.shoes.add(imageFile); // Add to Shoes in All Items Page

        if (itemData['subcategory'] == 'Sneakers') {
          widget.sneakers.add(imageFile); // Add to Sneakers in Shoes Page
        } else if (itemData['subcategory'] == 'Sandals') {
          widget.sandals.add(imageFile); // Add to Sandals in Shoes Page
        } else if (itemData['subcategory'] == 'Boots') {
          widget.boots.add(imageFile); // Add to Boots in Shoes Page
        }
      }

      // Save the item using ClothingStorage
      final savedImage = await imageFile.copy('${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await ClothingStorage.saveItem(ClothingItem(
        imagePath: savedImage.path,
        category: itemData['category'],
        subcategory: itemData['subcategory'],
      ));

      // Navigate back to the Wardrobe Page
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
    }
  }
}
