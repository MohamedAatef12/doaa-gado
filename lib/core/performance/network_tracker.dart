/// Tracks network request performance and identifies slow endpoints.
class NetworkTracker {
  NetworkTracker._();

  // ============================================
  // Configuration
  // ============================================

  /// Enable or disable network tracking
  static bool isEnabled = true;
  static bool isDebugMode = true;
  static final Map<String, _NetworkMetric> _requests = {};
  static int slowRequestThresholdMs = 1000;

  /// Clear all tracked data
  static void clear() {
    _requests.clear();
  }

  // ============================================
  // Tracking
  // ============================================

  /// Track a network request
  static void trackRequest({
    required String endpoint,
    required String method,
    required int statusCode,
    required Duration duration,
    int? responseSizeBytes,
  }) {
    if (!isEnabled) return;

    final key = '$method $endpoint';
    final existing = _requests[key];

    final isSuccess = statusCode >= 200 && statusCode < 300;
    final isError = statusCode >= 400;

    if (existing == null) {
      _requests[key] = _NetworkMetric(
        endpoint: endpoint,
        method: method,
        totalRequests: 1,
        successfulRequests: isSuccess ? 1 : 0,
        failedRequests: isError ? 1 : 0,
        totalDuration: duration,
        minDuration: duration,
        maxDuration: duration,
        lastDuration: duration,
        totalBytes: responseSizeBytes ?? 0,
      );
    } else {
      _requests[key] = _NetworkMetric(
        endpoint: endpoint,
        method: method,
        totalRequests: existing.totalRequests + 1,
        successfulRequests: existing.successfulRequests + (isSuccess ? 1 : 0),
        failedRequests: existing.failedRequests + (isError ? 1 : 0),
        totalDuration: existing.totalDuration + duration,
        minDuration: duration < existing.minDuration
            ? duration
            : existing.minDuration,
        maxDuration: duration > existing.maxDuration
            ? duration
            : existing.maxDuration,
        lastDuration: duration,
        totalBytes: existing.totalBytes + (responseSizeBytes ?? 0),
      );
    }

    if (isDebugMode) {
      final status = isSuccess ? '✅' : (isError ? '❌' : '⚠️');
      _log('$status $key: ${duration.inMilliseconds}ms ($statusCode)');

      if (duration.inMilliseconds > slowRequestThresholdMs) {
        _log('🐢 SLOW REQUEST: $key took ${duration.inMilliseconds}ms');
      }
    }
  }

  // ============================================
  // Reporting
  // ============================================

  /// Get all tracked endpoints
  static List<NetworkMetricData> getMetrics() {
    return _requests.values
        .map(
          (m) => NetworkMetricData(
            endpoint: m.endpoint,
            method: m.method,
            totalRequests: m.totalRequests,
            successfulRequests: m.successfulRequests,
            failedRequests: m.failedRequests,
            averageTimeMs: m.averageDuration.inMilliseconds,
            minTimeMs: m.minDuration.inMilliseconds,
            maxTimeMs: m.maxDuration.inMilliseconds,
            lastTimeMs: m.lastDuration.inMilliseconds,
            totalBytesTransferred: m.totalBytes,
          ),
        )
        .toList()
      ..sort((a, b) => b.totalRequests.compareTo(a.totalRequests));
  }

  /// Get slowest endpoints
  static List<NetworkMetricData> getSlowestEndpoints([int limit = 10]) {
    final metrics = getMetrics();
    metrics.sort((a, b) => b.averageTimeMs.compareTo(a.averageTimeMs));
    return metrics.take(limit).toList();
  }

  /// Get endpoints with highest error rate
  static List<NetworkMetricData> getMostErrorProneEndpoints([int limit = 10]) {
    final metrics = getMetrics();
    metrics.sort((a, b) => b.errorRate.compareTo(a.errorRate));
    return metrics.where((m) => m.failedRequests > 0).take(limit).toList();
  }

  /// Get most called endpoints
  static List<NetworkMetricData> getMostCalledEndpoints([int limit = 10]) {
    return getMetrics().take(limit).toList();
  }

