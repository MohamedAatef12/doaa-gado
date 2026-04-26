import 'package:doaa_gado/core/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/env/app_config.dart';
import '../config/router/app_router.dart';

class MyApp extends StatelessWidget {
  final AppConfig appConfig;

  const MyApp({super.key, required this.appConfig});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: appConfig.envName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(false),
          darkTheme: AppTheme.getTheme(true),
          themeMode: ThemeMode.light, // Set default or use a preference
          routerConfig: router,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/islamic_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Global light overlay for better text contrast
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                if (child != null) child,
              ],
            );
          },
        );
      },
    );
  }
}
