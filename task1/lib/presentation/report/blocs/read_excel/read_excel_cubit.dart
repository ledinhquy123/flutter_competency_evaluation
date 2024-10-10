import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/domain/usecase/read_excel.dart';
import 'package:task1/presentation/report/blocs/read_excel/read_excel_state.dart';
import 'package:task1/service_locator.dart';

class ReadExcelCubit extends Cubit<ReadExcelState> {
  ReadExcelCubit() : super(ReadExcelInitialState());

  Future<void> readExcel(File file) async {
    try {
      emit(ReadExcelLoading());
      var returnedData = await sl<ReadExcelUsecase>().call(params: file);
      returnedData.fold((error) {
        emit(ReadExcelFailure(errorMess: error));
      }, (data) {
        emit(ReadExcelLoaded(data: data));
      });
    } catch (e) {
      emit(ReadExcelFailure(errorMess: "Something went wrong"));
    }
  }
}
