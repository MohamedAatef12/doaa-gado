import 'package:doaa_gado/core/constants/api_endpoints.dart';

class AppConfig {
  final String envName;
  final String apiBaseUrl;

  const AppConfig({required this.envName, required this.apiBaseUrl});

  static const dev = AppConfig(
    envName: 'Development',
    apiBaseUrl: ApiEndpoints.baseUrl,
  );

  static const prod = AppConfig(
    envName: 'Production',
    apiBaseUrl: ApiEndpoints.baseUrl,
  );
}
