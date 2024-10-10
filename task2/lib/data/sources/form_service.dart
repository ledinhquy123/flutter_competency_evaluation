import 'package:dartz/dartz.dart';
import 'package:task2/data/models/form_req.dart';

abstract class FormService {
  Future<Either> update(FormReq formReq);
}

class FormServiceImpl extends FormService {
  @override
  Future<Either> update(FormReq formReq) async {
    await Future.delayed(const Duration(seconds: 2));

    if (formReq.dateTime == null ||
        formReq.quantity == null ||
        formReq.pump == null ||
        formReq.revenue == null ||
        formReq.unitPrice == null) {
      return const Left("Please fill out completely");
    }

    return const Right("Data was sent successfully");
  }
}
