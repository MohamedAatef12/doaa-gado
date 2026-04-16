/// Performance monitoring module for tracking app performance.
///
/// This module provides comprehensive performance monitoring including:
/// - Function execution timing
/// - Frame rate tracking
/// - Widget rebuild tracking
/// - Network request monitoring
///
/// Usage:
/// ```dart
/// import 'package:trigo/core/performance/performance.dart';
///
/// // Measure function execution
/// await PerformanceMonitor.measureAsync('fetchUser', () async {
///   return await api.getUser();
/// });
///
/// // Track widget rebuilds
/// WidgetTracker.trackRebuild('MyWidget');
///
/// // Track network requests
/// NetworkTracker.trackRequest(
///   endpoint: '/api/users',
///   method: 'GET',
///   statusCode: 200,
///   duration: Duration(milliseconds: 150),
/// );
///
/// // Print reports
/// PerformanceMonitor.printReport();
/// WidgetTracker.printReport();
/// NetworkTracker.printReport();
/// ```
library;

export 'network_tracker.dart';
export 'performance_interceptor.dart';
export 'performance_monitor.dart';
export 'performance_overlay.dart';
export 'widget_tracker.dart';
