import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:slider_captcha/slider_captcha.dart';

class DataVerificationPage extends StatefulWidget {
  const DataVerificationPage({super.key});

  @override
  State<DataVerificationPage> createState() => _DataVerificationPageState();
}

class _DataVerificationPageState extends State<DataVerificationPage> {
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
                        SvgPicture.asset('assets/icon/arrow-left-icon.svg'),
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
                      child: ListView(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).backgroundVerifDataColor,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .borderBackgroundVerifDataColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 344,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.amber),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                Text('Personal Data',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).titleMediumColor,
                                    )),
                                //NIK
                                _outputDataWidget(context,
                                    title: 'NIK', subtitle: '1805041311000001'),

                                //FULL NAME
                                _outputDataWidget(context,
                                    title: 'Nama Lengkap',
                                    subtitle: 'Edward Alexandro'),

                                //DATE BIRTH
                                _outputDataWidget(context,
                                    title: 'Tanggal Lahir',
                                    subtitle: '10-12-1999'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                Text('Data Akun',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).titleMediumColor,
                                    )),

                                //EMAIL
                                _outputDataWidget(context,
                                    title: 'Email',
                                    subtitle: 'edward@gmail.com'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),

                                Text('Input Captcha',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).titleMediumColor,
                                    )),

                                SliderCaptcha(
                                  image: Image.asset(
                                    'assets/image/enkripa-logo.webp',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  colorBar: Colors.blue,
                                  colorCaptChar: Colors.blue,
                                  onConfirm: (value) async {},
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//OUTPUT DATA WIDGET
Padding _outputDataWidget(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).headlineSmallColor)),
        Text(subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).titleMediumColor,
            )),
      ],
    ),
  );
}
