// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:task1/core/constant/app_constant.dart';

class BasicDateField extends StatelessWidget {
  String? hintText;
  final String title;
  int? maxLine;
  IconData? icon;
  bool? enable;
  TextEditingController? controller;
  double? height;
  List<TextInputFormatter>? inputFormatters;
  String? Function(DateTime?)? validator;

  BasicDateField(
      {super.key,
      this.height = 48,
      required this.title,
      this.hintText,
      this.maxLine = 1,
      this.icon,
      this.enable = true,
      this.controller,
      this.inputFormatters,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth < 450 ? 10 : 18),
      constraints: BoxConstraints(
          minHeight: screenWidth < 450 ? height! : (height! + 12)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey)),
          FormBuilderField<DateTime>(
            name: title,
            builder: (field) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBuilderDateTimePicker(
                    name: title,
                    inputFormatters: inputFormatters,
                    maxLines: maxLine,
                    enabled: enable!,
                    inputType: InputType.time,
                    style: TextStyle(
                        fontSize: screenWidth < 450 ? 15.5 : 20.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    controller: controller,
                    format: DateFormat('HH:mm:ss'),
                    onChanged: (value) {
                      field.didChange(value);
                    },
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: hintText,
                      errorStyle: TextStyle(
                          fontSize: screenWidth < 450 ? 15.5 : 20.5,
                          color: Colors.red,
                          fontWeight: FontWeight.w400),
                      prefixIcon: icon == null ? null : Icon(icon),
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                      ),
                    ),
                  ),
                  if (field.hasError)
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[50], // Màu nền cho box lỗi
                        border: Border.all(color: Colors.red), // Viền màu đỏ
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.red), // Biểu tượng lỗi
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              field.errorText ?? '',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
            validator: validator,
          ),
        ],
      ),
    );
  }
}
