import 'dart:io';
//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

const String USER_COLLECTION = 'Users';

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageService() {}
  Future<String?> saveUserImageToStorage(String _id, PlatformFile _file) async {
    try {
      Reference _ref = _storage.ref().child(
        'images/users/$_id/profile.${_file.extension}',
      );
    } catch (e) {}
  }
}
