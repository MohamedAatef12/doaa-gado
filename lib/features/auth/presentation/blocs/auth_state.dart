import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final String mobile;
  final String code;
  final String fullName;
  final DateTime? birthdate;
  final AuthStatus status;
  final String? message;

  const AuthState({
    this.mobile = '',
    this.code = '',
    this.fullName = '',
    this.birthdate,
    this.status = AuthStatus.initial,
    this.message,
  });

  AuthState copyWith({
    String? mobile,
    String? code,
    String? fullName,
    DateTime? birthdate,
    AuthStatus? status,
    String? message,
  }) {
    return AuthState(
      mobile: mobile ?? this.mobile,
      code: code ?? this.code,
      fullName: fullName ?? this.fullName,
      birthdate: birthdate ?? this.birthdate,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [mobile, code, fullName, birthdate, status, message];
}
