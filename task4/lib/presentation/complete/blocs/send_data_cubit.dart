import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/domain/usecase/send_data.dart';
import 'package:task4/presentation/complete/blocs/send_data_state.dart';
import 'package:task4/service_locator.dart';

class SendDataCubit extends Cubit<SendDataState> {
  SendDataCubit() : super(SendDataInitialState());

  Future<void> send({required List<Map<String, int>> data}) async {
    try {
      emit(SendDataLoading());
      var returnedData = await sl<SendDataUsecase>().call(params: data);

      returnedData.fold((error) {
        emit(SendDataFailure(errorMess: error));
      }, (data) {
        emit(SendDataLoaded(successMess: data));
      });
    } catch (e) {
      emit(SendDataFailure(errorMess: "Something went wrong"));
    }
  }
}
