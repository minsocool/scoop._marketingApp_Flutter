import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends ChangeNotifier {
  File? pathImage;
  final _picker = ImagePicker();
  Future<void> pickImageFromGallery() async {
    final PickedFile? _pickedFile =
        await _picker.getImage(source: ImageSource.gallery);

    pathImage = File(_pickedFile!.path);
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final PickedFile? _pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    pathImage = File(_pickedFile!.path);
    notifyListeners();
  }
}
