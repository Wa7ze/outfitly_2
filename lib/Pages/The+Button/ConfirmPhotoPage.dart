import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/The+Button/ItemDetailsFormPage.dart';
// Removed duplicate import to avoid conflict

class ConfirmPhotoPage extends StatelessWidget {
  final File imageFile;

  const ConfirmPhotoPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Your Item")),
      body: Column(
        children: [
          Expanded(child: Image.file(imageFile)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text("Use Photo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ItemDetailsFormPage(
                        imageFile: imageFile,
                        items: [], // Provide appropriate value
                        tops: [], // Provide appropriate value
                        tShirts: [], // Provide appropriate value
                        shirts: [], // Provide appropriate value
                        longSleeves: [], // Provide appropriate value
                        bottoms: [], // Provide appropriate value
                        jeans: [], // Provide appropriate value
                        shorts: [], // Provide appropriate value
                        joggers: [], // Provide appropriate value
                        accessories: [], // Provide appropriate value
                        bracelets: [], // Provide appropriate value
                        necklaces: [], // Provide appropriate value
                        rings: [], // Provide appropriate value
                        handBags: [], // Provide appropriate value
                        shoes: [], // Provide appropriate value
                        sneakers: [], // Provide appropriate value
                        sandals: [], // Provide appropriate value
                        boots: [], // Provide appropriate value
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text("Retake"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
