import 'package:flutter/widgets.dart';

/// Tracks widget rebuilds and identifies widgets that rebuild too frequently.
class WidgetTracker {
  WidgetTracker._();

  // ============================================
  static final Map<String, _WidgetRebuildData> _rebuilds = {};
  // ============================================

  /// Enable or disable widget tracking
  static bool isEnabled = true;

  /// Enable debug mode for console logging
  static bool isDebugMode = true;

  /// Set the threshold for warning about excessive rebuilds
  static int rebuildThreshold = 10;

  /// Clear all tracked data
  static void clear() {
    _rebuilds.clear();
  }

  // ============================================
  // Tracking
  // ============================================

  /// Track a widget rebuild. Call this in build() methods.
  static void trackRebuild(String widgetName, [String? context]) {
    if (!isEnabled) return;

    final key = context != null ? '$widgetName:$context' : widgetName;
    final now = DateTime.now();

    final existing = _rebuilds[key];
    if (existing == null) {
      _rebuilds[key] = _WidgetRebuildData(
        widgetName: widgetName,
        context: context,
        totalRebuilds: 1,
        rebuildsInLastSecond: 1,
        lastRebuildTime: now,
        firstRebuildTime: now,
      );
    } else {
      // Check if within last second
      final timeSinceLastRebuild = now.difference(existing.lastRebuildTime);
      int rebuildsInLastSecond = existing.rebuildsInLastSecond;

      if (timeSinceLastRebuild.inMilliseconds < 1000) {
        rebuildsInLastSecond++;
      } else {
        rebuildsInLastSecond = 1;
      }

      _rebuilds[key] = _WidgetRebuildData(
        widgetName: widgetName,
        context: context,
        totalRebuilds: existing.totalRebuilds + 1,
        rebuildsInLastSecond: rebuildsInLastSecond,
        lastRebuildTime: now,
        firstRebuildTime: existing.firstRebuildTime,
      );

      // Warn if exceeding threshold
      if (rebuildsInLastSecond > rebuildThreshold && isDebugMode) {
        _log(
          '⚠️ EXCESSIVE REBUILDS: $key rebuilt $rebuildsInLastSecond times in 1 second!',
        );
      }
    }
  }

  // ============================================
  // Reporting
  // ============================================

  /// Get all tracked widgets sorted by total rebuilds
  static List<WidgetRebuildInfo> getWidgetStats() {
    return _rebuilds.values
        .map(
          (d) => WidgetRebuildInfo(
            widgetName: d.widgetName,
            context: d.context,
            totalRebuilds: d.totalRebuilds,
            rebuildsPerSecond: d.rebuildsInLastSecond.toDouble(),
            trackingDuration: DateTime.now().difference(d.firstRebuildTime),
          ),
        )
        .toList()
      ..sort((a, b) => b.totalRebuilds.compareTo(a.totalRebuilds));
  }

  /// Get widgets that are rebuilding excessively
  static List<WidgetRebuildInfo> getExcessiveRebuilders() {
    return getWidgetStats()
        .where((w) => w.rebuildsPerSecond > rebuildThreshold)
        .toList();
  }

  /// Get most frequently rebuilding widgets
  static List<WidgetRebuildInfo> getMostRebuiltWidgets([int limit = 10]) {
    return getWidgetStats().take(limit).toList();
  }

  /// Print widget rebuild report
  static void printReport() {
    if (!isDebugMode) return;

    _log('\n${'=' * 60}');
    _log('🔄 WIDGET REBUILD REPORT');
    _log('=' * 60);

    final stats = getWidgetStats();
    if (stats.isEmpty) {
      _log('No widgets tracked yet.');
      _log('=' * 60 + '\n');
      return;
    }

    // Excessive rebuilders
    final excessive = getExcessiveRebuilders();
    if (excessive.isNotEmpty) {
      _log('\n⚠️ Excessive Rebuilders (>$rebuildThreshold/sec):');
      for (final w in excessive) {
        _log(
          '   ${w.widgetName}: ${w.rebuildsPerSecond.toStringAsFixed(1)}/sec',
        );
      }
    }

    // Most rebuilt
    _log('\n🔥 Most Rebuilt Widgets:');
    for (final w in getMostRebuiltWidgets(10)) {
      final ctx = w.context != null ? ' (${w.context})' : '';
      _log('   ${w.widgetName}$ctx: ${w.totalRebuilds} rebuilds');
    }

    _log('\n${'=' * 60}\n');
  }

  static void _log(String message) {
    // ignore: avoid_print
    print('[WidgetTracker] $message');
  }
}

// ============================================
// Data Classes
// ============================================

class _WidgetRebuildData {
  final String widgetName;
  final String? context;
  final int totalRebuilds;
  final int rebuildsInLastSecond;
  final DateTime lastRebuildTime;
  final DateTime firstRebuildTime;

  _WidgetRebuildData({
    required this.widgetName,
    required this.context,
    required this.totalRebuilds,
    required this.rebuildsInLastSecond,
    required this.lastRebuildTime,
    required this.firstRebuildTime,
  });
}

/// Public data class for widget rebuild info
class WidgetRebuildInfo {
  final String widgetName;
  final String? context;
  final int totalRebuilds;
  final double rebuildsPerSecond;
  final Duration trackingDuration;

  WidgetRebuildInfo({
    required this.widgetName,
    required this.context,
    required this.totalRebuilds,
    required this.rebuildsPerSecond,
    required this.trackingDuration,
  });

  double get rebuildsPerMinute => trackingDuration.inSeconds > 0
      ? totalRebuilds / (trackingDuration.inSeconds / 60)
      : totalRebuilds.toDouble();

  Map<String, dynamic> toJson() => {
    'widgetName': widgetName,
    'context': context,
    'totalRebuilds': totalRebuilds,
    'rebuildsPerSecond': rebuildsPerSecond,
    'trackingDurationSec': trackingDuration.inSeconds,
  };

  @override
  String toString() => '$widgetName: $totalRebuilds rebuilds';
}

// ============================================
// Mixin for Easy Tracking
// ============================================

/// Mixin to easily track widget rebuilds.
///
/// Usage:
/// ```dart
/// class MyWidget extends StatelessWidget with RebuildTracker {
///   @override
///   Widget build(BuildContext context) {
///     trackRebuild(); // Add this line
///     return Container();
///   }
/// }
/// ```
mixin RebuildTracker on Widget {
  void trackRebuild([String? context]) {
    WidgetTracker.trackRebuild(runtimeType.toString(), context);
  }
}

/// Wrapper widget that tracks rebuilds of its child
class TrackRebuilds extends StatelessWidget {
  final String name;
  final Widget child;

  const TrackRebuilds({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    WidgetTracker.trackRebuild(name);
    return child;
  }
}
