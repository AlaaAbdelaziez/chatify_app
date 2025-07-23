//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryStorageService {
  final String cloudName = 'dciujuzks';

  Future<String?> _uploadImage(
    PlatformFile _file,
    String _preset,
    String? _id,
  ) async {
    final uri = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    var request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = _preset;

    if (_id != null) {
      request.fields['public_id'] = _id;
    }
    request.files.add(await http.MultipartFile.fromPath('file', _file.path!));
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var jsonData = json.decode(responseData.body);
      return jsonData['secure_url'];
    } else {
      print("Upload failed: ${response.statusCode}");
      return null;
    }
  }

  Future<String?> uploadUserImage(PlatformFile _file, String _id) {
    return _uploadImage(_file, 'user_images', 'users/$_id/profile');
  }

  Future<String?> uploadChatImage(
    PlatformFile _file,
    String _userId,
    String _chatId,
  ) {
    return _uploadImage(
      _file,
      'chat_images',
      'chats/$_chatId/$_userId/${Timestamp.now().millisecondsSinceEpoch}.${_file.extension}',
    );
  }
}
