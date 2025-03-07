import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerWidget extends StatefulWidget {
  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  File? _selectedFile;
  String? _fileType;

  final ImagePicker _imagePicker = ImagePicker();

  /// Function to pick an image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _imagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedFile = File(image.path);
        _fileType = "Image";
      });
    }
  }

  /// Function to pick any file (PDF, DOC, etc.)
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileType = "File";
      });
    }
  }

  /// Show dialog to choose between Image or File selection
  void _showFilePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose File Type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Select Image"),
                onTap: () {
                  Navigator.pop(context);
                  _showImagePickerDialog();
                },
              ),
              ListTile(
                leading: Icon(Icons.file_present),
                title: Text("Select File (PDF, DOC, etc.)"),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Show dialog to choose between Camera or Gallery for Images
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectedFile != null
            ? Column(
                children: [
                  _fileType == "Image"
                      ? Image.file(_selectedFile!, height: 150)
                      : Icon(Icons.insert_drive_file, size: 50),
                  Text("Selected: ${_selectedFile!.path.split('/').last}"),
                ],
              )
            : Text("No File Selected"),
        ElevatedButton(
          onPressed: _showFilePickerDialog,
          child: Text("Pick File or Image"),
        ),
      ],
    );
  }
}
