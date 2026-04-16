import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../env/app_config.dart';

@module
abstract class DIModule {
  @lazySingleton
  Dio dio(AppConfig config, Talker talker) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseMessage: true,
          printRequestData: true,
          printResponseData: true,
        ),
      ),
    );

    return dio;
  }
}
