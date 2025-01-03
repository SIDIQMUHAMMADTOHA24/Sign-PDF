import 'package:enkripa_sign/presentation/pages/input_data_personal_page.dart';
import 'package:enkripa_sign/presentation/pages/login_page.dart';
import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:enkripa_sign/presentation/pages/widget/user_areement_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key, required this.isHeight});

  final bool isHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child:
                  Image.asset('assets/image/mockup-content-on-boarding.webp'),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.02),
                    Colors.white.withOpacity(0.03),
                    Colors.white.withOpacity(0.04),
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.06),
                    Colors.white.withOpacity(0.06),
                    Colors.white.withOpacity(0.07),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.95),
                    Colors.white.withOpacity(0.98),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).titleMediumColor),
              children: [
                const TextSpan(
                  text: 'Tanda Tangan Elektronik Aman Dengan ',
                ),
                TextSpan(
                  text: 'Enkripa Sign',
                  style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).redHeadlineColor),
                ),
              ],
            ),
          ),
        ),
        Text(
          'Solusi mudah, nyaman dan efisien untuk melindungi identitas dokumen Anda.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).headlineSmallColor,
          ),
        ),
        (!isHeight) ? const Spacer() : const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            children: [
              //MARK: BTN MASUK
              Expanded(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      Nav.push(context, const LoginPage());
                    },
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.white.withOpacity(0.2),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 52,
                      child: Center(
                        child: Text(
                          'Masuk',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).redHeadlineColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              //MARK: BTN BUAT AKUN
              Expanded(
                child: Material(
                  color: Theme.of(context).enableButtonColor,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      Nav.push(context, const InputDataPersonalPage());
                    },
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.white.withOpacity(0.2),
                    child: SizedBox(
                      height: 52,
                      child: Center(
                        child: Text(
                          'Buat Akun',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).enableFontColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    'Dengan melanjutkan, Anda menyetujui',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).headlineSmallColor),
                  ),
                ),
                WidgetSpan(
                  child: Text(
                    ' Ketentuan Layanan ',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).redHeadlineColor),
                  ),
                ),
                WidgetSpan(
                  child: Text(
                    'kami. Baca ',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).headlineSmallColor),
                  ),
                ),
                WidgetSpan(
                  child: Text(
                    'Kebijakan Privasi ',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).redHeadlineColor),
                  ),
                ),
                WidgetSpan(
                  child: Text(
                    'kami.',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).headlineSmallColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    // );
  }
}

Future<dynamic> showUserAgreementWidget(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(0),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        content: SizedBox(
          width: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Persetujuan Pengguna',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).titleMediumColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Nav.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 5,
                          top: 2,
                          bottom: 2,
                        ),
                        color: Colors.transparent,
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Theme.of(context).titleMediumColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Divider(
                  thickness: 1.2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              Expanded(
                child: RawScrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 5,
                  thumbColor: Theme.of(context).dividerColor,
                  interactive: true,
                  trackColor: const Color(0xfff8f8f8),
                  trackRadius: const Radius.circular(10),
                  padding: const EdgeInsets.only(right: 6),
                  trackBorderColor: Colors.transparent,
                  radius: const Radius.circular(4),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: HtmlWidget(contentUserAgreement),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 16,
                ),
                child: Divider(
                  thickness: 1.2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    //MARK: BTN KELUAR
                    Expanded(
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () {
                            Nav.pop(context);
                          },
                          borderRadius: BorderRadius.circular(12),
                          splashColor: Colors.white.withOpacity(0.2),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).dividerColor),
                                borderRadius: BorderRadius.circular(12)),
                            height: 52,
                            child: Center(
                              child: Text(
                                'Keluar',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).enableButtonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    //MARK: BTN LANJUT
                    Expanded(
                      child: Material(
                        color: Theme.of(context).disabledButtonColor,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          splashColor: Colors.white.withOpacity(0.2),
                          child: SizedBox(
                            height: 52,
                            child: Center(
                              child: Text(
                                'Lanjut',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).disabledFontColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
