import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/padding.dart';
import '../constants/sized_box.dart';
import '../constants/text_styles.dart';
import '../themes/app_colors.dart';
import 'custom_filled_button.dart';
import '../assets/icons.dart';

import 'dart:ui';

class CustomSuccessDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;
  final String? iconPath;

  const CustomSuccessDialog({
    super.key,
    required this.title,
    required this.description,
    this.buttonText = 'Done',
    required this.onPressed,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.current.white,
        insetPadding: PaddingConstants.horizontalLarge,
        child: Padding(
          padding: PaddingConstants.large,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath ?? AppIcons.checkCircle,
                width: 120,
                height: 120,
              ),
              SizedBoxConstants.verticalMedium,
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.largeBold.copyWith(
                  color: AppColors.current.primary,
                ),
              ),
              SizedBoxConstants.verticalSmall,
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyles.medium.copyWith(
                  color: AppColors.current.primaryText.withValues(alpha: 0.6),
                  height: 1.5,
                ),
              ),
              SizedBoxConstants.verticalLarge,
              CustomFilledButton(
                onPressed: onPressed,
                text: buttonText,
                heightFactor: 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
