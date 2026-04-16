import 'dart:async';
import 'dart:developer' as developer;

/// Performance monitoring service for tracking function execution times,
/// frame rates, memory usage, and identifying performance bottlenecks.
class PerformanceMonitor {
  PerformanceMonitor._();

  static bool isEnabled = true;
  static bool isDebugMode = true;
  static final Map<String, _PerformanceMetric> _metrics = {};
  static final Map<String, int> _callCounts = {};
  static final Map<String, Stopwatch> _activeTimers = {};
  static final List<_FrameData> _frameHistory = [];
  static const int _maxFrameHistory = 120; // ~2 seconds at 60fps

  // ============================================
  // Configuration
  // ============================================

  /// Enable or disable performance monitoring

  /// Clear all collected metrics
  static void clear() {
    _metrics.clear();
    _callCounts.clear();
    _activeTimers.clear();
    _frameHistory.clear();
  }

  // ============================================
  // Function Timing
  // ============================================

  /// Start timing a function or operation
  static void startTimer(String name) {
    if (!isEnabled) return;

    _activeTimers[name] = Stopwatch()..start();
    _callCounts[name] = (_callCounts[name] ?? 0) + 1;
  }

  /// Stop timing and record the result
  static Duration? stopTimer(String name) {
    if (!isEnabled) return null;

    final timer = _activeTimers.remove(name);
    if (timer == null) return null;

    timer.stop();
    final duration = timer.elapsed;

    _recordMetric(name, duration);

    if (isDebugMode) {
      _log('⏱️ $name: ${duration.inMilliseconds}ms');
    }

    return duration;
  }

  /// Measure async function execution time
  static Future<T> measureAsync<T>(
    String name,
    Future<T> Function() function,
  ) async {
    if (!isEnabled) return function();

    startTimer(name);
    try {
      return await function();
    } finally {
      stopTimer(name);
    }
  }

  /// Measure sync function execution time
  static T measure<T>(String name, T Function() function) {
    if (!isEnabled) return function();

    startTimer(name);
    try {
      return function();
    } finally {
      stopTimer(name);
    }
  }

  /// Record a custom metric value
  static void _recordMetric(String name, Duration duration) {
    final existing = _metrics[name];
    if (existing == null) {
      _metrics[name] = _PerformanceMetric(
        name: name,
        totalTime: duration,
        minTime: duration,
        maxTime: duration,
        callCount: 1,
        lastTime: duration,
      );
    } else {
      _metrics[name] = _PerformanceMetric(
        name: name,
        totalTime: existing.totalTime + duration,
        minTime: duration < existing.minTime ? duration : existing.minTime,
        maxTime: duration > existing.maxTime ? duration : existing.maxTime,
        callCount: existing.callCount + 1,
        lastTime: duration,
      );
    }
  }

  // ============================================
  // Frame Tracking
  // ============================================

  /// Record a frame render time
  static void recordFrame(Duration frameTime) {
    if (!isEnabled) return;

    _frameHistory.add(
      _FrameData(timestamp: DateTime.now(), duration: frameTime),
    );

    // Keep history bounded
    while (_frameHistory.length > _maxFrameHistory) {
      _frameHistory.removeAt(0);
    }
  }

  /// Get current FPS based on recent frames
  static double get currentFps {
    if (_frameHistory.isEmpty) return 0;

    final recentFrames = _frameHistory.length > 10
        ? _frameHistory.sublist(_frameHistory.length - 10)
        : _frameHistory;

    final avgFrameTime =
        recentFrames
            .map((f) => f.duration.inMicroseconds)
            .reduce((a, b) => a + b) /
        recentFrames.length;

    return 1000000 / avgFrameTime; // microseconds to FPS
  }

  /// Get frame time statistics
  static FrameStats? get frameStats {
    if (_frameHistory.isEmpty) return null;

    final times = _frameHistory.map((f) => f.duration).toList();
    times.sort((a, b) => a.compareTo(b));

    final total = times.reduce((a, b) => a + b);
    final avg = Duration(microseconds: total.inMicroseconds ~/ times.length);

    return FrameStats(
      averageFrameTime: avg,
      minFrameTime: times.first,
      maxFrameTime: times.last,
      p95FrameTime: times[(times.length * 0.95).floor()],
      droppedFrames: times.where((d) => d.inMilliseconds > 16).length,
      totalFrames: times.length,
    );
  }

  // ============================================
  // Memory Tracking
  // ============================================

  /// Log current memory usage (debug only)
  static void logMemoryUsage([String? label]) {
    if (!isEnabled || !isDebugMode) return;

    // Note: Detailed memory info requires dart:developer Timeline
    developer.Timeline.instantSync(
      'Memory Check${label != null ? ': $label' : ''}',
    );

    _log('🧠 Memory checkpoint: ${label ?? 'unnamed'}');
  }

  // ============================================
  // Reporting
  // ============================================

  /// Get all recorded metrics
  static List<PerformanceMetricData> getMetrics() {
    return _metrics.values
        .map(
          (m) => PerformanceMetricData(
            name: m.name,
            callCount: m.callCount,
            totalTimeMs: m.totalTime.inMilliseconds,
            averageTimeMs: m.averageTime.inMilliseconds,
            minTimeMs: m.minTime.inMilliseconds,
            maxTimeMs: m.maxTime.inMilliseconds,
            lastTimeMs: m.lastTime.inMilliseconds,
          ),
        )
        .toList()
      ..sort((a, b) => b.totalTimeMs.compareTo(a.totalTimeMs));
  }

