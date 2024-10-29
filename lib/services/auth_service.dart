import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthExeption implements Exception {
  String message;

  AuthExeption({required this.message});
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthExeption(message: 'A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthExeption(message: 'este email já esta cadastrado');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthExeption(message: 'Email não encontrado. cadastre-se');
      } else if (e.code == 'wrong-password') {
        throw AuthExeption(message: 'senha incorreta. Texte novamente');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
