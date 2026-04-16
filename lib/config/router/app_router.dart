// import 'package:go_router/go_router.dart';

// import '../../features/auth/views/view/auth_success_view.dart';
// import '../../features/auth/views/view/login_view.dart';
// import '../../features/auth/views/view/otp_view.dart';
// import '../../features/auth/views/view/personal_information_view.dart';
// import '../../features/home/views/view/home_view.dart';
// import '../../features/payment/presentation/bloc/payment_methods_bloc.dart';
// import '../../features/payment/presentation/views/enter_card_info_view.dart';
// import '../../features/payment/presentation/views/payment_methods_view.dart';
// import '../../features/private_ride/views/view/private_ride_view.dart';
// import '../../features/splash/views/view/splash_view.dart';
// import 'routes.dart';

// final GoRouter router = GoRouter(
//   initialLocation: AppRoutes.privateRide,
//   routes: [
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
//     GoRoute(
//       path: AppRoutes.login,
//       name: AppRouteNames.login,
//       builder: (context, state) => const LoginView(),
//     ),
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
//   ],
// );
