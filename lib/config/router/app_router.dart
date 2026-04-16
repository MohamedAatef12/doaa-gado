import 'package:doaa_gado/features/auth/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
//     GoRoute(
//       path: AppRoutes.splash,
//       name: AppRouteNames.splash,
//       builder: (context, state) => const SplashView(),
//     ),
//     GoRoute(
//       path: AppRoutes.home,
//       name: AppRouteNames.home,
//       builder: (context, state) => const HomeView(),
//     ),
    GoRoute(
      path: AppRoutes.login,
      name: AppRouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
//     GoRoute(
//       path: AppRoutes.otp,
//       name: AppRouteNames.otp,
//       builder: (context, state) => OtpView(
//         phoneNumber: (state.extra as String?) ?? '',
//       ),
//     ),
//     GoRoute(
//       path: AppRoutes.personalInformation,
//       name: AppRouteNames.personalInformation,
//       builder: (context, state) => const PersonalInformationView(),
//     ),
//     GoRoute(
//       path: AppRoutes.authSuccess,
//       name: AppRouteNames.authSuccess,
//       builder: (context, state) => const AuthSuccessView(),
//     ),
//     GoRoute(
//       path: AppRoutes.paymentMethods,
//       name: AppRouteNames.paymentMethods,
//       builder: (context, state) => const PaymentMethodsView(),
//     ),
//     GoRoute(
//       path: AppRoutes.enterCardInfo,
//       name: AppRouteNames.enterCardInfo,
//       builder: (context, state) {
//         final bloc = state.extra as PaymentMethodsBloc;
//         return EnterCardInfoView(bloc: bloc);
//       },
//     ),
//     GoRoute(
//       path: AppRoutes.privateRide,
//       name: AppRouteNames.privateRide,
//       builder: (context, state) => const PrivateRideView(),
//     ),
  ],
);
