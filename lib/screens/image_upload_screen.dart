import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image/image.dart' as img;


class ImageUploadScreen extends StatefulWidget {
  final Function(String imageUrl) onImageUploaded;

  ImageUploadScreen({required this.onImageUploaded});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      print('Image selected: ${pickedFile.path}');
    } else {
      print('No image selected');
    }
  }



  Future<void> _uploadImage(BuildContext context) async {
    if (_image == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Resize image before upload
      img.Image? image = img.decodeImage(_image!.readAsBytesSync());
      img.Image resized = img.copyResize(image!, width: 600);

      // Save the resized image to a new file
      File resizedFile = File('${_image!.parent.path}/resized_${_image!.uri.pathSegments.last}');
      resizedFile.writeAsBytesSync(img.encodeJpg(resized));

      // Create a unique name for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');

      // Create the upload task
      UploadTask uploadTask = storageRef.putFile(resizedFile);


      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      }, onError: (e) {
        print('Error during upload: $e');
        // You can add retry logic here if desired
      });

      TaskSnapshot snapshot = await uploadTask;
      print('Upload complete: ${snapshot.ref.fullPath}');


      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Callback to return the uploaded image URL
      widget.onImageUploaded(downloadUrl);
      Navigator.pop(context, downloadUrl);
      print('Image uploaded: $downloadUrl');
    } catch (e) {
      print('Error uploading: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : Icon(Icons.image, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 10),
            if (_isUploading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => _uploadImage(context),
                child: Text('Upload Image'),
              ),
          ],
        ),
      ),
    );
  }
}
