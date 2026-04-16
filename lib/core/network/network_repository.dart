import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'network_status.dart';

export 'network_status.dart';

class NetworkRepository {
  final Connectivity _connectivity;
  final InternetConnection _internetConnection;
  final Dio _dio;

  // Stream controller for exposing network status updates
  final _controller = StreamController<NetworkStatus>.broadcast();

  // Configuration thresholds
  static const int _latencyThresholdMs = 1500; // Consider > 1.5s as low quality

  NetworkRepository({
    Connectivity? connectivity,
    InternetConnection? internetConnection,
    Dio? dio,
  }) : _connectivity = connectivity ?? Connectivity(),
       _internetConnection = internetConnection ?? InternetConnection(),
       _dio =
           dio ??
           Dio(
             BaseOptions(
               connectTimeout: const Duration(seconds: 5),
               receiveTimeout: const Duration(seconds: 5),
             ),
           );

  Stream<NetworkStatus> get statusStream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  /// Initialize listeners for connectivity changes
  void initialize() {
    // Listen to hardware connectivity changes (Wifi, Mobile, None)
    _connectivity.onConnectivityChanged.listen((results) {
      _checkInternetStatus();
    });

    // Listen to actual internet reachable status
    _internetConnection.onStatusChange.listen((status) {
      _checkInternetStatus(passedStatus: status);
    });
  }

  /// Manually check current status
  Future<NetworkStatus> checkStatus() async {
    return _checkInternetStatus();
  }

  Timer? _debounceTimer;

  Future<NetworkStatus> _checkInternetStatus({
    InternetStatus? passedStatus,
  }) async {
    // Debounce checks to prevent UI flickering/spam
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    final completer = Completer<NetworkStatus>();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final result = await _performStatusCheck(passedStatus: passedStatus);
        completer.complete(result);
      } catch (e) {
        completer.complete(NetworkStatus.offline); // Default fail-safe
      }
    });

    return completer.future;
  }

  Future<NetworkStatus> _performStatusCheck({
    InternetStatus? passedStatus,
  }) async {
    // 1. Check Hardware Connectivity
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _controller.add(NetworkStatus.offline);
      return NetworkStatus.offline;
    }

    // 2. Check Actual Internet Reachability
    bool hasInternet;
    if (passedStatus != null) {
      hasInternet = passedStatus == InternetStatus.connected;
    } else {
      hasInternet = await _internetConnection.hasInternetAccess;
    }

    if (!hasInternet) {
      _controller.add(NetworkStatus.offline);
      return NetworkStatus.offline;
    }

    // 3. Check Latency (Low Quality Detection)
    // We only check latency if we passed the basic checks
    // We don't await this for the main status to keep UI snappy,
    // unless we strictly want to block "Online" state on latency.
    // For now, let's emit Online, then check latency.
    _controller.add(NetworkStatus.online);

    // Fire-and-forget latency check (or separate stream)
    // If we want to show "Low Quality", we can emit it subsequently.
    _checkLatency();

    return NetworkStatus.online;
  }

  Future<void> _checkLatency() async {
    final isLowQuality = await _isConnectionLowQuality();
    if (isLowQuality) {
      _controller.add(NetworkStatus.lowQuality);
    }
  }

  Future<bool> _isConnectionLowQuality() async {
    try {
      final stopwatch = Stopwatch()..start();
      // Use a localized reliable endpoint or a google one
      await _dio.head('https://www.google.com');
      stopwatch.stop();

      return stopwatch.elapsedMilliseconds > _latencyThresholdMs;
    } catch (_) {
      // If the ping fails but we thought we had internet (from step 2),
      // it might be extremely unstable or effectively offline for HTTP.
      // But step 2 (internet_connection_checker_plus) is more robust for simple connectivity.
      // We will assume "not low quality" (i.e., normal or offline handled elsewhere)
      // or maybe return false to avoid false positives on 'Low Quality'.
      return false;
    }
  }
}
