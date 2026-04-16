import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/network_bloc.dart';
import '../network_status.dart';
import 'network_status_toast.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        return Stack(
          children: [
            child,
            if (state.status == NetworkStatus.offline ||
                state.status == NetworkStatus.lowQuality)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: NetworkStatusToast(
                    status: state.status,
                    onRetry: state.status == NetworkStatus.offline
                        ? () {
                            context.read<NetworkBloc>().add(
                              NetworkCheckLatency(),
                            );
                          }
                        : null,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
