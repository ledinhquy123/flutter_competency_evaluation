import 'package:flutter/material.dart';
import 'package:task1/core/constant/app_constant.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => Container(
            width: screenWidth * 0.5,
            height: screenWidth * 0.5,
            decoration: const BoxDecoration(color: Colors.black38),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ));
}
