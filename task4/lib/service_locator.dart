import 'package:get_it/get_it.dart';
import 'package:task4/data/repository/task4_repository_impl.dart';
import 'package:task4/data/sources/task4_service.dart';
import 'package:task4/domain/repository/task4.dart';
import 'package:task4/domain/usecase/calculate.dart';
import 'package:task4/domain/usecase/get_data.dart';
import 'package:task4/domain/usecase/send_data.dart';

final sl = GetIt.instance;

Future<void> initialDependencies() async {
  //? Task 4
  sl.registerSingleton<Task4Repository>(Task4RepositoryImpl());
  sl.registerSingleton<Task4Service>(Task4ServiceImpl());
  sl.registerSingleton<GetDataUsecase>(GetDataUsecase());
  sl.registerSingleton<CalculateUsecase>(CalculateUsecase());
  sl.registerSingleton<SendDataUsecase>(SendDataUsecase());
}