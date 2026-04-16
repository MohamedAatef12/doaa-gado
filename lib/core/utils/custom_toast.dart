import 'package:flutter/material.dart';
import '../constants/padding.dart';
import '../themes/app_colors.dart';
import '../constants/text_styles.dart';
import '../constants/radius.dart';

class CustomToast {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.smallBold.copyWith(color: AppColors.current.white),
        ),
        backgroundColor: isError
            ? AppColors.current.textRed
            : AppColors.current.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: RadiusConstants.small),
        margin: PaddingConstants.medium,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showOnTop(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 70,
        left: 40,
        right: 40,
        child: Material(
          color: AppColors.current.transparent,
          child: Container(
            padding: PaddingConstants.medium,
            decoration: BoxDecoration(
              color: isError
                  ? AppColors.current.textRed
                  : AppColors.current.primaryText,
              borderRadius: RadiusConstants.small,
            ),
            child: Text(
              message,
              style: TextStyles.mediumBold.copyWith(
                color: AppColors.current.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
