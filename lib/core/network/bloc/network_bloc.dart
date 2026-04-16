import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../network_repository.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final NetworkRepository _networkRepository;
  StreamSubscription<NetworkStatus>? _networkSubscription;

  NetworkBloc(this._networkRepository) : super(const NetworkState()) {
    on<NetworkObserve>(_onObserve);
    on<_NetworkStatusChanged>(_onStatusChanged);
    on<NetworkCheckLatency>(_onCheckLatency);
  }

  void _onObserve(NetworkObserve event, Emitter<NetworkState> emit) {
    _networkRepository.initialize();
    _networkSubscription?.cancel();
    _networkSubscription = _networkRepository.statusStream.listen((status) {
      add(_NetworkStatusChanged(status));
    });
  }

  void _onStatusChanged(
    _NetworkStatusChanged event,
    Emitter<NetworkState> emit,
  ) {
    switch (event.status) {
      case NetworkStatus.online:
        emit(state.copyWith(status: NetworkStatus.online, message: null));
        break;
      case NetworkStatus.offline:
        emit(
          state.copyWith(
            status: NetworkStatus.offline,
            message: 'No Internet Connection',
          ),
        );
        break;
      case NetworkStatus.lowQuality:
        emit(
          state.copyWith(
            status: NetworkStatus.lowQuality,
            message: 'Unstable Connection',
          ),
        );
        break;
      case NetworkStatus.initial:
        // Do nothing or separate logic
        break;
    }
  }

  Future<void> _onCheckLatency(
    NetworkCheckLatency event,
    Emitter<NetworkState> emit,
  ) async {
    // Manually trigger a check if needed, mainly for "Retry" buttons
    await _networkRepository.checkStatus();
  }

  @override
  Future<void> close() {
    _networkSubscription?.cancel();
    _networkRepository.dispose();
    return super.close();
  }
}
