import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/chat_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/widgets/custom_drawer_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/service/chat_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/widgets/user_tile_widget.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  static const routePath = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Callback to execute when the user click on the user
    void onUserTilePressed(UserModel user) {
      context.go(ChatPage.routePath, extra: user);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        title: const Center(child: Text("Users")),
      ),
      drawer: const CustomDrawerWidget(),
      body: StreamBuilder(
          stream: ChatService.getUsersStream(),
          builder: (context, snapshot) {
            // error
            if (snapshot.hasError) {
              return const Text("Error");
            }

            // loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading..");
            }

            final usersList = snapshot.data!
                .where(
                    (user) => user.email != AuthService.getCurrentUser()!.email)
                .toList();

            return ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                final user = usersList[index];

                return UserTileWidget(
                  text: user.email,
                  onTap: () => onUserTilePressed(user),
                );
              },
            );
          }),
    );
  }
}
