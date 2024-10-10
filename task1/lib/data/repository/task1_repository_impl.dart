import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task1/data/models/resolve/resolve_req.dart';
import 'package:task1/data/sources/task1_service.dart';
import 'package:task1/domain/repository/task1_repository.dart';
import 'package:task1/service_locator.dart';

class Task1RepositoryImpl implements Task1Repository {
  @override
  Future<Either> readExcel(File file) async {
    return await sl<Task1Service>().readExcel(file);
  }
  
  @override
  Future<Either> selectFile() async {
    return await sl<Task1Service>().selectFile();
  }

  @override
  Future<Either> resolve(ResolveReq resolveReq) async {
    return await sl<Task1Service>().resolve(resolveReq);
  }
}