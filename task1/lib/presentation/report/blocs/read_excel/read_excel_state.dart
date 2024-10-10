abstract class ReadExcelState {}

class ReadExcelInitialState extends ReadExcelState {}

class ReadExcelLoading extends ReadExcelState {}

class ReadExcelLoaded extends ReadExcelState {
  final Map<DateTime, double>? data;

  ReadExcelLoaded({required this.data});
}

class ReadExcelFailure extends ReadExcelState {
  final String errorMess;

  ReadExcelFailure({required this.errorMess});
}
