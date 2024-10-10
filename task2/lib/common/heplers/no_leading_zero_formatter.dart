import 'package:flutter/services.dart';

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      return TextEditingValue(
        text: newValue.text.replaceFirst(RegExp(r'^0+'), ''),
        selection:
            TextSelection.collapsed(offset: newValue.selection.baseOffset - 1),
      );
    }
    return newValue;
  }
}