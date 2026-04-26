import 'package:doaa_gado/features/auth/presentation/pages/login_page.dart';
import 'package:doaa_gado/features/auth/presentation/pages/register_page.dart';
import 'package:doaa_gado/features/home/presentation/pages/main_nav_page.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
//     GoRoute(
//       path: AppRoutes.splash,
//       name: AppRouteNames.splash,
//       builder: (context, state) => const SplashView(),
//     ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRouteNames.home,
      builder: (context, state) => const MainNavPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: AppRouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      name: AppRouteNames.signUp,
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