  /// Get metrics sorted by average time (slowest first)
  static List<PerformanceMetricData> getSlowestOperations([int limit = 10]) {
    final metrics = getMetrics();
    metrics.sort((a, b) => b.averageTimeMs.compareTo(a.averageTimeMs));
    return metrics.take(limit).toList();
  }

  /// Get metrics sorted by call count (most called first)
  static List<PerformanceMetricData> getMostCalledOperations([int limit = 10]) {
    final metrics = getMetrics();
    metrics.sort((a, b) => b.callCount.compareTo(a.callCount));
    return metrics.take(limit).toList();
  }

  /// Get metrics sorted by total time (most time spent first)
  static List<PerformanceMetricData> getMostTimeConsumingOperations([
    int limit = 10,
  ]) {
    return getMetrics().take(limit).toList();
  }

  /// Print a performance report to console
  static void printReport() {
    if (!isDebugMode) return;

    _log('\n${'=' * 60}');
    _log('📊 PERFORMANCE REPORT');
    _log('=' * 60);

    // Frame stats
    final fStats = frameStats;
    if (fStats != null) {
      _log('\n🎬 Frame Statistics:');
      _log('   FPS: ${currentFps.toStringAsFixed(1)}');
      _log('   Avg Frame: ${fStats.averageFrameTime.inMilliseconds}ms');
      _log('   Max Frame: ${fStats.maxFrameTime.inMilliseconds}ms');
      _log('   P95 Frame: ${fStats.p95FrameTime.inMilliseconds}ms');
      _log('   Dropped: ${fStats.droppedFrames}/${fStats.totalFrames}');
    }

    // Slowest operations
    _log('\n🐢 Slowest Operations (by avg):');
    for (final m in getSlowestOperations(5)) {
      _log('   ${m.name}: ${m.averageTimeMs}ms avg (${m.callCount} calls)');
    }

    // Most called
    _log('\n🔥 Most Called Operations:');
    for (final m in getMostCalledOperations(5)) {
      _log('   ${m.name}: ${m.callCount} calls (${m.averageTimeMs}ms avg)');
    }

    // Most time consuming
    _log('\n⏰ Most Time Consuming (total):');
    for (final m in getMostTimeConsumingOperations(5)) {
      _log('   ${m.name}: ${m.totalTimeMs}ms total (${m.callCount} calls)');
    }

    _log('\n${'=' * 60}\n');
  }

  /// Export metrics as JSON-compatible map
  static Map<String, dynamic> exportMetrics() {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'frameStats': frameStats?.toJson(),
      'currentFps': currentFps,
      'metrics': getMetrics().map((m) => m.toJson()).toList(),
    };
  }

  static void _log(String message) {
    // ignore: avoid_print
    print('[PerformanceMonitor] $message');
  }
}

// ============================================
// Data Classes
// ============================================

class _PerformanceMetric {
  final String name;
  final Duration totalTime;
  final Duration minTime;
  final Duration maxTime;
  final Duration lastTime;
  final int callCount;

  _PerformanceMetric({
    required this.name,
    required this.totalTime,
    required this.minTime,
    required this.maxTime,
    required this.lastTime,
    required this.callCount,
  });

  Duration get averageTime =>
      Duration(microseconds: totalTime.inMicroseconds ~/ callCount);
}

class _FrameData {
  final DateTime timestamp;
  final Duration duration;

  _FrameData({required this.timestamp, required this.duration});
}

/// Public data class for metric reporting
class PerformanceMetricData {
  final String name;
  final int callCount;
  final int totalTimeMs;
  final int averageTimeMs;
  final int minTimeMs;
  final int maxTimeMs;
  final int lastTimeMs;

  PerformanceMetricData({
    required this.name,
    required this.callCount,
    required this.totalTimeMs,
    required this.averageTimeMs,
    required this.minTimeMs,
    required this.maxTimeMs,
    required this.lastTimeMs,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'callCount': callCount,
    'totalTimeMs': totalTimeMs,
    'averageTimeMs': averageTimeMs,
    'minTimeMs': minTimeMs,
    'maxTimeMs': maxTimeMs,
    'lastTimeMs': lastTimeMs,
  };

  @override
  String toString() =>
      '$name: ${averageTimeMs}ms avg, $callCount calls, ${totalTimeMs}ms total';
}

/// Frame statistics data
class FrameStats {
  final Duration averageFrameTime;
  final Duration minFrameTime;
  final Duration maxFrameTime;
  final Duration p95FrameTime;
  final int droppedFrames;
  final int totalFrames;

  FrameStats({
    required this.averageFrameTime,
    required this.minFrameTime,
    required this.maxFrameTime,
    required this.p95FrameTime,
    required this.droppedFrames,
    required this.totalFrames,
  });

  double get droppedFramePercentage =>
      totalFrames > 0 ? (droppedFrames / totalFrames) * 100 : 0;

  Map<String, dynamic> toJson() => {
    'averageFrameTimeMs': averageFrameTime.inMilliseconds,
    'minFrameTimeMs': minFrameTime.inMilliseconds,
    'maxFrameTimeMs': maxFrameTime.inMilliseconds,
    'p95FrameTimeMs': p95FrameTime.inMilliseconds,
    'droppedFrames': droppedFrames,
    'totalFrames': totalFrames,
    'droppedFramePercentage': droppedFramePercentage,
  };
}
