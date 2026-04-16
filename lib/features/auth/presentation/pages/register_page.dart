import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../config/di/di.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/custom_filled_button.dart';
import '../../../../core/utils/custom_text_form_field.dart';
import '../../../../core/utils/validators.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  Future<void> _selectDate(BuildContext context, AuthBloc bloc) async {
    final colors = AppColors.current;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colors.brownPrimary,
              onPrimary: colors.white,
              onSurface: colors.brownPrimary,
              secondary: colors.goldAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colors.brownPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      bloc.add(BirthdateChangedEvent(picked));
      bloc.birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: colors.brownPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message ?? ''), backgroundColor: colors.brownPrimary),
                  );
                  Navigator.pop(context);
                } else if (state.status == AuthStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message ?? ''), backgroundColor: Colors.red),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_outlined,
                      size: 60,
                      color: colors.goldAccent,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colors.brownPrimary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join us and start your spiritual journey',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.brownLight,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextFormField(
                      controller: bloc.fullNameController,
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icon(Icons.person_outline, color: colors.brownPrimary),
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
                      controller: bloc.birthdateController,
                      labelText: 'Birthdate',
                      hintText: 'Select your birthdate',
                      readOnly: true,
                      onTap: () => _selectDate(context, bloc),
                      prefixIcon: Icon(Icons.calendar_today_outlined, color: colors.brownPrimary),
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
                          text: 'Register',
                          isLoading: state.status == AuthStatus.loading,
                          backgroundColor: colors.brownPrimary,
                          onPressed: () {
                            context.read<AuthBloc>().add(RegisterSubmittedEvent());
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
