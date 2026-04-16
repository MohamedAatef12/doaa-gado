import 'package:flutter/material.dart';

import '../constants/radius.dart';
import '../themes/app_colors.dart';
import 'custom_text_form_field.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: hintText,
      fillColor: true,
      fillColorValue: AppColors.current.white,
      border: OutlineInputBorder(
        borderRadius: RadiusConstants.medium,
        borderSide: BorderSide(color: AppColors.current.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: RadiusConstants.medium,
        borderSide: BorderSide(color: AppColors.current.primary, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: RadiusConstants.medium,
        borderSide: BorderSide(color: AppColors.current.primary),
      ),
      enabled: true,

      // prefixIcon: Icon(
      //   IconlyBroken.search,
      //   color: AppColors.current.secondaryText,
      // ),
    );
  }
}
