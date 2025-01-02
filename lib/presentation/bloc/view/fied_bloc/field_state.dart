part of 'field_bloc.dart';

class FieldState extends Equatable {
  final Map<KeyConstants, bool> focusMap;
  final Map<KeyConstants, String> textMap;
  final Map<KeyConstants, bool> visibilityMap;
  final Map<KeyConstants, bool> validationMap;
  final Map<KeyConstants, bool> passwordIsSameMap;

  const FieldState({
    required this.focusMap,
    required this.textMap,
    required this.visibilityMap,
    required this.validationMap,
    required this.passwordIsSameMap,
  });

  bool hasFocus(KeyConstants key) => focusMap[key] ?? false;
  bool isNotEmpty(KeyConstants key) => textMap[key]?.isNotEmpty ?? false;
  bool isVisible(KeyConstants key) => visibilityMap[key] ?? true;
  bool isValid(KeyConstants key) => validationMap[key] ?? false;
  bool passwordIsSame(KeyConstants key) => passwordIsSameMap[key] ?? true;

  @override
  List<Object> get props => [
        focusMap,
        textMap,
        visibilityMap,
        validationMap,
        passwordIsSameMap,
      ];
}
