import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class TextStyles {
  // Regular Text Styles
  static TextStyle small = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,
    color: AppColors.current.primaryText,
  );
  static TextStyle medium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle large = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle extraLarge = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );

  // Bold Text Styles
  static TextStyle smallBold = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle mediumBold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle largeBold = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle extraLargeBold = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );

  // Italic Text Styles
  static TextStyle smallItalic = TextStyle(
    fontSize: 12.0,
    fontStyle: FontStyle.italic,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle mediumItalic = TextStyle(
    fontSize: 16.0,
    fontStyle: FontStyle.italic,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );
  static TextStyle largeItalic = TextStyle(
    fontSize: 20.0,
    fontFamily: GoogleFonts.inter().fontFamily,

    fontStyle: FontStyle.italic,
    color: AppColors.current.primaryText,
  );
  static TextStyle extraLargeItalic = TextStyle(
    fontSize: 24.0,
    fontStyle: FontStyle.italic,
    fontFamily: GoogleFonts.inter().fontFamily,

    color: AppColors.current.primaryText,
  );

  // Customizable Text Styles
  static TextStyle custom({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
    );
  }
}

/// Typography for the Private Ride feature.
/// Uses Barlow — closest geometric sans substitute for Uber Move Text.
class RideTextStyles {
  RideTextStyles._();

  /// Tab label — 14sp Regular, used for service type tabs
  static TextStyle get tabLabel => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );

  /// Active tab label — 14sp SemiBold, teal color
  static TextStyle get tabLabelActive => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF04AB97),
      );

  /// Exchange rate value — 28sp Medium (rate display row)
  static TextStyle get exchangeRateValue => GoogleFonts.barlow(
        fontSize: 28.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  /// Exchange rate label — 14sp Regular (e.g. "1 USD = X SAR")
  static TextStyle get exchangeRateLabel => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      );

  /// Currency code — 20sp Bold (in currency list items)
  static TextStyle get currencyCode => GoogleFonts.barlow(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  /// Currency name — 14sp Regular (in currency list items)
  static TextStyle get currencyName => GoogleFonts.barlow(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      );

  /// CTA button — 16sp SemiBold (Get My Ride button)
  static TextStyle get ctaButton => GoogleFonts.barlow(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      );

  /// Panel section header — 16sp Medium
  static TextStyle get panelHeader => GoogleFonts.barlow(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  /// Custom Barlow — for one-off ride screen text
  static TextStyle custom({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.white,
    double? letterSpacing,
  }) =>
      GoogleFonts.barlow(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
