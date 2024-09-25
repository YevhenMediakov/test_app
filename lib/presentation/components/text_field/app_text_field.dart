import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_prj/resources/app_colors.dart';
import 'package:test_prj/resources/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  static const double cornersRadius = 6;

  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final String hintText;
  final bool isHintFloating;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool forceErrorBorder;
  final String? errorText;
  final String? helperText;
  final bool showCounter;
  final TextStyle style;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int? lengthLimit;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color backgroundColor;
  final TextAlignVertical textAlignVertical;
  final bool fillParentHeight;
  final bool autofocus;
  final bool isEnabled;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextField({
    required this.controller,
    this.focusNode,
    this.inputFormatters = const [],
    this.hintText = "",
    this.isHintFloating = true,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.forceErrorBorder = false,
    this.errorText,
    this.helperText,
    this.showCounter = false,
    this.style = AppTextStyles.bodyL,
    this.textAlign = TextAlign.start,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.sentences,
    this.lengthLimit,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.backgroundColor = Colors.transparent,
    this.textAlignVertical = TextAlignVertical.center,
    this.fillParentHeight = false,
    this.autofocus = false,
    this.isEnabled = true,
    this.readOnly = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [
        if (lengthLimit != null) ...{
          LengthLimitingTextInputFormatter(lengthLimit),
        },
        ...inputFormatters,
      ],
      textAlign: textAlign,
      cursorColor: AppColors.yellow,
      textAlignVertical: textAlignVertical,
      textInputAction: textInputAction,
      onSubmitted: (_) => onSubmitted?.call(),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      enableSuggestions: false,
      autocorrect: false,
      autofocus: autofocus,
      enabled: isEnabled,
      style: style,
      expands: fillParentHeight,
      obscureText: obscureText,
      obscuringCharacter: "*",
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: isHintFloating ? hintText : null,
        labelStyle: AppTextStyles.bodyL.copyWith(
          color: AppColors.black_26,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: AppTextStyles.bodyM.copyWith(
          color: AppColors.black_38,
          fontWeight: FontWeight.w400,
        ),
        hintText: isHintFloating ? null : hintText,
        hintStyle: AppTextStyles.bodyL.copyWith(
          color: AppColors.black_26,
          fontWeight: FontWeight.w400,
        ),
        counter: showCounter
            ? _CounterText(
                currentLength: controller.text.length, maxLength: maxLength)
            : null,
        contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        filled: true,
        fillColor: backgroundColor,
        counterText: '',
        isDense: true,
        errorText: errorText,
        errorMaxLines: 5,
        errorStyle: const TextStyle(
            color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w400),
        helperText: helperText,
        helperMaxLines: 5,
        helperStyle: const TextStyle(
            color: AppColors.black_26,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        border: forceErrorBorder
            ? const _OutlineInputBorder.error()
            : const _OutlineInputBorder.idle(),
        errorBorder: const _OutlineInputBorder.error(),
        focusedErrorBorder: const _OutlineInputBorder.error(),
        focusedBorder: forceErrorBorder
            ? const _OutlineInputBorder.error()
            : const _OutlineInputBorder.focused(),
        enabledBorder: forceErrorBorder
            ? const _OutlineInputBorder.error()
            : const _OutlineInputBorder.idle(),
        disabledBorder: forceErrorBorder
            ? const _OutlineInputBorder.error()
            : const _OutlineInputBorder.idle(),
        prefixText: prefixText,
        prefixStyle: style,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class _OutlineInputBorder extends OutlineInputBorder {
  const _OutlineInputBorder.idle()
      : super(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppTextField.cornersRadius)),
          borderSide: const BorderSide(color: AppColors.black_26, width: 1),
        );

  const _OutlineInputBorder.focused()
      : super(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppTextField.cornersRadius)),
          borderSide: const BorderSide(color: AppColors.black_38, width: 2),
        );

  const _OutlineInputBorder.error()
      : super(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppTextField.cornersRadius)),
          borderSide: const BorderSide(color: AppColors.red, width: 1.0),
        );
}

class _CounterText extends StatelessWidget {
  final int currentLength;
  final int? maxLength;

  const _CounterText({
    required this.currentLength,
    required this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$currentLength / $maxLength",
      style: const TextStyle(
        color: AppColors.black_26,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
