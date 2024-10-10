import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:task1/data/models/resolve/resolve_req.dart';

abstract class Task1Service {
  Future<Either> readExcel(File file);
  Future<Either> selectFile();
  Future<Either> resolve(ResolveReq resolveReq);
}

class Task1ServiceImpl implements Task1Service {
  //? Compute
  Map<DateTime, double> parseExcelData(List<int> bytes) {
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel.tables[excel.tables.keys.first];

    if (sheet != null) {
      Map<DateTime, double> data = {};
      for (var i = 8; i < sheet.rows.length; i++) {
        var row = sheet.rows[i];
        if (row.isNotEmpty) {
          String? date;
          String? time;
          double? totalPrice;
          if (row[1] != null && row[2] != null && row[3] != null) {
            date = row[1]!.value.toString();
            time = row[2]!.value.toString();
            totalPrice = double.parse(row[8]!.value.toString());

            data[DateFormat("dd/MM/yyyy HH:mm:ss").parse("$date $time")] =
                totalPrice;
          }
        }
      }
      return data;
    }
    return {};
  }

  @override
  Future<Either> readExcel(File file) async {
    try {
      var bytes = await file.readAsBytes();
      Map<DateTime, double> data = await compute(parseExcelData, bytes);
      if (data.isNotEmpty) {
        return right(data);
      }
      return const Left("Read excel file failed");
    } catch (e) {
      return const Left("An error occurred");
    }
  }

  @override
  Future<Either> selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'xls',
          'xlsx',
        ],
      );

      if (result != null && result.paths.isNotEmpty) {
        return Right(File(result.files.single.path!));
      }
      return const Left(null);
    } catch (e) {
      return const Left(null);
    }
  }

  @override
  Future<Either> resolve(ResolveReq resolveReq) async {
    try {
      var startTime = resolveReq.startTime;
      var endTime = resolveReq.endTime;
      Map<DateTime, double>? data = resolveReq.data;
      double totalPrice = 0;

      if (data != null) {
        if (startTime.isBefore(endTime)) {
          for (var item in data.entries) {
            if (item.key.isAfter(startTime) && item.key.isBefore(endTime)) {
              totalPrice += item.value;
            }
          }
          return Right(totalPrice);
        } else {
          return const Left("The start time is required greater than end time");
        }
      } else {
        return const Left("Data is empty");
      }
    } catch (e) {
      return const Left("An error occurred");
    }
  }
}
