import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/model/message_model.dart';
import 'package:firebase_chat/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatProvider extends ChangeNotifier {
  List<MessageModel>? _messagesList;
  bool _isLoading = false;
  String? _email;

  List<MessageModel>? get messagesList => _messagesList;
  bool get isLoading => _isLoading;

  FirebaseService _firebaseService = FirebaseService();

  void setLoader(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<void>? getMessage() {
    FirebaseFirestore.instance
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      _messagesList =
          event.docs.map((e) => MessageModel.fromJson(e.data())).toList();
      notifyListeners();
    });
  }

  Future<void> sendMessage(MessageModel message) async {
    await _firebaseService.sendMessage(message);
    notifyListeners();
  }

  Future<void> createMessage(String messageText) async {
    MessageModel messageModel = MessageModel(
      message: messageText,
      email: _email,
      time: DateTime.now().toString(),
    );

    await sendMessage(messageModel);
    // await getMessage();
    notifyListeners();
  }
}

final chatProviderNotifier = ChangeNotifierProvider((ref) => ChatProvider());
