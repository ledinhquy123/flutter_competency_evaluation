import 'dart:convert';

import 'package:task4/data/models/query_model.dart';
import 'package:task4/domain/entities/input_entity.dart';

InputModel inputModelFromJson(String str) =>
    InputModel.fromJson(json.decode(str));

String inputModelToJson(InputModel data) => json.encode(data.toJson());

class InputModel {
  final String token;
  final List<int> data;
  final List<QueryModel> query;

  InputModel({
    required this.token,
    required this.data,
    required this.query,
  });

  factory InputModel.fromJson(Map<String, dynamic> json) => InputModel(
        token: json["token"],
        data: List<int>.from(json["data"].map((x) => x)),
        query: List<QueryModel>.from(
            json["query"].map((x) => QueryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "data": List<dynamic>.from(data.map((x) => x)),
        "query": List<dynamic>.from(query.map((x) => x.toJson())),
      };
}

extension InputModelX on InputModel {
  InputEntity toEntity() {
    return InputEntity(
        token: token,
        data: data,
        query: query.map((el) => el.toEntity()).toList());
  }
}
