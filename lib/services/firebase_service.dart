import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/model/message_model.dart';

import '../model/users_model.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> addUsersData(String id, String name, String email) async {
    await _firestore.collection('users').doc(id).set({
      'id': id,
      'name': name,
      'email': email,
      'createOn': DateTime.now().toString(),
      'isOnline': true,
    }).catchError((e) {
      log(e);
    });
  }

  Future<UserModel?> getUserData(String id) async {
    await _firestore.collection('users').doc(id).get().then((value) {
      return UserModel.fromJson(value.data()!);
    }).catchError((e) {
      // return Future.error(e);
    });
  }

  Future<void> sendMessage(MessageModel message) async {
    await _firestore.collection('messages').add(message.toJson());
  }


}
