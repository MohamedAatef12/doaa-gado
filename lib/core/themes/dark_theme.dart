import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData darkTheme =
    FlexThemeData.dark(
      scheme: FlexScheme.blueM3,
      fontFamily: GoogleFonts.cairo().fontFamily,
      useMaterial3: true,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      appBarElevation: 0.5,
    ).copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.current.primary,
        selectionColor: AppColors.current.primary.withValues(alpha: 0.4),
        selectionHandleColor: AppColors.current.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:
            AppColors.current.cardLight, // Maybe different for dark?
        modalBackgroundColor: AppColors.current.cardLight,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
