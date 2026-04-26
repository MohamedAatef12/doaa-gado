import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../config/env/app_config.dart';
import '../config/env/env.dart';
import '../config/di/di.dart';
import '../config/router/guards.dart';
import '../core/performance/performance.dart';
import '../core/network/network_repository.dart';
import '../core/network/bloc/network_bloc.dart';
import 'my_app.dart';

Future<void> mainCommon(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  getIt.registerSingleton<AppConfig>(config);
  configureDependencies();
  final talker = TalkerFlutter.init();
  getIt.registerSingleton<Talker>(talker);
  Bloc.observer = TalkerBlocObserver(talker: talker);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: MyApp(appConfig: config),
    ),
  );
}
