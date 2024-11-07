import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/core/theme/light_theme.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/service/auth_gate.dart';
import 'package:whizsoft_chat_app_machine_test/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      home: const AuthGate(),
    );
  }
}
