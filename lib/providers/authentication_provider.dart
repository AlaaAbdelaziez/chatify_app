//Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/database_service.dart';
import '../services/navigation_service.dart';

//Models
import 'package:chatify_app/models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    //_auth.signOut();
    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        print('Logged in');
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then((_snapshot) {
          Map<String, dynamic> _userData =
              _snapshot.data()! as Map<String, dynamic>;
          user = ChatUser.fromJason({
            'uid': _user.uid,
            "name": _userData['name'],
            "email": _userData['email'],
            "image": _userData['image'],
            "last_active": _userData['last_active'],
          });
          _navigationService.removeAndNavigateToRoute('/home');
        });
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }

  Future<void> loginWithEmailAndPassword(
    String _email,
    String _password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print(_auth.currentUser);
    } on FirebaseException {
      print('Error logging user into Firebase');
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
    String _email,
    String _password,
    // String _name,
  ) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      return _credentials.user!.uid;
    } on FirebaseAuthException {
      print('Error register user');
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
