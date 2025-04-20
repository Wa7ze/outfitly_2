import 'package:flutter/material.dart';
import 'dart:io';

class ItemDetailsPage extends StatelessWidget {
  final File item; // The selected item to display

  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Image.file(
          item,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}