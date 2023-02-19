import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const FirebaseChat()));
}

class FirebaseChat extends StatelessWidget {
  const FirebaseChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Firebase Chat', home: LoginScreen());
  }
}
