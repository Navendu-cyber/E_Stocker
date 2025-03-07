import 'package:image_picker/image_picker.dart';

Future<String?> pickimage() async {
  try {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedImage?.path;
  } catch (e) {
    print('Error picking image: $e');
    return null;
  }
}
