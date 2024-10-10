abstract class UpdateButtonState {}

class UpdateButtonInitialState extends UpdateButtonState {}

class UpdateButtonLoading extends UpdateButtonState {}

class UpdateButtonLoaded extends UpdateButtonState {
  final String successMess;

  UpdateButtonLoaded({required this.successMess});
}

class UpdateButtonFailure extends UpdateButtonState {
  final String errorMess;

  UpdateButtonFailure({required this.errorMess});
}