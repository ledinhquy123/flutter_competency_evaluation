abstract class ExecuteState {}

class ExecuteInitialState extends ExecuteState {}

class ExecuteLoading extends ExecuteState {}

class ExecuteLoaded extends ExecuteState {
  final List<Map<String, int>> data;

  ExecuteLoaded({required this.data});
}

class ExecuteFailure extends ExecuteState {
  final String errMess;

  ExecuteFailure({required this.errMess});
}