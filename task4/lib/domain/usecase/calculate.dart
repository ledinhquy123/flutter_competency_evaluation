import 'package:dartz/dartz.dart';
import 'package:task4/core/usecase/usecase.dart';
import 'package:task4/domain/entities/input_entity.dart';
import 'package:task4/domain/repository/task4.dart';
import 'package:task4/service_locator.dart';

class CalculateUsecase extends Usecase<Either, InputEntity> {
  @override
  Future<Either> call({InputEntity? params}) async {
    return await sl<Task4Repository>().calculate(params!);
  }
}