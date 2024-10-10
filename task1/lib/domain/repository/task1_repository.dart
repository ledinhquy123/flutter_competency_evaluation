import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:task1/data/models/resolve/resolve_req.dart';

abstract class Task1Repository {
  Future<Either> readExcel(File file);
  Future<Either> selectFile();
  Future<Either> resolve(ResolveReq resolveReq);
}