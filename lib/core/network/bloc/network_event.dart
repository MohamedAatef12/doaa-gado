part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkObserve extends NetworkEvent {}

class _NetworkStatusChanged extends NetworkEvent {
  final NetworkStatus status;

  const _NetworkStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class NetworkCheckLatency extends NetworkEvent {}
