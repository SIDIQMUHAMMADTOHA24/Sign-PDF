import 'package:enkripa_sign/presentation/pages/data_verification_page.dart';
import 'package:enkripa_sign/presentation/pages/face_verification_page.dart';
import 'package:enkripa_sign/presentation/pages/on_boarding_page.dart';
import 'package:enkripa_sign/presentation/pages/splash_page.dart';
import 'package:enkripa_sign/presentation/pages/widget/on_boarding_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:enkripa_sign/presentation/bloc/view/fied_bloc/field_bloc.dart';
import 'package:enkripa_sign/presentation/pages/create_account_page.dart';
import 'package:enkripa_sign/presentation/pages/input_data_personal_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FieldBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          dividerColor: Theme.of(context).dividerThemeColor,
          useMaterial3: true,
        ),
        locale: const Locale('id', 'ID'),
        home: const FaceVerificationPage(),
      ),
    );
  }
}
