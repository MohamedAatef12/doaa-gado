import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MobileChangedEvent extends AuthEvent {
  final String mobile;
  MobileChangedEvent(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class CodeChangedEvent extends AuthEvent {
  final String code;
  CodeChangedEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class FullNameChangedEvent extends AuthEvent {
  final String fullName;
  FullNameChangedEvent(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

class BirthdateChangedEvent extends AuthEvent {
  final DateTime birthdate;
  BirthdateChangedEvent(this.birthdate);

  @override
  List<Object?> get props => [birthdate];
}

class LoginSubmittedEvent extends AuthEvent {}

class RegisterSubmittedEvent extends AuthEvent {}

class GetRandomAyahEvent extends AuthEvent {}
