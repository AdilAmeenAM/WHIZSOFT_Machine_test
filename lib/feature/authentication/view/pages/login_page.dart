import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/controller/auth_controller.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/pages/register_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_action_btn_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_text_field_widget.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends HookConsumerWidget {
  static const routePath = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

    final isLoading = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    /// Callback to execute when the login button is pressed
    void onLoginPressed() async {
      isLoading.value = true;

      if (formKey.currentState!.validate()) {
        await ref
            .read(authControllerProvider.notifier)
            .login(emailController.text, passwordController.text);
      }

      isLoading.value = false;
    }

    /// Callback to execute when the register link is pressed
    void onRegisterPressed() {
      context.go(RegisterPage.routePath);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo

            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            // welcome back message

            Text(
              "Welcome back ,you have been missed",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),

            const SizedBox(height: 25),
            // email textfield
            AuthTextFieldWidget(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
              validator:
                  ref.read(authControllerProvider.notifier).validateEmail,
            ),
            // password textfield
            const SizedBox(height: 10),
            AuthTextFieldWidget(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
              validator:
                  ref.read(authControllerProvider.notifier).validatePassword,
            ),
            const SizedBox(height: 25),
            // login button
            AuthActionBtnWidget(
              text: "Login",
              isLoading: isLoading.value,
              onTap: onLoginPressed,
            ),

            const SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onRegisterPressed,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
