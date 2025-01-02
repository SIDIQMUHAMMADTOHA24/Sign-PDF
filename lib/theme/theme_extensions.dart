import 'package:flutter/material.dart';

extension LightThemeCustom on ThemeData {
  //BTN
  Color get disabledButtonColor => const Color(0xffE5E7EB);
  Color get disabledFontColor => const Color(0xff9CA3AF);
  Color get enableButtonColor => const Color(0xffB33238);
  Color get enableFontColor => Colors.white;

  //TEXT
  Color get titleMediumColor => const Color(0xff111827);
  Color get headlineSmallColor => const Color(0xff6B7280);
  Color get errorColor => const Color(0xffEF4444);
  Color get descriptionColor => const Color(0xff9CA3AF);
  Color get redHeadlineColor => const Color(0xffB33238);

  //INFORMASI SECURITY
  Color get hardSecurityColor => const Color(0xffEF4444);
  Color get mediumSecurityColor => const Color(0xffF59E0B);
  Color get lowSecurityColor => const Color(0xff10B981);

  //BACKGROUD
  Color get topBackgroundColor => const Color.fromARGB(255, 194, 57, 64);
  Color get bottomBackgroundColor => const Color.fromARGB(255, 110, 10, 15);
  Color get backgroundVerifDataColor => const Color(0xffF9FAFB);
  Color get borderBackgroundVerifDataColor => const Color(0xffEDF0F4);

  //DIVIDER
  Color get dividerThemeColor => const Color(0xffE5E7EB);

  //TEXTFIELD
  Color get defaultBorderColor => const Color(0xffE5E7EB);
  Color get focusBorderColor => const Color(0xff6B7280);
  Color get hintextColor => const Color(0xff6B7280);
  Color get fontColor => const Color(0xff111827);
  Color get cursorColor => const Color(0xffB33238);
  Color get defaultIconCalenderColor => const Color(0xff9CA3AF);
}
