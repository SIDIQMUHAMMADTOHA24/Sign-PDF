import 'dart:async';

import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:enkripa_sign/presentation/pages/widget/on_boarding_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Nav.remove(context, const OnBoardingWidget());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 3),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    height: 66,
                    child: Image.asset('assets/image/enkripa-logo.webp'),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.paddingOf(context).bottom + 20,
                    ),
                    child: Text(
                      'Version 1.0',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Theme.of(context).descriptionColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
