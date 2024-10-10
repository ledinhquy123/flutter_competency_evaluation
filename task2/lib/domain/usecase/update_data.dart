import 'package:dartz/dartz.dart';
import 'package:task2/core/usecase/usecase.dart';
import 'package:task2/data/models/form_req.dart';
import 'package:task2/domain/repository/form_repository.dart';
import 'package:task2/service_locator.dart';

class UpdateDataUsecase implements Usecase<Either, FormReq> {
  @override
  Future<Either> call({FormReq? params}) async {
    return sl<FormRepository>().update(params!);
  }
}