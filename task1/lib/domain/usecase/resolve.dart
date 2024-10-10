import 'package:dartz/dartz.dart';
import 'package:task1/core/usecase/usecase.dart';
import 'package:task1/data/models/resolve/resolve_req.dart';
import 'package:task1/domain/repository/task1_repository.dart';
import 'package:task1/service_locator.dart';

class ResolveUsecase extends Usecase<Either, ResolveReq> {
  @override
  Future<Either> call({ResolveReq? params}) async {
    return await sl<Task1Repository>().resolve(params!);
  }
}