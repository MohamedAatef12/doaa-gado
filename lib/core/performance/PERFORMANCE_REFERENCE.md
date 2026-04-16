# 📊 Trigo Performance Monitoring Reference

A comprehensive in-app performance monitoring system for tracking function execution, widget rebuilds, and network performance.

---

## 🚀 Quick Start

```dart
import 'package:trigo/core/performance/performance.dart';

// Measure function execution
final result = await PerformanceMonitor.measureAsync('fetchUsers', () async {
  return await api.getUsers();
});

// Track widget rebuilds
WidgetTracker.trackRebuild('HomeView');

// Track network requests
NetworkTracker.trackRequest(
  endpoint: '/api/users',
  method: 'GET',
  statusCode: 200,
  duration: Duration(milliseconds: 150),
);

// Print all reports
PerformanceMonitor.printReport();
WidgetTracker.printReport();
NetworkTracker.printReport();
```

---

## 📁 File Structure

```
lib/core/performance/
├── performance.dart           # Barrel export (import this)
├── performance_monitor.dart   # Function timing & frame tracking
├── widget_tracker.dart        # Widget rebuild tracking
├── network_tracker.dart       # API request tracking
└── PERFORMANCE_REFERENCE.md   # This file
```

---

## ⏱️ PerformanceMonitor

### Measuring Functions

```dart
// Async function
final user = await PerformanceMonitor.measureAsync('getUser', () async {
  return await api.fetchUser(id);
});

// Sync function
final result = PerformanceMonitor.measure('parseJson', () {
  return json.decode(data);
});

// Manual timing
PerformanceMonitor.startTimer('complexOperation');
// ... do work ...
PerformanceMonitor.stopTimer('complexOperation');
```

### Frame Tracking

```dart
// Record frame times (usually done automatically)
PerformanceMonitor.recordFrame(Duration(milliseconds: 16));

// Get current FPS
print('FPS: ${PerformanceMonitor.currentFps}');

// Get detailed frame stats
final stats = PerformanceMonitor.frameStats;
print('Avg: ${stats?.averageFrameTime.inMilliseconds}ms');
print('Dropped: ${stats?.droppedFrames}');
```

### Reports

```dart
// Get slowest operations
final slow = PerformanceMonitor.getSlowestOperations(10);

// Get most called operations
final frequent = PerformanceMonitor.getMostCalledOperations(10);

// Get most time-consuming (total)
final expensive = PerformanceMonitor.getMostTimeConsumingOperations(10);

// Print full report
PerformanceMonitor.printReport();

// Export as JSON
final json = PerformanceMonitor.exportMetrics();
```

---

## 🔄 WidgetTracker

### Tracking Rebuilds

```dart
// Method 1: Direct call in build()
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetTracker.trackRebuild('MyWidget');
    return Container();
  }
}

// Method 2: Using mixin
class MyWidget extends StatelessWidget with RebuildTracker {
  @override
  Widget build(BuildContext context) {
    trackRebuild(); // Uses widget's runtimeType automatically
    return Container();
  }
}

// Method 3: Wrapper widget
TrackRebuilds(
  name: 'ExpensiveWidget',
  child: MyExpensiveWidget(),
)
```

### Reports

```dart
// Get most rebuilt widgets
final stats = WidgetTracker.getMostRebuiltWidgets(10);

// Get widgets rebuilding too fast
final excessive = WidgetTracker.getExcessiveRebuilders();

// Print report
WidgetTracker.printReport();
```

### Configuration

```dart
// Set rebuild warning threshold (default: 10/sec)
WidgetTracker.rebuildThreshold = 15;

// Enable/disable
WidgetTracker.isEnabled = true;
WidgetTracker.isDebugMode = true;
```

---

## 🌐 NetworkTracker

### Tracking Requests

```dart
// Track a completed request
NetworkTracker.trackRequest(
  endpoint: '/api/users',
  method: 'GET',
  statusCode: 200,
  duration: Duration(milliseconds: 150),
  responseSizeBytes: 2048,
);

// Integration with Dio
dio.interceptors.add(InterceptorsWrapper(
  onResponse: (response, handler) {
    NetworkTracker.trackRequest(
      endpoint: response.requestOptions.path,
      method: response.requestOptions.method,
      statusCode: response.statusCode ?? 0,
      duration: /* calculate from request start */,
    );
    handler.next(response);
  },
));
```

### Reports

```dart
// Get slowest endpoints
final slow = NetworkTracker.getSlowestEndpoints(10);

// Get error-prone endpoints
final errors = NetworkTracker.getMostErrorProneEndpoints(10);

// Get most called endpoints
final frequent = NetworkTracker.getMostCalledEndpoints(10);

// Print report
NetworkTracker.printReport();
```

