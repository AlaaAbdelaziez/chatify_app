//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

const String USER_COLLECTION = "Users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "Messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService() {}
  Future<DocumentSnapshot> getUser(String _id) async {
    return _db.collection(USER_COLLECTION).doc(_id).get();
  }

  Future<void> updateUserLastSeenTime(String _id) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_id).update({
        'last_active': DateTime.now().toUtc(),
      });
    } catch (e) {
      print(e);
    }
  }
}
