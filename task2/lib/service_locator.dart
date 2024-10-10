import 'package:get_it/get_it.dart';
import 'package:task2/data/repository/form_repository_impl.dart';
import 'package:task2/data/sources/form_service.dart';
import 'package:task2/domain/repository/form_repository.dart';
import 'package:task2/domain/usecase/update_data.dart';

final sl = GetIt.instance;

Future<void> initialDependencies() async {
  sl.registerSingleton<FormRepository>(FormRepositoryImpl());
  sl.registerSingleton<FormService>(FormServiceImpl());
  sl.registerSingleton<UpdateDataUsecase>(UpdateDataUsecase());
}