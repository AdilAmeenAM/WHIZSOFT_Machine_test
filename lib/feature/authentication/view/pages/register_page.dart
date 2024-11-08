import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/controller/auth_controller.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/pages/login_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_action_btn_widget.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/widgets/auth_text_field_widget.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends HookConsumerWidget {
  static const routePath = '/register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final isLoading = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    /// A callback to execute when the register button is pressed
    void onRegisterPressed() async {
      isLoading.value = true;

      if (formKey.currentState!.validate()) {
        await ref
            .read(authControllerProvider.notifier)
            .register(emailController.text, passwordController.text);
      }

      isLoading.value = false;
    }

    /// A callback to execute when the login link is pressed
    void onLoginPressed() {
      context.go(LoginPage.routePath);
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
              "Let's create an account for you",
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
            // confirm password textfield
            const SizedBox(height: 10),
            AuthTextFieldWidget(
              controller: confirmPasswordController,
              hintText: "Confirm password",
              obscureText: true,
              validator: (value) => ref
                  .read(authControllerProvider.notifier)
                  .validateConfirmPassword(value, passwordController.text),
            ),
            const SizedBox(height: 25),
            // login button
            AuthActionBtnWidget(
              text: "Register",
              isLoading: isLoading.value,
              onTap: onRegisterPressed,
            ),

            const SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onLoginPressed,
                  child: Text(
                    "Login now",
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
