import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/data/models/form_req.dart';
import 'package:task2/data/sources/form_service.dart';
import 'package:task2/presentation/form/blocs/update_button/update_button_state.dart';
import 'package:task2/service_locator.dart';

class UpdateButtonCubit extends Cubit<UpdateButtonState> {
  UpdateButtonCubit() : super(UpdateButtonInitialState());

  Future<void> excute({required FormReq formReq}) async {
    try {
      emit(UpdateButtonLoading());

      var returnedData = await sl<FormService>().update(formReq);
      returnedData.fold((error) {
        emit(UpdateButtonFailure(errorMess: error));
      }, (data) {
        emit(UpdateButtonLoaded(successMess: data));
      });
    } catch (e) {
      emit(UpdateButtonFailure(errorMess: "Something went wrong"));
    }
  }
}