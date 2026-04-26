import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/validators.dart';
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
    // Pick an initial random Ayah
    on<GetRandomAyahEvent>(_onGetRandomAyah);
    add(GetRandomAyahEvent());

    on<MobileChangedEvent>((event, emit) => emit(state.copyWith(mobile: event.mobile)));
    on<CodeChangedEvent>((event, emit) => emit(state.copyWith(code: event.code)));
    on<FullNameChangedEvent>((event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<BirthdateChangedEvent>((event, emit) => emit(state.copyWith(birthdate: event.birthdate)));
    
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
  }

  void _onGetRandomAyah(GetRandomAyahEvent event, Emitter<AuthState> emit) {
    final random = Random();
    final index = random.nextInt(26) + 1;
    emit(state.copyWith(randomAyah: 'ayah_$index'.tr()));
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

    final phoneError = Validators.validatePhone(mobile);
    if (phoneError != null) {
      emit(state.copyWith(status: AuthStatus.error, message: phoneError));
      return;
    }

    if (code.isEmpty) {
      emit(state.copyWith(status: AuthStatus.error, message: 'Please enter your login code'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, message: ''));
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
    
    final nameError = Validators.validateName(fullName);
    if (nameError != null) {
      emit(state.copyWith(status: AuthStatus.error, message: nameError));
      return;
    }

    final phoneError = Validators.validatePhone(mobile);
    if (phoneError != null) {
      emit(state.copyWith(status: AuthStatus.error, message: phoneError));
      return;
    }

    if (state.birthdate == null) {
      emit(state.copyWith(status: AuthStatus.error, message: 'Please select your birthdate'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, message: ''));
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
