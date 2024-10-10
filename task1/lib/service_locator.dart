import 'package:get_it/get_it.dart';
import 'package:task1/data/repository/task1_repository_impl.dart';
import 'package:task1/data/sources/task1_service.dart';
import 'package:task1/domain/repository/task1_repository.dart';
import 'package:task1/domain/usecase/read_excel.dart';
import 'package:task1/domain/usecase/resolve.dart';
import 'package:task1/domain/usecase/select_file.dart';

final sl = GetIt.instance;

Future<void> initialDependencies() async {
  sl.registerSingleton<Task1Repository>(Task1RepositoryImpl());
  sl.registerSingleton<Task1Service>(Task1ServiceImpl());
  sl.registerSingleton<ReadExcelUsecase>(ReadExcelUsecase());
  sl.registerSingleton<SelectFileUsecase>(SelectFileUsecase());
  sl.registerSingleton<ResolveUsecase>(ResolveUsecase());
}