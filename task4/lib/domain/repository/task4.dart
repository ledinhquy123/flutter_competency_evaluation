import 'package:dartz/dartz.dart';
import 'package:task4/domain/entities/input_entity.dart';

abstract class Task4Repository {
  Future<Either> getData();
  Either calculate(InputEntity input);
  Future<Either> sendData(List<Map<String, int>> data);
}