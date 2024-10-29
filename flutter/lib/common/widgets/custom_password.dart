import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_strength/password_strength.dart';

abstract class ValidationRule {
  String get name;
  bool validate(String value);
}

class MinCharactersValidationRule extends ValidationRule {
  final int _numberOfCharacters;
  MinCharactersValidationRule(this._numberOfCharacters);

  @override
  String get name => 'length >= $_numberOfCharacters';

  @override
  bool validate(String value) {
    return value.length >= _numberOfCharacters;
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  final RxString password;
  const PasswordStrengthIndicator({Key? key, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var isValid = password.value.length >= 4;
      return Row(
        children: [
          Expanded(
              child: _indicator(
                  password.isEmpty ? Colors.grey : _getColor(isValid))),
          Text(password.isEmpty ? '' : (isValid ? 'Valid' : 'Invalid'))
              .marginOnly(left: password.isEmpty ? 0 : 8),
        ],
      );
    });
  }

  Widget _indicator(bool isValid) {
    return Container(
      height: 8,
      color: isValid ? Colors.green : Colors.red,
    );
  }

  Color _getColor(bool isValid) {
    return isValid ? Colors.green : Colors.red;
  }
}
