import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whizsoft_chat_app_machine_test/core/theme/theme_controller.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/home_page.dart';

class SettingsPage extends ConsumerWidget {
  static const routePath = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeController = ref.watch(themeControllerProvider);
    final isDarkMode = themeController.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(HomePage.routePath);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Settings"),
        centerTitle: true,
        foregroundColor: Colors.grey,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Mode"),
            CupertinoSwitch(
              value: isDarkMode,
              onChanged: (value) {
                ref.read(themeControllerProvider.notifier).toggleTheme();
              },
            )
          ],
        ),
      ),
    );
  }
}
