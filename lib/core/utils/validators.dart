import 'package:easy_localization/easy_localization.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'email_required'.tr();
    const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(emailRegex).hasMatch(value)) return 'invalid_email'.tr();
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'password_required'.tr();
    if (value.length < 8) return 'password_min_length'.tr();

    // Check for uppercase
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'pass_upper'.tr();
    }

    // Check for lowercase
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'pass_lower'.tr();
    }

    // Check for number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'pass_number'.tr();
    }

    // Check for special character (~#@$%&!*_?^-)
    if (!RegExp(r'[~#@$%&!*_?^\-]').hasMatch(value)) {
      return 'pass_special'.tr();
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) return 'password_required'.tr();
    if (value != original) return 'pass_mismatch'.tr();
    return null;
  }

  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) return 'field_required'.tr();
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'field_required'.tr();
    const phoneRegex = r'^[0-9]{11}$';
    if (!RegExp(phoneRegex).hasMatch(value)) {
      return 'invalid_phone'.tr();
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'field_required'.tr();
    
    // Regular expression to allow letters (including Arabic) and internal spaces
    const nameRegex = r'^[a-zA-Z\u0600-\u06FF\s]+$';
    if (!RegExp(nameRegex).hasMatch(value)) return 'invalid_name'.tr();

    // Split by whitespace and remove empty strings from multi-space entries
    final nameParts = value.trim().split(RegExp(r'\s+'));
    
    if (nameParts.length != 4) {
      return 'invalid_name'.tr();
    }
    
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'username_required'.tr();
    const usernameRegex = r'^[a-zA-Z0-9_]{3,20}$';
    if (!RegExp(usernameRegex).hasMatch(value)) {
      return 'invalid_username'.tr();
    }
    return null;
  }

  static String? validateMinLength(
    String? value,
    int minLength, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) return 'field_required'.tr();
    if (value.length < minLength) {
      return 'field_required'.tr(); // Or a specific min length key if needed
    }
    return null;
  }
}
