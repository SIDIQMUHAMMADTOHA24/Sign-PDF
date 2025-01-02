import 'package:enkripa_sign/presentation/pages/data_verification_page.dart';
import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';

import 'package:enkripa_sign/presentation/bloc/view/fied_bloc/field_bloc.dart';
import 'package:enkripa_sign/presentation/pages/widget/field_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:enkripa_sign/utils/key_constant.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  //CONTROLLER
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  late FieldBloc? _fieldBloc;

  RegExp validationEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  //INITSTATE
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    addFocusListener(KeyConstants.email, emailFocusNode);
    addFocusListener(KeyConstants.password, passwordFocusNode);
    addFocusListener(KeyConstants.confirmPassword, confirmPasswordFocusNode);
    super.initState();
  }

  //FOCUS LISTENER EVENT
  void addFocusListener(KeyConstants key, FocusNode focusNode) {
    focusNode.addListener(() {
      _fieldBloc!.add(FieldFocusEvent(key: key, hasFocus: focusNode.hasFocus));
    });
  }

  //DISPOSE
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).topBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                    Theme.of(context).bottomBackgroundColor,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.paddingOf(context).top - 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Nav.pop(context);
                          },
                          child: SvgPicture.asset('assets/icon/arrow-left-icon.svg')),
                        Image.asset(
                          'assets/image/enkripa-logo.webp',
                          color: Colors.white,
                          width: 96.9,
                          height: 32,
                        ),
                        SvgPicture.asset('assets/icon/headset-icon.svg'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: BlocBuilder<FieldBloc, FieldState>(
                      builder: (context, stateField) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Buat Akun Anda',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: Theme.of(context).titleMediumColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'Masukkan email dan buat password Anda.',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Theme.of(context).headlineSmallColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 36),

                            //MARK: EMAIL
                            FieldWidget(
                              label: 'Email*',
                              controller: emailController,
                              focusNode: emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autocorrect: true,
                              borderColor: stateField.hasFocus(KeyConstants.email)
                                  ? Theme.of(context).focusBorderColor
                                  : stateField.isNotEmpty(KeyConstants.email)
                                      ? Theme.of(context).focusBorderColor
                                      : null,
                              onChanged: (value) {
                                _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.email,text: value));
                              },
                            ),

                            //MARK: PASSWORD
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: FieldWidget(
                                label: 'Password*',
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                disableSpace: true,
                                borderColor: stateField.hasFocus(KeyConstants.password)
                                    ? Theme.of(context).focusBorderColor
                                    : stateField.isNotEmpty(KeyConstants.password)
                                        ? Theme.of(context).focusBorderColor
                                        : null,
                                onChanged: (value) {
                                  _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.password, text: value));

                                  _fieldBloc!.add(ValidationPasswordEvent(key: KeyConstants.password,value: value));

                                  if (confirmPasswordController.text.isNotEmpty) {
                                    _fieldBloc!.add(ConfirmPasswordEvent(password: value, confirmPassword:confirmPasswordController.text));
                                  }
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _fieldBloc!.add(const PasswordVisibilityEvent(key: KeyConstants.password));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    color: Colors.transparent,
                                    child: SvgPicture.asset(
                                      _fieldBloc!.state.isVisible(KeyConstants.password)
                                          ? 'assets/icon/eye-slash-icon.svg'
                                          : 'assets/icon/eye-icon.svg',
                                      colorFilter: ColorFilter.mode(
                                        stateField.isNotEmpty(KeyConstants.password) || stateField.hasFocus(KeyConstants.password)
                                            ? Theme.of(context).focusBorderColor
                                            : Theme.of(context).defaultIconCalenderColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                obscureText: _fieldBloc!.state.isVisible(KeyConstants.password),
                              ),
                            ),

                            //PASSWORD LEVEL
                            stateField.isNotEmpty(KeyConstants.password)
                                ? _buildPasswordStrengthIndicator(context, stateField)
                                : const SizedBox(),

                            //MARK: CONFIRM PASSWORD
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: FieldWidget(
                                label: 'Konfirmasi Password*',
                                controller: confirmPasswordController,
                                disableSpace: true,
                                focusNode: confirmPasswordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                borderColor: !_fieldBloc!.state.passwordIsSame(KeyConstants.confirmPassword)
                                    ? Colors.red
                                    : stateField.hasFocus(KeyConstants.confirmPassword)
                                        ? Theme.of(context).focusBorderColor
                                        : stateField.isNotEmpty(KeyConstants.confirmPassword) 
                                          ? Theme.of(context).focusBorderColor 
                                          : null,
                                borderWidth: stateField.hasFocus(KeyConstants.confirmPassword) ? 1.6 : null,
                                onChanged: (value) {
                                  _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.confirmPassword,text: value));

                                  _fieldBloc!.add(ConfirmPasswordEvent(password: passwordController.text,confirmPassword: value));
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _fieldBloc!.add(const PasswordVisibilityEvent(key: KeyConstants.confirmPassword));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    color: Colors.transparent,
                                    child: SvgPicture.asset(
                                      _fieldBloc!.state.isVisible(KeyConstants.confirmPassword)
                                          ? 'assets/icon/eye-slash-icon.svg'
                                          : 'assets/icon/eye-icon.svg',
                                      colorFilter: ColorFilter.mode(
                                        stateField.isNotEmpty(KeyConstants.confirmPassword) || stateField.hasFocus(KeyConstants.confirmPassword)
                                            ? Theme.of(context).focusBorderColor
                                            : Theme.of(context).defaultIconCalenderColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                obscureText: _fieldBloc!.state.isVisible(KeyConstants.confirmPassword),
                              ),
                            ),

                            !_fieldBloc!.state.passwordIsSame(KeyConstants.confirmPassword)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Oops, password tidak sama, silahkan cek kembali password Anda.',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Divider(
                                thickness: 1.2,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),

                            //MARK: BTN LANJUTKAN
                            Material(
                              borderRadius: BorderRadius.circular(12),
                              color: (_fieldBloc!.state.passwordIsSame(KeyConstants.confirmPassword) && validationEmail.hasMatch(emailController.text)) ? 
                                  Theme.of(context).enableButtonColor : Theme.of(context).disabledButtonColor,
                              child: InkWell(
                                onTap: () {
                                  if (_fieldBloc!.state.passwordIsSame(KeyConstants.confirmPassword) && validationEmail.hasMatch(emailController.text)) {
                                    Nav.push(context, const DataVerificationPage());
                                  }
                                },
                                borderRadius: BorderRadius.circular(12),
                                splashColor: Colors.white.withOpacity(0.2),
                                child: SizedBox(
                                  height: 52,
                                  child: Center(
                                    child: Text(
                                      'Lanjutkan',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: (_fieldBloc!.state.passwordIsSame(KeyConstants.confirmPassword) && validationEmail.hasMatch(emailController.text)) 
                                        ? Theme.of(context).enableFontColor :
                                          Theme.of(context).disabledFontColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // PASSWORD STRENGTH INDICATOR
  Column _buildPasswordStrengthIndicator(
      BuildContext context, FieldState stateField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 6, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).disabledButtonColor,
          ),
          child: PasswordStrengthIndicator(
            thickness: 4,
            colors: StrengthColors(
              weak: Theme.of(context).hardSecurityColor,
              medium: Theme.of(context).mediumSecurityColor,
              strong: Theme.of(context).lowSecurityColor,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,

            strengthBuilder: (String password) {
              double score = 0;

              if (password.length >= 8) {
                score += 0.25;
              }

              if (password.contains(RegExp(r'[A-Z]'))) {
                score += 0.25;
              }

              if (password.contains(RegExp(r'[!@#$%^&*]'))) {
                score += 0.25;
              }

              if (password.contains(RegExp(r'[0-9]'))) {
                score += 0.25;
              }

              return score;
            },
            style: StrengthBarStyle.line,
            password: passwordController.text,
          ),
        ),
        Text(
          'Password harus :',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).headlineSmallColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: _descriptionWidget(
            context,
            description: 'Setidaknya 1 huruf kapital',
            isValid: stateField.isValid(KeyConstants.min1Capital),
          ),
        ),
        _descriptionWidget(
          context,
          description: 'Setidaknya 8 karakter',
          isValid: stateField.isValid(KeyConstants.min8Charakter),
        ),
        _descriptionWidget(
          context,
          description: 'Setidaknya 1 angka',
          isValid: stateField.isValid(KeyConstants.min1Number),
        ),
        _descriptionWidget(
          context,
          description: 'Setidaknya 1 karakter spesial (!@#\$%^&*)',
          isValid: stateField.isValid(KeyConstants.minRandomCharakter),
        ),
      ],
    );
  }

  //DESCRIPTION WIDGET
  Row _descriptionWidget(
    BuildContext context, {
    required String description,
    required bool isValid,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          isValid
              ? 'assets/icon/tick-circle-icon.svg'
              : 'assets/icon/close-circle-icon.svg',
        ),
        const SizedBox(width: 4),
        Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).headlineSmallColor,
          ),
        ),
      ],
    );
  }
}
