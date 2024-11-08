import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/widgets/custom_drawer_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/service/chat_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/chat_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/widgets/user_tile_widget.dart';

class HomePage extends StatelessWidget {
  static const routePath = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        title: const Center(child: Text("Home")),
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
            // return list view
            return ListView(
              children: snapshot.data!.map(
                (userData) {
                  if (userData["email"] != AuthService.getCurrentUser()) {
                    return UserTileWidget(
                      text: userData["email"],
                      onTap: () {
                        // tapped on a user -> go to chat page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ChatPage(
                              receiverEmail: userData["email"],
                              receiverID: userData["uid"],
                            );
                          },
                        ));
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ).toList(),
            );
          }),
    );
  }
}
