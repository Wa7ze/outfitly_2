import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/The+Button/LoadingPage.dart';
import 'package:image_picker/image_picker.dart';


class AddItemOptionsPage extends StatelessWidget {
  const AddItemOptionsPage({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoadingPage(imageFile: File(pickedFile.path)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Item"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () => _pickImage(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Library"),
            onTap: () => _pickImage(context, ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}
