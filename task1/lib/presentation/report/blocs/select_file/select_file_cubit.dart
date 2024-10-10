import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/domain/usecase/select_file.dart';
import 'package:task1/presentation/report/blocs/select_file/select_file_state.dart';
import 'package:task1/service_locator.dart';

class SelectFileCubit extends Cubit<SelectFileState> {
  SelectFileCubit() : super(SelectFileInitialState());

  Future<void> selectFile() async {
    try {
      emit(SelectFileLoading());

      var returnedData = await sl<SelectFileUsecase>().call();
      returnedData.fold((error) {
        emit(SelectFileFailure(errorMess: "An error occurred"));
      }, (data) {
        print(data.path.split('/').last);
        emit(SelectFileLoaded(file: data));
      });

    } catch (e) {
      emit(SelectFileFailure(errorMess: "Something went wrong"));
    }
  }
}