  /// Print network performance report
  static void printReport() {
    if (!isDebugMode) return;

    _log('\n${'=' * 60}');
    _log('🌐 NETWORK PERFORMANCE REPORT');
    _log('=' * 60);

    final metrics = getMetrics();
    if (metrics.isEmpty) {
      _log('No network requests tracked yet.');
      _log('=' * 60 + '\n');
      return;
    }

    // Summary
    final totalRequests = metrics.fold<int>(
      0,
      (sum, m) => sum + m.totalRequests,
    );
    final totalErrors = metrics.fold<int>(
      0,
      (sum, m) => sum + m.failedRequests,
    );
    final totalBytes = metrics.fold<int>(
      0,
      (sum, m) => sum + m.totalBytesTransferred,
    );

    _log('\n📊 Summary:');
    _log('   Total Requests: $totalRequests');
    _log(
      '   Total Errors: $totalErrors (${(totalErrors / totalRequests * 100).toStringAsFixed(1)}%)',
    );
    _log('   Data Transferred: ${_formatBytes(totalBytes)}');

    // Slowest
    _log('\n🐢 Slowest Endpoints:');
    for (final m in getSlowestEndpoints(5)) {
      _log('   ${m.method} ${m.endpoint}: ${m.averageTimeMs}ms avg');
    }

    // Error prone
    final errorProne = getMostErrorProneEndpoints(5);
    if (errorProne.isNotEmpty) {
      _log('\n❌ Highest Error Rate:');
      for (final m in errorProne) {
        _log(
          '   ${m.method} ${m.endpoint}: ${m.errorRate.toStringAsFixed(1)}% errors',
        );
      }
    }

    // Most called
    _log('\n🔥 Most Called:');
    for (final m in getMostCalledEndpoints(5)) {
      _log('   ${m.method} ${m.endpoint}: ${m.totalRequests} calls');
    }

    _log('\n${'=' * 60}\n');
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }

  static void _log(String message) {
    // ignore: avoid_print
    print('[NetworkTracker] $message');
  }
}

// ============================================
// Data Classes
// ============================================

class _NetworkMetric {
  final String endpoint;
  final String method;
  final int totalRequests;
  final int successfulRequests;
  final int failedRequests;
  final Duration totalDuration;
  final Duration minDuration;
  final Duration maxDuration;
  final Duration lastDuration;
  final int totalBytes;

  _NetworkMetric({
    required this.endpoint,
    required this.method,
    required this.totalRequests,
    required this.successfulRequests,
    required this.failedRequests,
    required this.totalDuration,
    required this.minDuration,
    required this.maxDuration,
    required this.lastDuration,
    required this.totalBytes,
  });

  Duration get averageDuration =>
      Duration(microseconds: totalDuration.inMicroseconds ~/ totalRequests);
}

/// Public data class for network metrics
class NetworkMetricData {
  final String endpoint;
  final String method;
  final int totalRequests;
  final int successfulRequests;
  final int failedRequests;
  final int averageTimeMs;
  final int minTimeMs;
  final int maxTimeMs;
  final int lastTimeMs;
  final int totalBytesTransferred;

  NetworkMetricData({
    required this.endpoint,
    required this.method,
    required this.totalRequests,
    required this.successfulRequests,
    required this.failedRequests,
    required this.averageTimeMs,
    required this.minTimeMs,
    required this.maxTimeMs,
    required this.lastTimeMs,
    required this.totalBytesTransferred,
  });

  double get successRate =>
      totalRequests > 0 ? (successfulRequests / totalRequests) * 100 : 0;

  double get errorRate =>
      totalRequests > 0 ? (failedRequests / totalRequests) * 100 : 0;

  Map<String, dynamic> toJson() => {
    'endpoint': endpoint,
    'method': method,
    'totalRequests': totalRequests,
    'successfulRequests': successfulRequests,
    'failedRequests': failedRequests,
    'averageTimeMs': averageTimeMs,
    'minTimeMs': minTimeMs,
    'maxTimeMs': maxTimeMs,
    'lastTimeMs': lastTimeMs,
    'totalBytesTransferred': totalBytesTransferred,
    'successRate': successRate,
    'errorRate': errorRate,
  };

  @override
  String toString() =>
      '$method $endpoint: ${averageTimeMs}ms avg, $totalRequests calls';
}
