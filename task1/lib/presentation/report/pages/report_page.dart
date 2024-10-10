import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:task1/common/helpers/show_snackbar.dart';
import 'package:task1/common/widgets/basic_date_field/basic_date_field.dart';
import 'package:task1/core/constant/app_constant.dart';
import 'package:task1/data/models/resolve/resolve_req.dart';
import 'package:task1/presentation/report/blocs/read_excel/read_excel_cubit.dart';
import 'package:task1/presentation/report/blocs/read_excel/read_excel_state.dart';
import 'package:task1/presentation/report/blocs/resolve/resolve_cubit.dart';
import 'package:task1/presentation/report/blocs/resolve/resolve_state.dart';
import 'package:task1/presentation/report/blocs/select_file/select_file_cubit.dart';
import 'package:task1/presentation/report/blocs/select_file/select_file_state.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _startTimeCon = TextEditingController();
  final TextEditingController _endTimeCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_obtainFileField()],
        ),
      ),
    );
  }

  Widget _obtainFileField() {
    return BlocProvider(
      create: (context) => SelectFileCubit(),
      child: BlocBuilder<SelectFileCubit, SelectFileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    textAlign: TextAlign.center,
                    "Trích xuất dữ liệu có thể mất một khoảng thời gian",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.03),
                state is SelectFileLoaded
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.file!.path.split('/').last),
                          SizedBox(height: screenHeight * 0.03),
                          _readData(state.file!)
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          context.read<SelectFileCubit>().selectFile();
                        },
                        child: Container(
                            width: screenWidth * 0.35,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)),
                            child: state is SelectFileLoading
                                ? Center(
                                    child: SizedBox(
                                      width: screenWidth * 0.05,
                                      height: screenWidth * 0.05,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      "Chọn file",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _readData(File file) {
    return BlocProvider(
      create: (context) => ReadExcelCubit(),
      child: BlocBuilder<ReadExcelCubit, ReadExcelState>(
        builder: (context, state) {
          return BlocListener<ReadExcelCubit, ReadExcelState>(
            listener: (context, state) {
              if (state is ReadExcelFailure) {
                Navigator.pop(context);
                showSnackbar(context: context, content: state.errorMess);
              }
            },
            child: state is ReadExcelLoaded
                ? _formField(context, state.data)
                : GestureDetector(
                    onTap: state is ReadExcelLoading
                        ? null
                        : () {
                            context.read<ReadExcelCubit>().readExcel(file);
                          },
                    child: Container(
                        width: screenWidth * 0.35,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12)),
                        child: state is ReadExcelLoading
                            ? Center(
                                child: SizedBox(
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                "Trích xuất",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
          );
        },
      ),
    );
  }

  Widget _formField(BuildContext context, Map<DateTime, double>? data) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _formTitle(),
          SizedBox(height: screenHeight * 0.02),
          _startTime(),
          SizedBox(height: screenHeight * 0.02),
          _endTime(),
          SizedBox(height: screenHeight * 0.02),
          _resolveBtn(context, data)
        ],
      ),
    );
  }

  Widget _formTitle() {
    return const Text(
        textAlign: TextAlign.center,
        "Tính tổng tiền theo thời gian",
        style: TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget _startTime() {
    return BasicDateField(
      title: "Giờ bắt đầu",
      controller: _startTimeCon,
      hintText: "Chọn thời gian",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Không được bỏ trống"),
        FormBuilderValidators.dateTime(
            errorText: "Vui lòng chọn ngày giờ hợp lệ"),
      ]),
    );
  }

  Widget _endTime() {
    return BasicDateField(
      title: "Giờ kết thúc",
      controller: _endTimeCon,
      hintText: "Chọn thời gian",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Không được bỏ trống"),
        FormBuilderValidators.dateTime(
            errorText: "Vui lòng chọn ngày giờ hợp lệ"),
      ]),
    );
  }

  Widget _resolveBtn(BuildContext context, Map<DateTime, double>? data) {
    return BlocProvider(
      create: (context) => ResolveCubit(),
      child: BlocBuilder<ResolveCubit, ResolveState>(
        builder: (context, state) {
          return BlocListener<ResolveCubit, ResolveState>(
            listener: (context, state) {
              if (state is ResolveFailure) {
                showSnackbar(context: context, content: state.errorMess);
              }
              if (state is ResolveLoaded) {
                showSnackbar(
                    context: context,
                    bgColor: Colors.green,
                    textColor: Colors.white,
                    content: "Calculation was successfully");
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: state is ResolveLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            if (data != null) {
                              String dayFormat =
                                  "${data.entries.first.key.year}-${data.entries.first.key.month}-${data.entries.first.key.day}";
                              var start = DateFormat("yyyy-MM-dd HH:mm:ss")
                                  .parse("$dayFormat ${_startTimeCon.text}");
                              var end = DateFormat("yyyy-MM-dd HH:mm:ss")
                                  .parse("$dayFormat ${_endTimeCon.text}");
                              context.read<ResolveCubit>().resolve(ResolveReq(
                                  startTime: start, endTime: end, data: data));
                            }
                          }
                        },
                  child: Container(
                      width: screenWidth * 0.35,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      child: state is ResolveLoading
                          ? Center(
                              child: SizedBox(
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              "Xử lý",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
                state is ResolveLoaded
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.04),
                          Text(
                              "Tổng tiền từ ${_startTimeCon.text} tới ${_endTimeCon.text} là:",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: 'VNĐ')
                                  .format(state.totalPrice),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500))
                        ],
                      )
                    : const SizedBox.shrink(),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ReportPage()));
                  },
                  child: Container(
                      width: screenWidth * 0.4,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Chọn file mới",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
