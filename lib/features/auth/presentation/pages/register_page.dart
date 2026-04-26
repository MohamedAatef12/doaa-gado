import 'dart:ui';
import 'package:doaa_gado/core/assets/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/di/di.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/auth_toast.dart';
import '../../../../core/utils/custom_filled_button.dart';
import '../../../../core/utils/custom_text_form_field.dart';
import '../../../../core/utils/validators.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/routes.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  Future<void> _selectDate(BuildContext context, AuthBloc bloc) async {
    final colors = AppColors.current;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: colors.creamBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('cancel'.tr(), style: TextStyle(color: colors.brownLight)),
                    ),
                    Text(
                      'select_birthdate'.tr(),
                      style:  TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors.brownPrimary, // Brown Primary
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('done'.tr(), style: TextStyle(color: colors.goldAccent, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: bloc.state.birthdate ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime picked) {
                    bloc.add(BirthdateChangedEvent(picked));
                    bloc.birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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
            body: Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon:  Icon(Icons.arrow_back_ios, color:AppColors.current.brownDark),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Center(child: Image.asset(AppAssets.logo, width: 240.w, height: 180.h,fit: BoxFit.cover,)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.brown.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'create_account'.tr(),
                                      style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.current.white,
                                        fontFamily: 'Aref Ruqaa',
                                      ),
                                    ),
                                     SizedBox(height: 10.h),
                                    Text(
                                      'join_us'.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.current.white.withValues(alpha: 0.9),
                                      ),
                                    ),
                                     SizedBox(height: 20.h),
                                    
                                    CustomTextFormField(
                                      controller: bloc.fullNameController,
                                      hintText: 'enter_full_name'.tr(),
                                      prefixIcon: Icon(Icons.person_outline, color: colors.brownPrimary),
                                      validator: Validators.validateName,
                                      fillColor: true,
                                      fillColorValue: Colors.white.withValues(alpha: 0.1),
                                      style:  TextStyle(color: AppColors.current.white),
                                      labelStyle:  TextStyle(color: AppColors.current.white),
                                      hintStyle:  TextStyle(color: AppColors.current.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colors.brownPrimary),
                                        borderRadius: BorderRadius.circular(15),
                                      ),

                                    ),
                                     SizedBox(height: 16.h),
                                    CustomTextFormField(
                                      controller: bloc.mobileController,
                                      hintText: 'enter_mobile'.tr(),
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: Icon(Icons.phone_outlined, color: colors.brownPrimary),
                                      validator: Validators.validatePhone,
                                      fillColor: true,
                                      fillColorValue: colors.white.withValues(alpha: 0.1),
                                      style:  TextStyle(color: colors.white),
                                      labelStyle:  TextStyle(color: colors.white),
                                      hintStyle:  TextStyle(color: colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colors.brownPrimary),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextFormField(
                                      controller: bloc.birthdateController,
                                      labelText: 'birthdate'.tr(),
                                      hintText: 'select_birthdate'.tr(),
                                      readOnly: true,
                                      onTap: () => _selectDate(context, bloc),
                                      prefixIcon: Icon(Icons.calendar_today_outlined, color: colors.brownPrimary),
                                      fillColor: true,
                                      fillColorValue: Colors.white.withValues(alpha: 0.1),
                                      style:  TextStyle(color: colors.white),
                                      labelStyle:  TextStyle(color: colors.white),
                                      hintStyle:  TextStyle(color: colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colors.white.withValues(alpha: 0.3)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colors.brownPrimary),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        return CustomFilledButton(
                                          text: 'register'.tr(),
                                          isLoading: state.status == AuthStatus.loading,
                                          backgroundColor: colors.goldAccent,
                                          textColor: colors.brownPrimary,
                                          onPressed: () {
                                            context.read<AuthBloc>().add(RegisterSubmittedEvent());
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),

                // Listeners
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == AuthStatus.success) {
                      AuthToast.showSuccess(context, state.message ?? 'register_success'.tr());
                      context.goNamed(AppRouteNames.login);
                    } else if (state.status == AuthStatus.error) {
                      AuthToast.showError(context, state.message ?? '');
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
