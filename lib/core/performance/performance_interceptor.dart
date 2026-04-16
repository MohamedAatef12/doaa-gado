import 'package:dio/dio.dart';

import 'network_tracker.dart';

/// Dio interceptor that automatically tracks all network requests.
///
/// Usage:
/// ```dart
/// final dio = Dio();
/// dio.interceptors.add(PerformanceInterceptor());
/// ```
class PerformanceInterceptor extends Interceptor {
  final Map<int, DateTime> _requestTimestamps = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _requestTimestamps[options.hashCode] = DateTime.now();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _trackRequest(
      response.requestOptions,
      response.statusCode ?? 200,
      response.data,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _trackRequest(err.requestOptions, err.response?.statusCode ?? 0, null);
    super.onError(err, handler);
  }

  void _trackRequest(RequestOptions options, int statusCode, dynamic data) {
    final startTime = _requestTimestamps.remove(options.hashCode);
    if (startTime == null) return;

    final duration = DateTime.now().difference(startTime);

    // Calculate response size
    int? responseSize;
    if (data != null) {
      if (data is String) {
        responseSize = data.length;
      } else if (data is List) {
        responseSize = data.length;
      }
    }

    NetworkTracker.trackRequest(
      endpoint: options.path,
      method: options.method,
      statusCode: statusCode,
      duration: duration,
      responseSizeBytes: responseSize,
    );
  }
}
