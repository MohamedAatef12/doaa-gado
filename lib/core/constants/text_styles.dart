import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class TextStyles {
  // Regular Text Styles
  static TextStyle small = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.current.primaryText,
  );
  static TextStyle medium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.current.primaryText,
  );
  static TextStyle large = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    color: AppColors.current.primaryText,
  );
  static TextStyle extraLarge = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
    color: AppColors.current.primaryText,
  );

  // Bold Text Styles
  static TextStyle smallBold = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: AppColors.current.primaryText,
  );
  static TextStyle mediumBold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.current.primaryText,
  );
  static TextStyle largeBold = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.current.primaryText,
  );
  static TextStyle extraLargeBold = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.current.primaryText,
  );

  // Italic Text Styles
  static TextStyle smallItalic = TextStyle(
    fontSize: 12.0,
    fontStyle: FontStyle.italic,
    color: AppColors.current.primaryText,
  );
  static TextStyle mediumItalic = TextStyle(
    fontSize: 16.0,
    fontStyle: FontStyle.italic,
    color: AppColors.current.primaryText,
  );
  static TextStyle largeItalic = TextStyle(
    fontSize: 20.0,
    fontStyle: FontStyle.italic,
    color: AppColors.current.primaryText,
  );
  static TextStyle extraLargeItalic = TextStyle(
    fontSize: 24.0,
    fontStyle: FontStyle.italic,
    color: AppColors.current.primaryText,
  );

  // Title Style using Aref Ruqaa
  static TextStyle titleStyle = const TextStyle(
    fontFamily: 'Aref Ruqaa',
    fontWeight: FontWeight.bold,
  );

  // Customizable Text Styles
  static TextStyle custom({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    Color color = Colors.black,
    String? fontFamily,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      fontFamily: fontFamily,
    );
  }
}

/// Typography for the Private Ride feature.
class RideTextStyles {
  RideTextStyles._();

  static TextStyle get tabLabel => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );

  static TextStyle get tabLabelActive => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF04AB97),
      );

  static TextStyle get exchangeRateValue => GoogleFonts.barlow(
        fontSize: 28.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get exchangeRateLabel => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      );

  static TextStyle get currencyCode => GoogleFonts.barlow(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle get currencyName => const TextStyle(
        fontFamily: 'Aref Ruqaa',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      );

  static TextStyle get ctaButton => const TextStyle(
        fontFamily: 'Aref Ruqaa',
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      );

  static TextStyle get panelHeader => const TextStyle(
        fontFamily: 'Aref Ruqaa',
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle custom({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.white,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily: 'Aref Ruqaa',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
