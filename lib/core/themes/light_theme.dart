import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData lightTheme =
    FlexThemeData.light(
      fontFamily: GoogleFonts.inter().fontFamily,
      useMaterial3: true,
      scaffoldBackground: AppColors.current.white,
      appBarElevation: 0.5,
    ).copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.current.primary,
        selectionColor: AppColors.current.primaryLight,
        selectionHandleColor: AppColors.current.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.current.white,
        modalBackgroundColor: AppColors.current.white,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        clipBehavior: Clip.antiAlias,
        dragHandleColor: AppColors.current.gray,
        dragHandleSize: const Size(60, 5),
      ),
    );
