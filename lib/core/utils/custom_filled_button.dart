import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/radius.dart';
import '../constants/text_styles.dart';
import '../themes/app_colors.dart';

import '../constants/sized_box.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final double heightFactor;
  final String? iconAsset;

  const CustomFilledButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
    this.heightFactor = 0.065,
    this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    Widget? iconWidget;
    if (iconAsset != null) {
      if (iconAsset!.endsWith('.svg')) {
        iconWidget = SvgPicture.asset(iconAsset!, width: 24, height: 24);
      } else {
        iconWidget = Image.asset(iconAsset!, width: 24, height: 24);
      }
    }

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * heightFactor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.current.primary,
          foregroundColor: textColor ?? Colors.white,
          shadowColor: AppColors.current.transparent,
          splashFactory: InkSplash.splashFactory,
          shape: RoundedRectangleBorder(borderRadius: RadiusConstants.large),
          elevation: 0,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: textColor ?? Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconWidget != null) ...[
                    iconWidget,
                    SizedBoxConstants.horizontalSmall,
                  ],
                  Text(
                    text,
                    style: TextStyles.mediumBold.copyWith(
                      color: textColor ?? Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
