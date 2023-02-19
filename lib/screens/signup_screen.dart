import 'package:firebase_chat/extensions/build_context_extentions.dart';
import 'package:firebase_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';
import '../validators.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loader_button.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authProviderNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: kButtonTextStyle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                CustomTextField(
                  icon: Icons.person,
                  hintText: 'Name',
                  controller: _nameController,
                  validatorFunction: (value) => Validators.required(value!),
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
                      buttonTitle: 'Sign Up',
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        } else {
                          authProvider.setEmail(_emailController.text);
                          authProvider.setPassword(_passwordController.text);
                          authProvider.setName(_nameController.text);
                          await authProvider.signUpUser().then((value) async {
                            await ref.read(chatProviderNotifier).getMessage();
                            context.navigateToScreen(
                                screen: ChatScreen(), isReplace: true);
                          });
                        }
                      }),
                ),
                CustomTextButton(
                  text: 'Already a member? Login',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center CustomLoader(AuthProvider authProvider) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: authProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox.shrink(),
      ),
    );
  }
}
