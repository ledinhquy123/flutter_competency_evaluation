import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/domain/entities/input_entity.dart';
import 'package:task4/domain/usecase/calculate.dart';
import 'package:task4/presentation/home/blocs/execute/execute_state.dart';
import 'package:task4/service_locator.dart';

class ExecuteCubit extends Cubit<ExecuteState> {
  ExecuteCubit() : super(ExecuteInitialState());

  Future<void> execute(InputEntity inputEntity) async {
    try {
      emit(ExecuteLoading());
      var returnedData = await sl<CalculateUsecase>().call(params: inputEntity);

      returnedData.fold((error) {
        emit(ExecuteFailure(errMess: error));
      }, (data) {
        print("Result == $data");
        emit(ExecuteLoaded(data: data));
      });
    } catch (e) {
      emit(ExecuteFailure(errMess: "An error occured"));
    }
  }
}
