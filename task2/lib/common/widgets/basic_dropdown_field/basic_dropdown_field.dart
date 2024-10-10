// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:task2/common/constants/app_constant.dart';

class BasicDropdownField extends StatelessWidget {
  String? hintText;
  final String title;
  int? maxLine;
  IconData? icon;
  IconData? sIcon;
  Function()? onPress;
  TextInputType? textInputType;
  bool? obscureText;
  bool? enable;
  bool? readOnly;
  TextEditingController? controller;
  double? height;
  List<TextInputFormatter>? inputFormatters;
  String? Function(Object?)? validator;
  List<DropdownMenuItem<Object?>> items;

  BasicDropdownField(
      {super.key,
      required this.items,
      this.height = 48,
      required this.title,
      this.hintText,
      this.maxLine = 1,
      this.icon,
      this.enable = true,
      this.readOnly = false,
      this.controller,
      this.textInputType = TextInputType.text,
      this.sIcon,
      this.onPress,
      this.inputFormatters,
      this.obscureText = false,
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
          FormBuilderField<Object>(
            name: title,
            builder: (field) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBuilderDropdown(
                    name: title,
                    // inputFormatters: inputFormatters,
                    // keyboardType: textInputType,
                    // maxLines: maxLine,
                    // readOnly: readOnly!,
                    isDense: true,
                    enabled: enable!,
                    // obscureText: obscureText!,
                    style: TextStyle(
                        fontSize: screenWidth < 450 ? 15.5 : 20.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    // controller: controller,
                    onChanged: (value) {
                      field.didChange(value);
                    },
                    alignment: Alignment.centerLeft,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    dropdownColor: Colors.white,
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
                      suffixIcon: sIcon == null
                          ? null
                          : GestureDetector(
                              onTap: onPress,
                              child: Icon(
                                sIcon,
                                color: Colors.grey,
                              )),
                    ),
                    items: items,
                  ),
                  if (field.hasError)
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[50], // Màu nền cho box lỗi
                        border: Border.all(color: Colors.red), // Viền màu đỏ
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              color: Colors.red), // Biểu tượng lỗi
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              field.errorText ?? '',
                              style: TextStyle(color: Colors.red, fontSize: 14),
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
