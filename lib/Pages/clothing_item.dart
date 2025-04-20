// ignore_for_file: unused_import

import 'dart:convert';

class ClothingItem {
  final String imagePath;
  final String category; // e.g., Tops
  final String subcategory; // e.g., T-Shirts

  ClothingItem({
    required this.imagePath,
    required this.category,
    required this.subcategory,
  });

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'category': category,
    'subcategory': subcategory,
  };

  factory ClothingItem.fromJson(Map<String, dynamic> json) => ClothingItem(
    imagePath: json['imagePath'],
    category: json['category'],
    subcategory: json['subcategory'],
  );
}
