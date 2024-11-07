import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        title: const Center(child: Text("Home")),
        actions: [
          //  logout button
          IconButton(icon: const Icon(Icons.logout), onPressed: logout)
        ],
      ),
      drawer: const Drawer(),
    );
  }
}
