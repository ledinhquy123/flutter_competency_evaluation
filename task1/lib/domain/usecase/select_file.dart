import 'package:dartz/dartz.dart';
import 'package:task1/core/usecase/usecase.dart';
import 'package:task1/domain/repository/task1_repository.dart';
import 'package:task1/service_locator.dart';

class SelectFileUsecase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<Task1Repository>().selectFile();
  }
}