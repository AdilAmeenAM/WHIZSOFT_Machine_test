import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/controller/auth_controller.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/settings_page.dart';

class CustomDrawerWidget extends ConsumerWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void onLogoutPressed() {
      ref.read(authControllerProvider.notifier).signOut();
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Logo
          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          )),
          // home list tile
          ListTile(
            title: const Text("H O M E"),
            leading: const Icon(Icons.home),
            onTap: () {
              // pop the drawer
              Navigator.pop(context);
            },
          ),
          // settings list tile
          ListTile(
            title: const Text("S E T T I N G S"),
            leading: const Icon(Icons.settings),
            onTap: () {
              // naviagate to settings page
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
          ),
          const Spacer(),
          // logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: onLogoutPressed,
            ),
          )
        ],
      ),
    );
  }
}
