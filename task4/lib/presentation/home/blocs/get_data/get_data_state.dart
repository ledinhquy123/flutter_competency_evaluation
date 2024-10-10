import 'package:task4/domain/entities/input_entity.dart';

abstract class GetDataState {}

class GetDataInitialState extends GetDataState {}

class GetDataLoading extends GetDataState {}

class GetDataLoaded extends GetDataState {
  final InputEntity inputEntity;

  GetDataLoaded({required this.inputEntity});
}

class GetDataFailure extends GetDataState {
  final String errMess;

  GetDataFailure({required this.errMess});
}