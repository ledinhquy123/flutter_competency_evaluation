import 'package:dartz/dartz.dart';
import 'package:task4/core/usecase/usecase.dart';
import 'package:task4/domain/repository/task4.dart';
import 'package:task4/service_locator.dart';

class SendDataUsecase extends Usecase<Either, List<Map<String, int>>> {
  @override
  Future<Either> call({List<Map<String, int>>? params}) async {
    return await sl<Task4Repository>().sendData(params!);
  }
}