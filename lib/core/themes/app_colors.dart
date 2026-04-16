import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _current;
  static AppColors get current => _current ?? _defaultLightColors;

  AppColors({
    required this.primary,
    required this.primaryLight,
    required this.blueLight,
    required this.tealLight,
    required this.redLight,
    required this.orangeLight,
    required this.greenLight,
    required this.orange,
    required this.cardLight,
    required this.icons,
    required this.textRed,
    required this.blueGray,
    required MaterialColor swatch,
    required this.green,
    required this.primaryText,
    required this.primaryText2,
    required this.first,
    required this.second,
    required this.third,
    required this.textLight,
    required this.divider,
    required this.transparent,
    required this.white,
    required this.gray,
    required this.withdrawGradientStart,
    required this.withdrawGradientEnd,
    required this.blue,
    required this.splashTopArc,
    required this.splashBottomArc,
    required this.splashBackground,
    // Islamic Theme colors
    required this.brownPrimary,
    required this.brownLight,
    required this.brownDark,
    required this.goldAccent,
    required this.creamBackground,
    // Private Ride feature colors
    required this.privateAccent,
    required this.privateAccentGlow,
    required this.privateMapDarkPanel,
    required this.privateMapPanelBorder,
    required this.privateInactiveTab,
  });

  Color primary;
  Color primaryLight;
  Color blueLight; // 0xff4A89E6 with alpha
  Color blue; // 0xff4A89E6 solid
  Color tealLight;
  Color redLight;
  Color orangeLight;
  Color greenLight;
  Color orange;
  Color cardLight;
  Color icons;
  Color primaryText;
  Color primaryText2;
  Color textLight;
  Color blueGray;
  Color textRed;
  Color green;
  Color first;
  Color second;
  Color third;
  Color divider;
  Color transparent;
  Color white;
  Color gray;
  Color withdrawGradientStart;
  Color withdrawGradientEnd;
  Color splashTopArc;
  Color splashBottomArc;
  Color splashBackground;

  // Islamic Theme colors
  Color brownPrimary;
  Color brownLight;
  Color brownDark;
  Color goldAccent;
  Color creamBackground;

  // Private Ride feature colors
  Color privateAccent;        // #04AB97 — teal CTA, active tab border
  Color privateAccentGlow;    // rgba(4,171,151,0.25) — button glow/shadow
  Color privateMapDarkPanel;  // rgba(0,0,0,0.27) — dark glass panel bg
  Color privateMapPanelBorder; // rgba(255,255,255,0.30) — glass panel border
  Color privateInactiveTab;   // rgba(255,255,255,0.30) — inactive service tab
}

var _defaultLightColors = AppColors(
  swatch: const MaterialColor(0xffdcebf2, <int, Color>{
    50: Color(0xffdcebf2),
    100: Color(0xffdcebf2),
    200: Color(0xffdcebf2),
    300: Color(0xffdcebf2),
    400: Color(0xffdcebf2),
    500: Color(0xffdcebf2),
    600: Color(0xffdcebf2),
    700: Color(0xffdcebf2),
    800: Color(0xffdcebf2),
    900: Color(0xffdcebf2),
  }),
  primary: const Color(0xff8280E3),
  primaryLight: const Color(0xff8280E3).withValues(alpha: 0.15),
  blueLight: const Color(0xff4A89E6).withValues(alpha: 0.15),
  blue: const Color(0xff4A89E6),
  tealLight: const Color(0xff3B87A5).withValues(alpha: 0.15),
  redLight: const Color(0xffCA5656).withValues(alpha: 0.15),
  orangeLight: const Color(0xffF57C00).withValues(alpha: 0.15),
  orange: const Color(0xffF57C00),
  cardLight: const Color(0xffF7F9FA),
  icons: const Color(0xff303132),
  primaryText: const Color(0xff303132),
  primaryText2: const Color(0xff949596),
  textRed: const Color(0xffCA5656),
  green: const Color(0xff00884C),
  greenLight: const Color(0xff00884C).withValues(alpha: 0.15),
  blueGray: const Color(0xff3B87A5),
  first: const Color(0xffF9C318),
  second: const Color(0xff929292),
  third: const Color(0xffC5956D),
  divider: const Color(0xff58595A),
  textLight: const Color(0xff58595A),
  transparent: Colors.transparent,
  white: Colors.white,
  gray: const Color(0xffE3E5E6),
  withdrawGradientStart: const Color(0xFFEFF6FF),
  withdrawGradientEnd: const Color(0xFFFAF5FF),
  splashTopArc: const Color(0xFF151515),
  splashBottomArc: const Color.fromARGB(255, 22, 22, 22),
  splashBackground: const Color(0xFF000000),
  // Islamic Theme
  brownPrimary: const Color(0xff5D4037),
  brownLight: const Color(0xff8D6E63),
  brownDark: const Color(0xff3E2723),
  goldAccent: const Color(0xffD4AF37),
  creamBackground: const Color(0xffF5F5DC),
  // Private Ride
  privateAccent: const Color(0xFF04AB97),
  privateAccentGlow: const Color(0x4004AB97),
  privateMapDarkPanel: const Color(0x45000000),
  privateMapPanelBorder: const Color(0x4DFFFFFF),
  privateInactiveTab: const Color(0x4DFFFFFF),
);
