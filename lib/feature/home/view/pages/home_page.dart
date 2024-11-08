import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/widgets/custom_drawer_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/service/chat_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/chat_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/widgets/user_tile_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authServices = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        title: const Center(child: Text("Home")),
      ),
      drawer: const CustomDrawerWidget(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
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
                return _buildUserListItem(userData, context);
              },
            ).toList(),
          );
        });
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData["email"] != _authServices.getCurrentUser()) {
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
  }
}
