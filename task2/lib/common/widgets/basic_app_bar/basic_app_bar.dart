import 'package:flutter/material.dart';
import 'package:task2/common/constants/app_constant.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar(
      {super.key, required this.onTap, this.appBarHeight, this.title});

  final void Function()? onTap;
  final double? appBarHeight;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: appBarHeight ?? screenHeight * 0.13,
      padding:
          EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_leading(context), _actions()],
      ),
    );
  }

  Widget _leading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: screenWidth <= 450 ? 23 : 28,
              ),
              SizedBox(width: screenWidth * 0.015),
              Text(
                "Đóng",
                style: TextStyle(
                    fontSize: screenWidth <= 450 ? 18 : 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          title ?? "Nhập giao dịch",
          style: TextStyle(
              fontSize: screenWidth <= 450 ? 32 : 37,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _actions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(14)),
            child: Text(
              'Cập nhật',
              style: TextStyle(
                  fontSize: screenWidth <= 450 ? 16 : 21,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