### Configuration

```dart
// Set slow request threshold (default: 1000ms)
NetworkTracker.slowRequestThresholdMs = 2000;

// Enable/disable
NetworkTracker.isEnabled = true;
NetworkTracker.isDebugMode = true;
```

---

## 📊 Sample Reports

### Performance Monitor Report
```
============================================================
📊 PERFORMANCE REPORT
============================================================

🎬 Frame Statistics:
   FPS: 59.8
   Avg Frame: 16ms
   Max Frame: 32ms
   P95 Frame: 18ms
   Dropped: 3/120

🐢 Slowest Operations (by avg):
   fetchUserProfile: 450ms avg (12 calls)
   loadDashboard: 380ms avg (5 calls)
   processImage: 220ms avg (8 calls)

🔥 Most Called Operations:
   validateInput: 156 calls (2ms avg)
   formatDate: 89 calls (1ms avg)
   parseJson: 67 calls (3ms avg)

⏰ Most Time Consuming (total):
   fetchUserProfile: 5400ms total (12 calls)
   loadDashboard: 1900ms total (5 calls)
   processImage: 1760ms total (8 calls)
============================================================
```

### Widget Tracker Report
```
============================================================
🔄 WIDGET REBUILD REPORT
============================================================

⚠️ Excessive Rebuilders (>10/sec):
   AnimatedCounter: 45.2/sec
   LivePriceWidget: 22.8/sec

🔥 Most Rebuilt Widgets:
   HomeView: 234 rebuilds
   UserCard: 156 rebuilds
   ProductTile: 89 rebuilds
============================================================
```

### Network Tracker Report
```
============================================================
🌐 NETWORK PERFORMANCE REPORT
============================================================

📊 Summary:
   Total Requests: 156
   Total Errors: 3 (1.9%)
   Data Transferred: 2.4 MB

🐢 Slowest Endpoints:
   GET /api/dashboard: 890ms avg
   POST /api/upload: 650ms avg
   GET /api/search: 340ms avg

❌ Highest Error Rate:
   POST /api/payment: 8.3% errors
   GET /api/external: 4.2% errors

🔥 Most Called:
   GET /api/feed: 45 calls
   GET /api/user: 32 calls
   POST /api/analytics: 28 calls
============================================================
```

---

## 🎨 Best Practices

### What to Track

| Track | When |
|-------|------|
| Database queries | Always |
| API calls | Always |
| Image processing | When noticeable |
| Complex calculations | When > 10ms |
| Widget rebuilds | During development |
| Frame times | In profile mode |

### What NOT to Track

❌ Don't track every tiny operation  
❌ Don't track in release builds  
❌ Don't leave tracking enabled in production  
❌ Don't track synchronous operations < 1ms  

### Performance Tips

```dart
// 1. Disable in release mode
assert(() {
  PerformanceMonitor.isEnabled = true;
  WidgetTracker.isEnabled = true;
  NetworkTracker.isEnabled = true;
  return true;
}());

// 2. Clear periodically to free memory
void dispose() {
  PerformanceMonitor.clear();
  WidgetTracker.clear();
  NetworkTracker.clear();
}

// 3. Export metrics before clearing
void exportAndClear() {
  final data = PerformanceMonitor.exportMetrics();
  // Send to analytics...
  PerformanceMonitor.clear();
}
```

---

## 🔧 Integration Examples

### With Dio

```dart
class PerformanceInterceptor extends Interceptor {
  final _timers = <String, DateTime>{};

  @override
  void onRequest(RequestOptions options, handler) {
    _timers[options.hashCode.toString()] = DateTime.now();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, handler) {
    final start = _timers.remove(response.requestOptions.hashCode.toString());
    if (start != null) {
      NetworkTracker.trackRequest(
        endpoint: response.requestOptions.path,
        method: response.requestOptions.method,
        statusCode: response.statusCode ?? 0,
        duration: DateTime.now().difference(start),
        responseSizeBytes: response.data?.toString().length,
      );
    }
    super.onResponse(response, handler);
  }
}
```

### With BLoC

```dart
class PerformanceBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    PerformanceMonitor.startTimer('${bloc.runtimeType}.$event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    PerformanceMonitor.stopTimer('${bloc.runtimeType}.*');
    super.onChange(bloc, change);
  }
}
```

---

## 📱 Debug Overlay Widget

```dart
class PerformanceOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 10,
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.black87,
        child: Text(
          'FPS: ${PerformanceMonitor.currentFps.toStringAsFixed(0)}',
          style: TextStyle(color: Colors.green, fontSize: 12),
        ),
      ),
    );
  }
}
```

---

*Use this system during development to identify bottlenecks, then disable in production.*
