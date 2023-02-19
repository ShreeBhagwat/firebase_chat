import 'package:firebase_chat/extensions/build_context_extentions.dart';
import 'package:firebase_chat/providers/auth_provider.dart';
import 'package:firebase_chat/screens/login_screen.dart';
import 'package:firebase_chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../providers/chat_provider.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({super.key});

  TextEditingController chatController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatProvider = ref.watch(chatProviderNotifier);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Screen'),
          actions: [
            IconButton(
                onPressed: () async {
                  await ref.read(authProviderNotifier).signOut();
                  context.navigateToScreen(
                      screen: LoginScreen(), isReplace: true);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: chatProvider.messagesList != null
                    ? ListView.builder(
                        reverse: true,
                        itemCount: chatProvider.messagesList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ChatBubbleWidget(
                                  messageModel:
                                      chatProvider.messagesList![index]));
                        })
                    : Container()),
            Container(
              height: 70,
              width: context.getWidth(1.0),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: context.getWidth(0.8),
                      height: 50,
                      child: TextField(
                        controller: chatController,
                        decoration: InputDecoration(
                            enabled: true,
                            filled: true,
                            hintText: 'Message ..',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (chatController.text.isNotEmpty) {
                            chatProvider.setEmail(
                                ref.read(authProviderNotifier).email!);
                            await chatProvider
                                .createMessage(chatController.text);
                            chatController.clear();
                          } else {
                            return;
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
