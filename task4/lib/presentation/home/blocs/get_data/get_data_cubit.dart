import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/domain/usecase/get_data.dart';
import 'package:task4/presentation/home/blocs/get_data/get_data_state.dart';
import 'package:task4/service_locator.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitialState());

  Future<void> getData() async {
    try {
      emit(GetDataLoading());

      var returnedData = await sl<GetDataUsecase>().call();

      returnedData.fold((error) {
        emit(GetDataFailure(errMess: error));
      }, (data) {
        emit(GetDataLoaded(inputEntity: data));
      });
    } catch (e) {
      emit(GetDataFailure(errMess: "Somthing went wrong"));
    }
  }
}
