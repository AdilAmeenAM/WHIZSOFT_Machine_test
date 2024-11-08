import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_text_field_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/controller/chat_controller.dart';

class ChatPage extends HookConsumerWidget {
  static const routePath = "/chat";

  final UserModel user;

  const ChatPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();

    // send messages
    void onSendMessagePressed() async {
      final message = messageController.text;
      if (message.isEmpty) return;

      await ref
          .read(chatControllerProvider.notifier)
          .sendMessage(user.userId, message);
      messageController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(user.email),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: ref.watch(chatMessagesProvider(user.userId)).when(
                  data: (messages) => ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Text(message.message);
                    },
                  ),
                  loading: () => const Text("Loading.."),
                  error: (error, stackTrace) => const Text("Error"),
                ),
          ),

          Row(
            children: [
              // textfield should take up most of the uspace
              Expanded(
                child: AuthTextFieldWidget(
                    hintText: "Type a message",
                    obscureText: false,
                    controller: messageController),
              ),

              // send button
              IconButton(
                  onPressed: onSendMessagePressed,
                  icon: const Icon(Icons.arrow_upward))
            ],
          ),
        ],
      ),
    );
  }
}
