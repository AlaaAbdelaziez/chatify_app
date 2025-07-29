//Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/database_service.dart';
import '../services/navigation_service.dart';

//Providers
import '../providers/authentication_provider.dart';

//Models
import '../models/chat_user.dart';
import '../models/chat.dart';

//Pages
import '../pages/chat_page.dart';

class UsersPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;

  late DatabaseService _db;
  late NavigationService _navigation;

  List<ChatUser>? users;

  late List<ChatUser> _selectedUsers;

  List<ChatUser> get selectedUSers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _db = GetIt.instance.get<DatabaseService>();
    _navigation = GetIt.instance.get<NavigationService>();
    getUSers();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getUSers({String? name}) async {
    _selectedUsers = [];
    try {
      _db.getUsers(name: name).then((_snapshot) {
        users = _snapshot.docs.map((_doc) {
          Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
          _data['uid'] = _doc.id;
          return ChatUser.fromJason(_data);
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print('Error getting Users.');
      print(e);
    }
  }

  void updateSelectedUsers(ChatUser _user) {
    if (_selectedUsers.contains(_user)) {
      _selectedUsers.remove(_user);
    } else {
      _selectedUsers.add(_user);
    }
    notifyListeners();
  }
}
