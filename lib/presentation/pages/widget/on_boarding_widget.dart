import 'package:enkripa_sign/presentation/pages/on_boarding_page.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/enkripa-logo.webp',
                width: 122,
                height: 40,
              ),
            ],
          ),
        ),
        body: (height < 760)
            ? const SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: OnBoardingView(isHeight: true))
            : const OnBoardingView(isHeight: false));
  }
}
