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

  // configureDependencies();
  final talker = TalkerFlutter.init();
  Bloc.observer = TalkerBlocObserver(talker: talker);

  final networkRepo = NetworkRepository();

  runApp(
    RepositoryProvider.value(
      value: networkRepo,
      child: BlocProvider(
        create: (context) => NetworkBloc(networkRepo)..add(NetworkObserve()),
        child: DebugOverlay(
          enabled: true, // Only show in debug mode
          child: MyApp(appConfig: config),
        ),
      ),
    ),
  );
}
