import 'package:firebase_chat/extensions/build_context_extentions.dart';
import 'package:firebase_chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../providers/auth_provider.dart';

class ChatBubbleWidget extends ConsumerWidget {
  const ChatBubbleWidget({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(authProviderNotifier).email;
    final isMe = email == messageModel.email;
    return Row(
      children: [
        isMe ? const Spacer() : const SizedBox.shrink(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.getWidth(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messageModel.email ?? '',
                    style: kSubtitleTextStyle.copyWith(fontSize: 10),
                  ),
                  Text(messageModel.message!, style: kBodyTextStyle),
                ],
              ),
            ),
          ),
        ),
        !isMe ? const Spacer() : const SizedBox.shrink(),
      ],
    );
  }
}
