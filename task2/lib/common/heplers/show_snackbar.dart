import 'package:flutter/material.dart';
import 'package:task2/common/constants/app_constant.dart';

void showSnackbar(
    {required BuildContext context,
    required String content,
    bool? showCloseIcon,
    Color? textColor,
    Color? bgColor,
    double? fontSize = 15.5}) {
  var snackbar = SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: showCloseIcon ?? true,
      backgroundColor: bgColor ?? Colors.red.shade500,
      margin: const EdgeInsets.all(16),
      content: Text(content,
          style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: screenWidth <= 450 ? fontSize : (fontSize! + 5),
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.left));

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
