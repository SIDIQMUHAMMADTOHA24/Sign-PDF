import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';

class FieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Color? borderColor;
  final double? borderWidth;
  final bool? disable;
  final bool? autocorrect;
  final Widget? suffixIcon;
  final bool? disableSpace;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? textInputAction;

  FieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.disableSpace,
    this.onTap,
    this.borderColor,
    this.borderWidth,
    this.autocorrect,
    this.disable,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
    this.textInputAction,
  });

  TextInputFormatter textInputFormatter =
      TextInputFormatter.withFunction((oldValue, newValue) {
    String sanitizedText = newValue.text
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('&', '&amp;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
    return TextEditingValue(
      text: sanitizedText,
      selection: newValue.selection,
    );
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        cursorColor: Theme.of(context).cursorColor,
        keyboardType: keyboardType,
        onChanged: onChanged,
        enabled: disable ?? true,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        obscuringCharacter: '•',
        textInputAction: textInputAction,
        autocorrect: autocorrect ?? false,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).fontColor,
          ),
        ),
        inputFormatters: (disableSpace == null)
            ? [
                FilteringTextInputFormatter.deny(RegExp('<|>|&|"|\'|/')),
                textInputFormatter,
                LengthLimitingTextInputFormatter(30),
              ]
            : [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                FilteringTextInputFormatter.deny(RegExp('<|>|&|"|\'|/')),
                textInputFormatter,
                LengthLimitingTextInputFormatter(30),
              ],
        decoration: InputDecoration(
          label: Text(
            label,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: Theme.of(context).hintextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1, color: borderColor ?? Theme.of(context).defaultBorderColor)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1, color: borderColor ?? Theme.of(context).defaultBorderColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1.6, color: borderColor ?? Theme.of(context).defaultBorderColor,)),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
