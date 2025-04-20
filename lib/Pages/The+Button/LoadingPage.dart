import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/The+Button/ConfirmPhotoPage.dart';

class LoadingPage extends StatefulWidget {
  final File imageFile;

  const LoadingPage({super.key, required this.imageFile});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _simulateAIAnalysis();
  }

  Future<void> _simulateAIAnalysis() async {
    await Future.delayed(const Duration(seconds: 3)); // simulate AI
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmPhotoPage(imageFile: widget.imageFile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
