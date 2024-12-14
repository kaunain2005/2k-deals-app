import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';  // Updated ML Kit Plugin

class ProductDetectionPage extends StatefulWidget {
  @override
  _ProductDetectionPageState createState() => _ProductDetectionPageState();
}

class _ProductDetectionPageState extends State<ProductDetectionPage> {
  File? _image;
  String _detectedProduct = '';

  // Method to pick an image using the camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _runProductDetection(File(image.path));
    }
  }

  // Run product detection using the new ML Kit's Image Labeling API
  Future<void> _runProductDetection(File imageFile) async {
    final InputImage inputImage = InputImage.fromFile(imageFile);

    // Initialize the ImageLabeler with default options
    final ImageLabelerOptions options = ImageLabelerOptions(confidenceThreshold: 0.5); // Adjust confidence threshold as needed
    final ImageLabeler labeler = ImageLabeler(options: options);

    final List<ImageLabel> labels = await labeler.processImage(inputImage);

    if (labels.isNotEmpty) {
      setState(() {
        _detectedProduct = labels[0].label; // Take the most confident label
      });
    } else {
      setState(() {
        _detectedProduct = 'No product detected';
      });
    }

    // Close the labeler after use
    labeler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detection"),
      ),
      body: Column(
        children: [
          if (_image != null)
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(height: 20),
          Text(
            _detectedProduct.isNotEmpty ? 'Detected Product: $_detectedProduct' : 'No product detected',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text("Capture Image"),
          ),
        ],
      ),
    );
  }
}
