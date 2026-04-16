import 'package:flutter/material.dart';

class RadiusConstants {
  // Uniform BorderRadius
  //change small to 8

  static const BorderRadius xs = BorderRadius.all(Radius.circular(8));
  static const BorderRadius small = BorderRadius.all(Radius.circular(16));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(32));
  static const BorderRadius large = BorderRadius.all(Radius.circular(48));
  static const BorderRadius pill = BorderRadius.all(Radius.circular(100));

  static const BorderRadius none = BorderRadius.zero;

  // Specific Corner BorderRadius (Only one corner)
  static const BorderRadius topLeft = BorderRadius.only(
    topLeft: Radius.circular(16.0),
  );
  static const BorderRadius topRight = BorderRadius.only(
    topRight: Radius.circular(16.0),
  );
  static const BorderRadius bottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(16.0),
  );
  static const BorderRadius bottomRight = BorderRadius.only(
    bottomRight: Radius.circular(16.0),
  );

  // Combinations of Two Corners
  static const BorderRadius topCorners = BorderRadius.only(
    topLeft: Radius.circular(16.0),
    topRight: Radius.circular(16.0),
  );

  static const BorderRadius bottomCorners = BorderRadius.only(
    bottomLeft: Radius.circular(16.0),
    bottomRight: Radius.circular(16.0),
  );

  static const BorderRadius leftCorners = BorderRadius.only(
    topLeft: Radius.circular(16.0),
    bottomLeft: Radius.circular(16.0),
  );

  static const BorderRadius rightCorners = BorderRadius.only(
    topRight: Radius.circular(16.0),
    bottomRight: Radius.circular(16.0),
  );

  // Asymmetric BorderRadius
  static const BorderRadius asymmetric = BorderRadius.only(
    topLeft: Radius.circular(8.0),
    topRight: Radius.circular(16.0),
    bottomLeft: Radius.circular(24.0),
    bottomRight: Radius.circular(32.0),
  );
}
