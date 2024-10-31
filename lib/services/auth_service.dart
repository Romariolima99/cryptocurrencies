import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;

  AuthException({required this.message});
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
      this.user = user;
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
        throw AuthException(message: 'A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(message: 'Este email já está cadastrado');
      } else {
        throw AuthException(
            message: 'Ocorreu um erro inesperado. Tente novamente.');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(message: 'Email não encontrado. Cadastre-se.');
      } else if (e.code == 'invalid-credential') {
        throw AuthException(
            message:
                'Email não encontrado ou Senha incorreta. Tente novamente.');
      } else {
        throw AuthException(
            message: 'Ocorreu um erro inesperado. Tente novamente.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
