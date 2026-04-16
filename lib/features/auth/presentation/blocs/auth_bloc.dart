import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  // UI Controllers hosted in Bloc for Stateless UI support
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        super(const AuthState()) {
    // These events are now secondary as we use controllers, 
    // but kept for backward compatibility if needed.
    on<MobileChangedEvent>((event, emit) => emit(state.copyWith(mobile: event.mobile)));
    on<CodeChangedEvent>((event, emit) => emit(state.copyWith(code: event.code)));
    on<FullNameChangedEvent>((event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<BirthdateChangedEvent>((event, emit) => emit(state.copyWith(birthdate: event.birthdate)));
    
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
  }

  @override
  Future<void> close() {
    mobileController.dispose();
    codeController.dispose();
    fullNameController.dispose();
    birthdateController.dispose();
    return super.close();
  }

  void clearControllers() {
    mobileController.clear();
    codeController.clear();
    fullNameController.clear();
    birthdateController.clear();
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final mobile = mobileController.text;
    final code = codeController.text;

    if (mobile.isEmpty || code.isEmpty) return;

    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _loginUseCase(
      mobile: mobile,
      code: int.tryParse(code) ?? 0,
    );

    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) {
        clearControllers();
        emit(state.copyWith(status: AuthStatus.success, message: 'Login successful'));
      },
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final fullName = fullNameController.text;
    final mobile = mobileController.text;
    // state.birthdate is still needed for DateTime logic, unless we parse it.
    // Better to keep birthdate in state and only use controllers for strings.
    
    if (fullName.isEmpty || mobile.isEmpty || state.birthdate == null) return;

    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _registerUseCase(
      fullName: fullName,
      mobile: mobile,
      birthdate: state.birthdate!,
    );

    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.error, message: failure.message)),
      (success) {
        clearControllers();
        emit(state.copyWith(status: AuthStatus.success, message: 'Registration successful'));
      },
    );
  }
}
