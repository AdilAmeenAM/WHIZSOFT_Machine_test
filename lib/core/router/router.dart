import 'package:go_router/go_router.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/pages/login_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/view/pages/register_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/chat_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/home_page.dart';
import 'package:whizsoft_chat_app_machine_test/main.dart';

final router = GoRouter(
  navigatorKey: App.navigatorKey,
  initialLocation: LoginPage.routePath,
  routes: [
    GoRoute(
      path: LoginPage.routePath,
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) {
        if (AuthService.getCurrentUser() != null) {
          return HomePage.routePath;
        }

        return null;
      },
    ),
    GoRoute(
      path: RegisterPage.routePath,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: HomePage.routePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: ChatPage.routePath,
      builder: (context, state) {
        return ChatPage(
          user: state as UserModel,
        );
      },
    ),
  ],
);
