import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_text_field_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/controller/chat_controller.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/widgets/message_box_widget.dart';

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
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(user.email),
        centerTitle: true,
        foregroundColor: Colors.grey.shade600,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            // display all messages
            Expanded(
              child: ref.watch(chatMessagesProvider(user.userId)).when(
                    data: (messages) {
                      final currentUserID = AuthService.getCurrentUser()?.uid;

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isCurrentUser =
                              message.senderID == currentUserID;

                          return MessageBoxWidget(
                              isCurrentUser: isCurrentUser,
                              message: message.message);
                        },
                      );
                    },
                    loading: () => const Text("Loading.."),
                    error: (error, stackTrace) => const Text("Error"),
                  ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                children: [
                  // textfield should take up most of the uspace
                  Expanded(
                    child: AuthTextFieldWidget(
                        hintText: "Type a message",
                        obscureText: false,
                        controller: messageController),
                  ),

                  // send button
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                        color: Colors.green.shade300, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: onSendMessagePressed,
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
