import 'package:allection/screens/auth/login_screen.dart';
import 'package:allection/screens/auth/main_screen.dart';
import 'package:allection/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/login",
    routes: [
      // HomeScreen
      GoRoute(path: '/home', builder: (context, state) => const MainScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
