abstract class ResolveState {}

class ResolveInitialState extends ResolveState {}

class ResolveLoading extends ResolveState {}

class ResolveLoaded extends ResolveState {
  final double totalPrice;

  ResolveLoaded({required this.totalPrice});
}

class ResolveFailure extends ResolveState {
  final String errorMess;

  ResolveFailure({required this.errorMess});
}