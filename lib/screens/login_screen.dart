import 'dart:developer';

import 'package:firebase_chat/constants.dart';
import 'package:firebase_chat/extensions/build_context_extentions.dart';
import 'package:firebase_chat/providers/auth_provider.dart';
import 'package:firebase_chat/screens/signup_screen.dart';
import 'package:firebase_chat/validators.dart';
import 'package:firebase_chat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/chat_provider.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/loader_button.dart';
import 'chat_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authProviderNotifier);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Firebase Chat', style: kTitleTextStyle),
                ),
                CustomTextField(
                  icon: Icons.email,
                  hintText: 'Email',
                  controller: _emailController,
                  validatorFunction: (value) =>
                      Validators.validateEmail(value!),
                ),
                CustomTextField(
                  icon: Icons.lock,
                  hintText: 'Password',
                  controller: _passwordController,
                  validatorFunction: (value) =>
                      Validators.validatePassword(value!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoaderButton(
                    isLoading: authProvider.isLoading,
                    buttonTitle: 'Login',
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      } else {
                        authProvider.setEmail(_emailController.text);
                        authProvider.setPassword(_passwordController.text);
                        await authProvider.loginUser().then((value) async{
                         await ref.read(chatProviderNotifier).getMessage();
                          context.navigateToScreen(
                              screen: ChatScreen(), isReplace: true);
                        });
                      }
                    },
                  ),
                ),
                CustomTextButton(
                  text: 'Not a member? Sign Up',
                  onPressed: () {
                    context.navigateToScreen(screen: SignUpScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
