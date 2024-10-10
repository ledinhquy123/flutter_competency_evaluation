abstract class SendDataState {}

class SendDataInitialState extends SendDataState {}

class SendDataLoading extends SendDataState {}

class SendDataLoaded extends SendDataState {
  final String successMess;

  SendDataLoaded({required this.successMess});
}

class SendDataFailure extends SendDataState {
  final String errorMess;

  SendDataFailure({required this.errorMess});
}