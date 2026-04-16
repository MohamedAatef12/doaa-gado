import 'package:flutter/material.dart';

import '../network_status.dart';

class NetworkStatusToast extends StatelessWidget {
  final NetworkStatus status;
  final VoidCallback? onRetry;

  const NetworkStatusToast({super.key, required this.status, this.onRetry});

  @override
  Widget build(BuildContext context) {
    if (status == NetworkStatus.online) return const SizedBox.shrink();

    final isOffline = status == NetworkStatus.offline;
    final title = isOffline ? 'No Connection' : 'Unstable Connection';
    final message = isOffline
        ? 'You are currently offline.'
        : 'Connection is slow.';
    final icon = isOffline
        ? Icons.wifi_off_rounded
        : Icons.wifi_tethering_error_rounded;
    final color = isOffline ? Colors.redAccent : Colors.orangeAccent;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              if (isOffline && onRetry != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
