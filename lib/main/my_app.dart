import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/env/app_config.dart';
import '../config/router/app_router.dart';
import '../core/themes/dark_theme.dart';
import '../core/network/widgets/connectivity_wrapper.dart';

// final router = appRouter();

class MyApp extends StatelessWidget {
  final AppConfig appConfig;

  const MyApp({super.key, required this.appConfig});

  @override
  Widget build(BuildContext context) {
    final isDev = appConfig.envName == 'Development';

    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return MaterialApp.router(
          locale: const Locale('ar'),

          localeResolutionCallback: (locale, supportedLocales) {
            return const Locale('ar');
          },
          localeListResolutionCallback: (locales, supportedLocales) {
            for (var locale in locales!) {
              for (var supportedLocale in supportedLocales) {
                if (locale.languageCode == supportedLocale.languageCode) {
                  return supportedLocale;
                }
              }
            }
            return supportedLocales.first;
          },
          title: appConfig.envName,
          debugShowCheckedModeBanner: isDev ? false : false,

          builder: (context, child) {
            return ConnectivityWrapper(child: child!);
          },
        
          // routerConfig: router,
        );
      },
    );
  }
}
