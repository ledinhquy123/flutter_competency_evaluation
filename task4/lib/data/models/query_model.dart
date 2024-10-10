import 'dart:convert';

import 'package:task4/domain/entities/query_entity.dart';

QueryModel queryModelFromJson(String str) =>
    QueryModel.fromJson(json.decode(str));

String queryModelToJson(QueryModel data) => json.encode(data.toJson());

class QueryModel {
  final String type;
  final List<int> range;

  QueryModel({
    required this.type,
    required this.range,
  });

  factory QueryModel.fromJson(Map<String, dynamic> json) => QueryModel(
        type: json["type"],
        range: List<int>.from(json["range"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "range": List<dynamic>.from(range.map((x) => x)),
      };
}

extension QueryModelX on QueryModel {
  QueryEntity toEntity() {
    return QueryEntity(type: type, range: range);
  }
}
