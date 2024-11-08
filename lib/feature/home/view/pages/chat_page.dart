import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_text_field_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/service/chat_service.dart';

class ChatPage extends HookWidget {
  static const routePath = "/chat";

  final UserModel user;

  const ChatPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final senderID = AuthService.getCurrentUser()!.uid;
    final messageController = useTextEditingController();

    // send messages
    void onSendMessagePressed() async {}

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(user.email),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
              child: StreamBuilder(
            stream: ChatService.getMessages(user.userId, senderID),
            builder: (context, snapshot) {
              // errors
              if (snapshot.hasError) {
                return const Text("Error");
              }
              // loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading..");
              }
              // return the list view
              return ListView(
                children: snapshot.data!.docs
                    .map(
                      (doc) => Text(
                        (doc.data() as Map)["message"],
                      ),
                    )
                    .toList(),
              );
            },
          )),

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
