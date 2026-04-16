import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'performance_monitor.dart';
import 'widget_tracker.dart';
import 'network_tracker.dart';

/// A debug overlay that wraps the entire app and provides real-time
/// performance monitoring with a floating button and dashboard.
///
/// Usage:
/// ```dart
/// runApp(
///   DebugOverlay(
///     enabled: kDebugMode,
///     child: MyApp(),
///   ),
/// );
/// ```
class DebugOverlay extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const DebugOverlay({
    super.key,
    required this.child,
    this.enabled = kDebugMode,
  });

  @override
  State<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends State<DebugOverlay>
    with WidgetsBindingObserver {
  bool _showDashboard = false;
  bool _isExpanded =
      true; // false = collapsed (only FPS), true = expanded (all stats)
  Timer? _refreshTimer;
  double _fps = 0;
  int _rebuilds = 0;
  int _networkCalls = 0;

  // Frame tracking
  DateTime? _lastFrameTime;
  final List<Duration> _frameTimes = [];
  static const int _maxFrames = 60;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      WidgetsBinding.instance.addObserver(this);
      _startFrameTracking();
      _startRefreshTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startFrameTracking() {
    // Hook into Flutter's frame callback
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);
  }

  void _onFrame(Duration timestamp) {
    if (!mounted || !widget.enabled) return;

    final now = DateTime.now();
    if (_lastFrameTime != null) {
      final frameDuration = now.difference(_lastFrameTime!);
      _frameTimes.add(frameDuration);

      // Keep only recent frames
      while (_frameTimes.length > _maxFrames) {
        _frameTimes.removeAt(0);
      }

      // Record to PerformanceMonitor
      PerformanceMonitor.recordFrame(frameDuration);
    }
    _lastFrameTime = now;

    // Schedule next frame callback
    WidgetsBinding.instance.addPostFrameCallback(_onFrame);
  }

  double _calculateFps() {
    if (_frameTimes.isEmpty) return 0;

    final avgMicroseconds =
        _frameTimes.map((d) => d.inMicroseconds).reduce((a, b) => a + b) /
        _frameTimes.length;

    if (avgMicroseconds == 0) return 0;
    return 1000000.0 / avgMicroseconds;
  }

  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) {
        setState(() {
          _fps = _calculateFps();
          _rebuilds = WidgetTracker.getWidgetStats().fold(
            0,
            (sum, w) => sum + w.totalRebuilds,
          );
          _networkCalls = NetworkTracker.getMetrics().fold(
            0,
            (sum, n) => sum + n.totalRequests,
          );
        });
      }
    });
  }

  Color get _fpsColor {
    if (_fps >= 55) return Colors.green;
    if (_fps >= 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          // Mini stats badge (expanded or collapsed)
          if (!_showDashboard)
            Positioned(
              top: 50,
              right: 10,
              child: _isExpanded
                  ? _MiniStatsBadge(
                      fps: _fps,
                      rebuilds: _rebuilds,
                      apiCalls: _networkCalls,
                      onTap: () => setState(() => _showDashboard = true),
                      onCollapse: () => setState(() => _isExpanded = false),
                    )
                  : _CollapsedBadge(
                      fps: _fps,
                      fpsColor: _fpsColor,
                      onTap: () => setState(() => _isExpanded = true),
                      onLongPress: () => setState(() => _showDashboard = true),
                    ),
            ),
          // Full dashboard
          if (_showDashboard)
            _PerformanceDashboard(
              fps: _fps,
              totalRebuilds: _rebuilds,
              totalNetworkCalls: _networkCalls,
              onClose: () => setState(() => _showDashboard = false),
            ),
        ],
      ),
    );
  }
}

/// Collapsed badge showing only FPS
class _CollapsedBadge extends StatelessWidget {
  final double fps;
  final Color fpsColor;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _CollapsedBadge({
    required this.fps,
    required this.fpsColor,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: fpsColor.withValues(alpha: 0.5), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.speed, color: fpsColor, size: 12),
            const SizedBox(width: 4),
            Text(
              fps.toStringAsFixed(0),
              style: TextStyle(
                color: fpsColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatsBadge extends StatelessWidget {
  final double fps;
  final int rebuilds;
  final int apiCalls;
  final VoidCallback onTap;
  final VoidCallback onCollapse;

  const _MiniStatsBadge({
    required this.fps,
    required this.rebuilds,
    required this.apiCalls,
    required this.onTap,
    required this.onCollapse,
  });

  Color get _fpsColor {
    if (fps >= 55) return Colors.green;
    if (fps >= 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // FPS
            _MiniStat(
              icon: Icons.speed,
              value: fps.toStringAsFixed(0),
              label: 'FPS',
              color: _fpsColor,
            ),
            _divider(),
            // Rebuilds
            _MiniStat(
              icon: Icons.refresh,
              value: '$rebuilds',
              label: 'RB',
              color: Colors.blue,
            ),
            _divider(),
            // API Calls
            _MiniStat(
              icon: Icons.cloud,
              value: '$apiCalls',
              label: 'API',
              color: Colors.teal,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onCollapse,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.grey[400], size: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey.withValues(alpha: 0.3),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _MiniStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 12),
        const SizedBox(width: 4),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey[500], fontSize: 8, height: 1),
            ),
          ],
        ),
      ],
    );
  }
}

