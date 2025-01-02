part of 'field_bloc.dart';

sealed class FieldEvent extends Equatable {
  const FieldEvent();

  @override
  List<Object> get props => [];
}

class FieldFocusEvent extends FieldEvent {
  final KeyConstants key;
  final bool hasFocus;

  const FieldFocusEvent({required this.key, required this.hasFocus});

  @override
  List<Object> get props => [key, hasFocus];
}

class FieldIsNotEmptyEvent extends FieldEvent {
  final KeyConstants key;
  final String text;

  const FieldIsNotEmptyEvent({required this.key, required this.text});

  @override
  List<Object> get props => [key, text];
}

class PasswordVisibilityEvent extends FieldEvent {
  final KeyConstants key;

  const PasswordVisibilityEvent({required this.key});

  @override
  List<Object> get props => [key];
}

class ValidationPasswordEvent extends FieldEvent {
  final KeyConstants key;
  final String value;

  const ValidationPasswordEvent({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];
}

class ConfirmPasswordEvent extends FieldEvent {
  final String password;
  final String confirmPassword;

  const ConfirmPasswordEvent(
      {required this.password, required this.confirmPassword});

  @override
  List<Object> get props => [password, confirmPassword];
}
