import 'package:dartz/dartz.dart';
import 'package:task4/core/usecase/usecase.dart';
import 'package:task4/domain/repository/task4.dart';
import 'package:task4/service_locator.dart';

class GetDataUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<Task4Repository>().getData();
  }
}