//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

const String USER_COLLECTION = "Users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService() {}
  Future<void> CreateUser(
    String _uid,
    String _email,
    String _name,
    String _imageUrl,
  ) async {
    try {
      await _db.collection(USER_COLLECTION).doc(_uid).set({
        'email': _email,
        'name': _name,
        'image': _imageUrl,
        'last_active': DateTime.now().toUtc(),
      });
    } catch (e) {}
  }

  Future<DocumentSnapshot> getUser(String _id) async {
    return _db.collection(USER_COLLECTION).doc(_id).get();
  }

  Stream<QuerySnapshot> getChatsForUSer(String _id) {
    return _db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: _id)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy('sent_time', descending: true)
        .limit(1)
        .get();
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

  Future<void> saveImageUrl(String _id, String _imageUrl) async {
    await _db.collection(USER_COLLECTION).doc(_id).set({
      'image': _imageUrl,
    }, SetOptions(merge: true));
  }
}
