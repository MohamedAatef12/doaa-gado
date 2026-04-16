part of 'network_bloc.dart';

class NetworkState extends Equatable {
  final NetworkStatus status;
  final String? message;

  const NetworkState({this.status = NetworkStatus.initial, this.message});

  NetworkState copyWith({NetworkStatus? status, String? message}) {
    return NetworkState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
