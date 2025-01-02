import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:enkripa_sign/presentation/app.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}
