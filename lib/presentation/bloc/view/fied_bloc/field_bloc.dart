import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:enkripa_sign/utils/key_constant.dart';

part 'field_event.dart';
part 'field_state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc()
      : super(
          const FieldState(
            focusMap: {},
            textMap: {},
            visibilityMap: {},
            validationMap: {},
            passwordIsSameMap: {},
          ),
        ) {
    //HANDLE FOCUS NODE
    on<FieldFocusEvent>((event, emit) {
      final updatedFocusMap = Map<KeyConstants, bool>.from(state.focusMap)
        ..[event.key] = event.hasFocus;
      emit(FieldState(
          focusMap: updatedFocusMap,
          textMap: state.textMap,
          visibilityMap: state.visibilityMap,
          validationMap: state.validationMap,
          passwordIsSameMap: state.passwordIsSameMap));
    });

    //HANDLE FIELD IS NOT EMPTY
    on<FieldIsNotEmptyEvent>((event, emit) {
      final updatedTextMap = Map<KeyConstants, String>.from(state.textMap)
        ..[event.key] = event.text;
      emit(FieldState(
          focusMap: state.focusMap,
          textMap: updatedTextMap,
          visibilityMap: state.visibilityMap,
          validationMap: state.validationMap,
          passwordIsSameMap: state.passwordIsSameMap));
    });

    //HANDLE OBSCURE PASSWORD
    on<PasswordVisibilityEvent>((event, emit) {
      final updatedVisibilityMap =
          Map<KeyConstants, bool>.from(state.visibilityMap)
            ..[event.key] = !(state.visibilityMap[event.key] ?? false);
      emit(FieldState(
          focusMap: state.focusMap,
          textMap: state.textMap,
          visibilityMap: updatedVisibilityMap,
          validationMap: state.validationMap,
          passwordIsSameMap: state.passwordIsSameMap));
    });

    //HANDLE VALIDATION PASSWORD
    on<ValidationPasswordEvent>((event, emit) {
      final updatedValidationMap =
          Map<KeyConstants, bool>.from(state.validationMap);

      switch (event.key) {
        case KeyConstants.password:
          final password = event.value;

          // Kriteria 1: Minimal 8 karakter
          updatedValidationMap[KeyConstants.min8Charakter] =
              password.length >= 8;

          // Kriteria 2: Setidaknya 1 huruf kapital
          updatedValidationMap[KeyConstants.min1Capital] =
              password.contains(RegExp(r'[A-Z]'));

          // Kriteria 3: Setidaknya 1 angka
          updatedValidationMap[KeyConstants.min1Number] =
              password.contains(RegExp(r'[0-9]'));

          // Kriteria 4: Setidaknya 1 karakter spesial
          updatedValidationMap[KeyConstants.minRandomCharakter] =
              password.contains(RegExp(r'[!@#$%^&*]'));

          break;

        default:
          break;
      }

      emit(FieldState(
          focusMap: state.focusMap,
          textMap: state.textMap,
          visibilityMap: state.visibilityMap,
          validationMap: updatedValidationMap,
          passwordIsSameMap: state.passwordIsSameMap));
    });

    //HANDLE PASSWORD && CONFIRM PASSWORD IS SAME
    on<ConfirmPasswordEvent>((event, emit) {
      final updatedPasswordIsSame = Map<KeyConstants, bool>.from(state.passwordIsSameMap);

      bool arePasswordsSame = (event.password == event.confirmPassword &&
          event.password.isNotEmpty &&
          event.confirmPassword.isNotEmpty);

      if (event.password.isNotEmpty && event.confirmPassword.isNotEmpty) {
        updatedPasswordIsSame[KeyConstants.confirmPassword] = arePasswordsSame;
      } else {
        updatedPasswordIsSame[KeyConstants.confirmPassword] = true;
      }

      emit(FieldState(
        focusMap: state.focusMap,
        textMap: state.textMap,
        visibilityMap: state.visibilityMap,
        validationMap: state.validationMap,
        passwordIsSameMap: updatedPasswordIsSame,
      ));
    });
  }
}
