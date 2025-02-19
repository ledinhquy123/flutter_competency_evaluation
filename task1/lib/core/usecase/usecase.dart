import 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  Future<Either> call({Params params});
}