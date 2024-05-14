
// ignore_for_file: avoid_print

import 'package:image_picker/image_picker.dart';

Future<String?> pickedVideo() async {
  final picker = ImagePicker();
  XFile? videoFile;
  try {
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile?.path;
  } catch (e) {
    print('Error During Picking Video: $e');
    return null;
  }
}
