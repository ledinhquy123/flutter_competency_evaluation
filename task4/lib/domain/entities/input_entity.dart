import 'package:task4/domain/entities/query_entity.dart';

class InputEntity {
  final String token;
  final List<int> data;
  final List<QueryEntity> query;
  
  InputEntity({
    required this.token,
    required this.data,
    required this.query,
  });
}
