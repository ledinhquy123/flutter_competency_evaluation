import 'package:dartz/dartz.dart';
import 'package:task2/data/models/form_req.dart';

abstract class FormRepository {
  Future<Either> update(FormReq formReq);
}