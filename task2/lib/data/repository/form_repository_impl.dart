import 'package:dartz/dartz.dart';
import 'package:task2/data/models/form_req.dart';
import 'package:task2/data/sources/form_service.dart';
import 'package:task2/domain/repository/form_repository.dart';
import 'package:task2/service_locator.dart';

class FormRepositoryImpl implements FormRepository {
  @override
  Future<Either> update(FormReq formReq) async {
    return await sl<FormService>().update(formReq);
  }
}