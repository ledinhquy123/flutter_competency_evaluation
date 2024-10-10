import 'dart:io';

abstract class SelectFileState {}

class SelectFileInitialState extends SelectFileState {}

class SelectFileLoading extends SelectFileState {}

class SelectFileLoaded extends SelectFileState {
  final File? file;

  SelectFileLoaded({required this.file});
}

class SelectFileFailure extends SelectFileState {
  final String errorMess;

  SelectFileFailure({required this.errorMess});
}