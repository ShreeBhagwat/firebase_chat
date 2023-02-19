import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _email;
  String? _password;
  String? _name;
  UserCredential? _userCredential;

  bool get isLoading => _isLoading;
  String? get email => _email;
  String? get password => _password;
  String? get name => _name;
  UserCredential? get userCredential => _userCredential;

  FirebaseService _firebaseService = FirebaseService();

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setLoader(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future loginUser() async {
    setLoader(true);
    _userCredential =
        await _firebaseService.loginWithEmailAndPassword(_email!, _password!);
    // await getUserDataFromFirebase();
    setLoader(false);
  }

  Future signUpUser() async {
    setLoader(true);
    _userCredential =
        await _firebaseService.signUpWithEmailAndPassword(_email!, _password!);
    await addUsersDataToFirebase();
    setLoader(false);
  }

  Future addUsersDataToFirebase() async {
    await _firebaseService.addUsersData(
        _userCredential!.user!.uid, _name!, _email!);
    setLoader(false);
  }

  Future getUserDataFromFirebase() async {
    await _firebaseService.getUserData(_userCredential!.user!.uid);
    setLoader(false);
  }

  Future signOut() async {
    await _firebaseService.signOut();
    setLoader(false);
  }
}

final authProviderNotifier = ChangeNotifierProvider((ref) => AuthProvider());
