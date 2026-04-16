// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../data/caching/cache_manager.dart';
// import '../di/di_wrapper.dart';
// import 'routes.dart';

// import '../../core/utils/logger.dart';
// import '../../data/caching/secure_storage_helper.dart';
// import '../../data/caching/shared_prefs_helper.dart';

// class AuthService {
//   static bool? _isSignedUp;
//   static bool? _isLoggedIn;
//   static bool? _isProfileCompleted;
//   static bool? _isOnboardingCompleted;

//   static Future<void> init() async {
//     await SharedPrefsHelper.init();
//     _isSignedUp = SharedPrefsHelper.getBool('isSignedUp') ?? false;
//     _isLoggedIn = SharedPrefsHelper.getBool('isLoggedIn') ?? false;
//     _isProfileCompleted =
//         SharedPrefsHelper.getBool('isProfileCompleted') ?? false;
//     _isOnboardingCompleted =
//         SharedPrefsHelper.getBool('isOnboardingCompleted') ?? false;
//   }

//   static bool get isSignedUp => _isSignedUp ?? false;
//   static bool get isLoggedIn => _isLoggedIn ?? false;
//   static bool get isProfileCompleted => _isProfileCompleted ?? false;
//   static bool get isOnboardingCompleted => _isOnboardingCompleted ?? false;
//   static bool get isAuth => isSignedUp && isLoggedIn && isProfileCompleted;

//   static Future<void> completeOnboarding() async {
//     await DI.find<CacheManager>().saveOnboardingCompleted(true);
//     _isOnboardingCompleted = true;
//   }

//   static Future<bool> login(String email, String password) async {
//     final storedEmail = await SecureStorageHelper.read('email');
//     final storedPassword = await SecureStorageHelper.read('password');

//     final match = email == storedEmail && password == storedPassword;
//     if (match) {
//       await SharedPrefsHelper.setBool('isLoggedIn', true);
//       _isLoggedIn = true; // Update memory cache
//     }
//     return match;
//   }

//   static Future<void> completeRegistration() async {
//     // Only update memory cache, do not persist yet
//     _isSignedUp = true;
//     _isLoggedIn = true;
//     _isProfileCompleted = true; // TEMP: Set to true for testing to skip profile
//   }

//   static Future<void> completeProfile() async {
//     await SharedPrefsHelper.init();
//     // Persist all flags now that we reached the end of the flow
//     await SharedPrefsHelper.setBool('isSignedUp', true);
//     await SharedPrefsHelper.setBool('isLoggedIn', true);
//     await SharedPrefsHelper.setBool('isProfileCompleted', true);

//     // Update memory cache
//     _isProfileCompleted = true;
//   }

//   static Future<void> logout() async {
//     // Clear secure storage
//     try {
//       await SecureStorageHelper.delete('email');
//       await SecureStorageHelper.delete('password');
//     } catch (e) {
//       AppLogger.error('Failed to clear secure storage: $e');
//     }

//     // Clear shared preferences
//     await SharedPrefsHelper.setBool('isSignedUp', false);
//     await SharedPrefsHelper.setBool('isLoggedIn', false);
//     await SharedPrefsHelper.setBool('isProfileCompleted', false);

//     await DI.find<CacheManager>().clearAccessToken();

//     // Update memory cache
//     _isSignedUp = false;
//     _isLoggedIn = false;
//     _isProfileCompleted = false;

//     AppLogger.error('User logged out successfully');
//   }
// }

// class AuthGuard {
//   static FutureOr<String?> redirect(
//     BuildContext context,
//     GoRouterState state,
//   ) async {
//     // Check cached auth state synchronously
//     final isSignedUp = AuthService.isSignedUp;
//     final isProfileCompleted = AuthService.isProfileCompleted;
//     final isAuth = AuthService.isAuth;
//     final isOnboardingCompleted = AuthService.isOnboardingCompleted;

//     final goingToLogin = state.uri.toString() == AppRoutes.login;
//     final goingToSignUp = state.uri.toString() == AppRoutes.signUp;
//     final goingToOnBoarding = state.uri.toString() == AppRoutes.onBoarding;
//     final goingToUserTypes = state.uri.toString() == AppRoutes.userType;
//     final goingToSetupProfile = state.uri.toString() == AppRoutes.setupProfile;
//     final goingToForgetPassword =
//         state.uri.toString() == AppRoutes.forgetPassword;
//     final goingToSplash = state.uri.toString() == AppRoutes.splash;

//     // 0. Always allow Splash
//     if (goingToSplash) return null;

//     // 1. If Onboarding NOT completed -> Force Onboarding
//     if (!isOnboardingCompleted) {
//       if (goingToOnBoarding) return null;
//       return AppRoutes.onBoarding;
//     }

//     // 2. If Onboarding Completed but Not Signed Up -> Force Auth (Login/SignUp/UserType)
//     if (!isSignedUp) {
//       if (goingToLogin ||
//           goingToSignUp ||
//           goingToForgetPassword ||
//           goingToUserTypes) {
//         return null; // Allow auth pages
//       }
//       // If trying to go to Onboarding or internal pages => Redirect to Login (or UserType)
//       return AppRoutes.login;
//     }

//     // 3. If signed up but profile not completed, force Profile...
//     // BUT allow going back to SignUp/OnBoarding/UserType if the user wants?
//     // Actually if Onboarding is done, probably shouldn't go back to it.
//     // Allow Logout (Login) etc.
//     if (isSignedUp && !isProfileCompleted) {
//       if (goingToSetupProfile ||
//           goingToSignUp ||
//           goingToUserTypes ||
//           goingToLogin ||
//           goingToForgetPassword) {
//         return null;
//       }
//       return AppRoutes.setupProfile;
//     }

//     // 4. If fully authenticated, prevent access to Auth/Onboarding/Profile screens.
//     if (isAuth &&
//         (goingToLogin ||
//             goingToSignUp ||
//             goingToOnBoarding ||
//             goingToUserTypes ||
//             goingToSetupProfile)) {
//       return AppRoutes.home;
//     }

//     return null;
//   }
// }
