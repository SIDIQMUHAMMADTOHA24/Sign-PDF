import 'package:enkripa_sign/presentation/pages/create_account_page.dart';
import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'package:enkripa_sign/presentation/bloc/view/fied_bloc/field_bloc.dart';
import 'package:enkripa_sign/presentation/pages/widget/field_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:enkripa_sign/utils/key_constant.dart';

class InputDataPersonalPage extends StatefulWidget {
  const InputDataPersonalPage({super.key});

  @override
  State<InputDataPersonalPage> createState() => _InputDataPersonalPageState();
}

class _InputDataPersonalPageState extends State<InputDataPersonalPage> {
  //CONTROLLER
  final TextEditingController nikController = TextEditingController();
  final TextEditingController ktpController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final FocusNode nikFocusNode = FocusNode();
  final FocusNode ktpFocusNode = FocusNode();
  final FocusNode tanggalLahirFocusNode = FocusNode();
  late FieldBloc? _fieldBloc;

  //INITSTATE
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    addFocusListener(KeyConstants.nik, nikFocusNode);
    addFocusListener(KeyConstants.ktp, ktpFocusNode);
    addFocusListener(KeyConstants.tanggalLahir, tanggalLahirFocusNode);

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
    nikController.dispose();
    ktpController.dispose();
    tanggalLahirController.dispose();
    nikFocusNode.dispose();
    ktpFocusNode.dispose();
    tanggalLahirFocusNode.dispose();
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                              'Input Data Personal',
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
                                  'Silakan lengkapi data dibawah terlebih dahulu.',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Theme.of(context).headlineSmallColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 36),

                            //MARK: NIK
                            FieldWidget(
                              label: 'NIK*',
                              controller: nikController,
                              focusNode: nikFocusNode,
                              keyboardType: TextInputType.number,
                              borderColor: stateField.hasFocus(KeyConstants.nik)
                                  ? Theme.of(context).focusBorderColor
                                  : stateField.isNotEmpty(KeyConstants.nik)
                                      ? Theme.of(context).focusBorderColor
                                      : null,
                              onChanged: (value) {
                                _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.nik,text: value));
                              },
                            ),

                            //MARK: KTP
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: FieldWidget(
                                label: 'Nama Lengkap di KTP*',
                                controller: ktpController,
                                focusNode: ktpFocusNode,
                                keyboardType: TextInputType.text,
                                borderColor: stateField.hasFocus(KeyConstants.ktp)
                                    ? Theme.of(context).focusBorderColor
                                    : stateField.isNotEmpty(KeyConstants.ktp)
                                        ? Theme.of(context).focusBorderColor
                                        : null,
                                onChanged: (value) {
                                  _fieldBloc!.add(FieldIsNotEmptyEvent(key: KeyConstants.ktp,text: value));
                                },
                              ),
                            ),

                            //MARK: TANGGAL LAHIR
                            FieldWidget(
                              label: 'Tanggal Lahir*',
                              controller: tanggalLahirController,
                              focusNode: tanggalLahirFocusNode,
                              disable: false,
                              keyboardType: TextInputType.text,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: SvgPicture.asset(
                                  'assets/icon/note-icon.svg',
                                  colorFilter: ColorFilter.mode(stateField.isNotEmpty(KeyConstants.tanggalLahir)
                                        ? Theme.of(context).focusBorderColor
                                        : Theme.of(context).defaultIconCalenderColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              borderColor: stateField.isNotEmpty(KeyConstants.tanggalLahir)
                                  ? Theme.of(context).focusBorderColor
                                  : null,
                              onTap: () {
                                nikFocusNode.unfocus();
                                ktpFocusNode.unfocus();

                                //DATE TIME
                                DatePicker.showDatePicker(
                                  context,
                                  dateFormat: 'd MMMM yyyy',
                                  maxDateTime: DateTime.now(),
                                  locale: DateTimePickerLocale.id,
                                  initialDateTime: tanggalLahirController.text.isNotEmpty
                                      ? DateFormat('d MMMM yyyy', 'id_ID').parse(tanggalLahirController.text)
                                      : DateTime.now(),
                                  pickerTheme: DateTimePickerTheme(
                                    showTitle: false,
                                    selectionOverlay: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ),
                                    title: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      height: 20,
                                    ),
                                    titleHeight: 20,
                                    itemHeight: 40,
                                    itemTextStyle: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).titleMediumColor,
                                    ),
                                  ),
                                  pickerMode: DateTimePickerMode.date,
                                  onChange: (dateTime, selectedIndex) {
                                    
                                    setState(() {
                                      tanggalLahirController.text = DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
                                    });

                                    _fieldBloc!.add(FieldIsNotEmptyEvent(
                                      key: KeyConstants.tanggalLahir, 
                                      text: DateFormat('d MMMM yyyy', 'id_ID').format(dateTime)
                                    ));
                                  },
                                );
                              },
                            ),

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
                              color: (stateField.isNotEmpty(KeyConstants.nik) && stateField.isNotEmpty(KeyConstants.ktp) && stateField.isNotEmpty(KeyConstants.tanggalLahir))
                                  ? Theme.of(context).enableButtonColor
                                  : Theme.of(context).disabledButtonColor,
                              child: InkWell(
                                onTap: () {
                                  Nav.push(context, const CreateAccountPage());
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
                                        color: (stateField.isNotEmpty(KeyConstants.nik) && stateField.isNotEmpty(KeyConstants.ktp) && stateField.isNotEmpty(KeyConstants.tanggalLahir))
                                            ? Theme.of(context).enableFontColor
                                            : Theme.of(context).disabledFontColor,
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
}
