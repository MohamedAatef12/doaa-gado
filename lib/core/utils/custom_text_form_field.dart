import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool? fillColor;
  final Color? fillColorValue;
  final TextStyle? style;
  final bool? enableInteractiveSelection;
  final TextAlignVertical? textAlignVertical;
  final bool centerText;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.enabled = true,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.fillColor,
    this.fillColorValue,
    this.style,
    this.enableInteractiveSelection,
    this.textAlignVertical,
    this.centerText = false,
    this.inputFormatters,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      style: style,
      enableInteractiveSelection: enableInteractiveSelection,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      textAlignVertical:
          textAlignVertical ??
          (maxLines == 1 ? TextAlignVertical.center : null),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      enabled: enabled,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        filled: fillColor,
        fillColor: fillColorValue,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        isDense: true,
        border: border ?? const OutlineInputBorder(),
        focusedBorder:
            focusedBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
        enabledBorder:
            enabledBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
      ),
    );
  }
}
