import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/custom_filled_button.dart';
import '../../../../core/utils/custom_text_form_field.dart';
import '../../../../core/utils/validators.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.current;

    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<AuthBloc>();
          
          return Scaffold(
            backgroundColor: colors.creamBackground,
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message ?? ''), backgroundColor: colors.brownPrimary),
                  );
                } else if (state.status == AuthStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message ?? ''), backgroundColor: Colors.red),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.creamBackground,
                        colors.brownLight.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mosque_outlined,
                        size: 80,
                        color: colors.goldAccent,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colors.brownPrimary,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue your spiritual journey',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.brownLight,
                        ),
                      ),
                      const SizedBox(height: 48),
                      CustomTextFormField(
                        controller: bloc.mobileController,
                        labelText: 'Phone Number',
                        hintText: 'Enter your mobile number',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(Icons.phone_outlined, color: colors.brownPrimary),
                        validator: Validators.validatePhone,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.brownLight.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.goldAccent, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: bloc.codeController,
                        labelText: 'Code',
                        hintText: 'Enter your login code',
                        keyboardType: TextInputType.number,
                        prefixIcon: Icon(Icons.lock_outline, color: colors.brownPrimary),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.brownLight.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.goldAccent, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CustomFilledButton(
                            text: 'Login',
                            isLoading: state.status == AuthStatus.loading,
                            backgroundColor: colors.brownPrimary,
                            onPressed: () {
                              context.read<AuthBloc>().add(LoginSubmittedEvent());
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: colors.brownLight),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterPage()),
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: colors.goldAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