class _PerformanceDashboard extends StatelessWidget {
  final double fps;
  final int totalRebuilds;
  final int totalNetworkCalls;
  final VoidCallback onClose;

  const _PerformanceDashboard({
    required this.fps,
    required this.totalRebuilds,
    required this.totalNetworkCalls,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.9),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCards(),
                    const SizedBox(height: 24),
                    _buildSection('🐢 Slowest Operations', _buildSlowestOps()),
                    const SizedBox(height: 24),
                    _buildSection(
                      '🔄 Most Rebuilt Widgets',
                      _buildWidgetRebuilds(),
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      '🌐 Slowest Endpoints',
                      _buildSlowEndpoints(),
                    ),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.3),
        border: Border(bottom: BorderSide(color: Colors.deepPurple.shade300)),
      ),
      child: Row(
        children: [
          const Icon(Icons.analytics, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Performance Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            icon: Icons.speed,
            label: 'FPS',
            value: fps.toStringAsFixed(0),
            color: fps >= 55
                ? Colors.green
                : (fps >= 30 ? Colors.orange : Colors.red),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.refresh,
            label: 'Rebuilds',
            value: totalRebuilds.toString(),
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.cloud,
            label: 'API Calls',
            value: totalNetworkCalls.toString(),
            color: Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildSlowestOps() {
    final ops = PerformanceMonitor.getSlowestOperations(5);
    if (ops.isEmpty) {
      return _emptyMessage('No operations tracked yet');
    }
    return Column(
      children: ops
          .map(
            (op) => _MetricRow(
              name: op.name,
              value: '${op.averageTimeMs}ms avg',
              subValue: '${op.callCount} calls',
            ),
          )
          .toList(),
    );
  }

  Widget _buildWidgetRebuilds() {
    final widgets = WidgetTracker.getMostRebuiltWidgets(5);
    if (widgets.isEmpty) {
      return _emptyMessage('No widgets tracked yet');
    }
    return Column(
      children: widgets
          .map(
            (w) => _MetricRow(
              name: w.widgetName,
              value: '${w.totalRebuilds} rebuilds',
              subValue: w.context,
              isWarning: w.rebuildsPerSecond > 10,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSlowEndpoints() {
    final endpoints = NetworkTracker.getSlowestEndpoints(5);
    if (endpoints.isEmpty) {
      return _emptyMessage('No network requests tracked yet');
    }
    return Column(
      children: endpoints
          .map(
            (e) => _MetricRow(
              name: '${e.method} ${e.endpoint}',
              value: '${e.averageTimeMs}ms',
              subValue:
                  '${e.totalRequests} calls, ${e.errorRate.toStringAsFixed(0)}% errors',
              isWarning: e.errorRate > 5,
            ),
          )
          .toList(),
    );
  }

  Widget _emptyMessage(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: Colors.grey[400])),
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _ActionButton(
          icon: Icons.print,
          label: 'Print Reports',
          onTap: () {
            PerformanceMonitor.printReport();
            WidgetTracker.printReport();
            NetworkTracker.printReport();
          },
        ),
        _ActionButton(
          icon: Icons.delete_outline,
          label: 'Clear Data',
          onTap: () {
            PerformanceMonitor.clear();
            WidgetTracker.clear();
            NetworkTracker.clear();
          },
          color: Colors.red,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String name;
  final String value;
  final String? subValue;
  final bool isWarning;

  const _MetricRow({
    required this.name,
    required this.value,
    this.subValue,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: isWarning ? Border.all(color: Colors.orange) : null,
      ),
      child: Row(
        children: [
          if (isWarning) ...[
            const Icon(Icons.warning, color: Colors.orange, size: 16),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
                if (subValue != null)
                  Text(
                    subValue!,
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isWarning ? Colors.orange : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
