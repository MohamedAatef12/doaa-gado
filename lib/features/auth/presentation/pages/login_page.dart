import 'dart:math';
import 'dart:ui';
import 'package:doaa_gado/core/assets/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/routes.dart';
import '../../../../config/di/di.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/auth_toast.dart';
import '../../../../core/utils/custom_filled_button.dart';
import '../../../../core/utils/custom_text_form_field.dart';
import '../../../../core/utils/validators.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.current;

    return BlocProvider<AuthBloc>(
      create: (context) => getIt<AuthBloc>()..add(GetRandomAyahEvent()),
      child: Builder(
        builder: (context) {
          final bloc = context.read<AuthBloc>();

          return Scaffold(
            body: Stack(
              children: [
                // Content
                SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          // Ayah Section
                          BlocBuilder<AuthBloc, AuthState>(
                            buildWhen: (previous, current) => previous.randomAyah != current.randomAyah,
                            builder: (context, state) {
                              if (state.randomAyah.isEmpty) return const SizedBox.shrink();
                              return Container(
                                padding: EdgeInsets.all(20.r),
                                decoration: BoxDecoration(
                                  color: Colors.brown.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.format_quote,
                                      color: colors.goldAccent,
                                      size: 30,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      state.randomAyah,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: colors.white,
                                        fontFamily: 'Aref Ruqaa',
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            offset: Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          Image.asset(
                            AppAssets.logo,
                            width: 240.w,
                            height: 180.h,
                            fit: BoxFit.cover,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.brown.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'welcome_back'.tr(),
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: colors.white,
                                        fontFamily: 'Aref Ruqaa',
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      'sign_in_continue'.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: colors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    CustomTextFormField(
                                      controller: bloc.mobileController,
                                      labelText: 'phone_number'.tr(),
                                      hintText: 'enter_mobile'.tr(),
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: Icon(
                                        Icons.phone_outlined,
                                        color: colors.brownPrimary,
                                      ),
                                      validator: Validators.validatePhone,
                                      fillColor: true,
                                      fillColorValue: colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                      style: TextStyle(color: colors.white),
                                      labelStyle: TextStyle(
                                        color: colors.white,
                                      ),
                                      hintStyle: TextStyle(color: colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    CustomTextFormField(
                                      controller: bloc.codeController,
                                      hintText: 'enter_code'.tr(),
                                      keyboardType: TextInputType.number,
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: colors.brownPrimary,
                                      ),
                                      fillColor: true,
                                      fillColorValue: colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                      style: TextStyle(color: colors.white),
                                      labelStyle: TextStyle(
                                        color: colors.white,
                                      ),
                                      hintStyle: TextStyle(color: colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: colors.brownPrimary,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                     SizedBox(height: 32.h),
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        return CustomFilledButton(
                                          text: 'login'.tr(),
                                          isLoading:
                                              state.status ==
                                              AuthStatus.loading,
                                          backgroundColor: colors.goldAccent,
                                          textColor: colors.brownPrimary,
                                          onPressed: () {
                                            context.read<AuthBloc>().add(
                                              LoginSubmittedEvent(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "no_account".tr(),
                                style: TextStyle(
                                  color: AppColors.current.brownDark,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed(AppRouteNames.signUp);
                                },
                                child: Text(
                                  'register'.tr(),
                                  style: TextStyle(
                                    color: colors.goldAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
                      AuthToast.showSuccess(
                        context,
                        state.message ?? 'login_success'.tr(),
                      );
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
