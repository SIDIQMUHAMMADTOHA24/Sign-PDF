import 'package:enkripa_sign/presentation/pages/input_data_personal_page.dart';
import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'package:enkripa_sign/presentation/bloc/view/fied_bloc/field_bloc.dart';
import 'package:enkripa_sign/presentation/pages/widget/field_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:enkripa_sign/utils/key_constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //CONTROLLER
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  late FieldBloc? _fieldBloc;

  RegExp validationEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  //INITSTATE
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    addFocusListener(KeyConstants.email, emailFocusNode);
    addFocusListener(KeyConstants.password, passwordFocusNode);

    super.initState();
  }

  //FOCUS LISTENER EVENT
  void addFocusListener(KeyConstants key, FocusNode focusNode) {
    focusNode.addListener(() {
      context
          .read<FieldBloc>()
          .add(FieldFocusEvent(key: key, hasFocus: focusNode.hasFocus));
    });
  }

  //DISPOSE
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
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
                              'Login',
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
                                  'Silahkan masukkan email dan password Anda.',
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
                              borderColor: stateField.hasFocus(KeyConstants.email)
                                  ? Theme.of(context).focusBorderColor
                                  : stateField.isNotEmpty(KeyConstants.email)
                                      ? Theme.of(context).focusBorderColor
                                      : null,
                              onChanged: (value) {
                                _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.email, text: value));
                              },
                            ),

                            //MARK: PASSWORD
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: FieldWidget(
                                label: 'Password*',
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                borderColor: stateField
                                        .hasFocus(KeyConstants.password)
                                    ? Theme.of(context).focusBorderColor
                                    : stateField.isNotEmpty(KeyConstants.password)
                                        ? Theme.of(context).focusBorderColor
                                        : null,
                                onChanged: (value) {
                                  _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.password, text: value));
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

                            Padding(
                              padding: const EdgeInsets.only(bottom: 24, top: 8),
                              child: Divider(
                                thickness: 1.2,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),

                            //MARK: BTN LOGIN
                            Material(
                              borderRadius: BorderRadius.circular(12),
                              color: (stateField.isNotEmpty(KeyConstants.email) &&
                                      stateField.isNotEmpty(KeyConstants.password) && 
                                      validationEmail.hasMatch(emailController.text))
                                  ? Theme.of(context).enableButtonColor
                                  : Theme.of(context).disabledButtonColor,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(12),
                                splashColor: Colors.white.withOpacity(0.2),
                                child: SizedBox(
                                  height: 52,
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: (stateField.isNotEmpty(KeyConstants.email) &&
                                                stateField.isNotEmpty(KeyConstants.password) && 
                                                validationEmail.hasMatch(emailController.text))
                                            ? Theme.of(context).enableFontColor
                                            : Theme.of(context)
                                                .disabledFontColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).headlineSmallColor),
                                      children: [
                                        const TextSpan(
                                          text: 'Belum punya akun ? ',
                                        ),
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            Nav.push(context, const InputDataPersonalPage());
                                          },
                                          text: 'Daftar disini',
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).redHeadlineColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
}
