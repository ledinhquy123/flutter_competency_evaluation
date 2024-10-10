import 'package:dartz/dartz.dart';
import 'package:task4/data/sources/task4_service.dart';
import 'package:task4/domain/entities/input_entity.dart';
import 'package:task4/domain/repository/task4.dart';
import 'package:task4/service_locator.dart';

class Task4RepositoryImpl implements Task4Repository {
  @override
  Future<Either> getData() async {
    return await sl<Task4Service>().getData();
  }
  
  @override
  Either calculate(InputEntity input) {
    return sl<Task4Service>().calculate(input);
  }
  
  @override
  Future<Either> sendData(List<Map<String, int>> data) async {
    return await sl<Task4Service>().sendData(data);
  }
}