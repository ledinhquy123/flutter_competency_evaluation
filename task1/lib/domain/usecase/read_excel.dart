import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task1/core/usecase/usecase.dart';
import 'package:task1/domain/repository/task1_repository.dart';
import 'package:task1/service_locator.dart';

class ReadExcelUsecase extends Usecase<Either, File> {
  @override
  Future<Either> call({File? params}) async {
    return await sl<Task1Repository>().readExcel(params!);
  }
}