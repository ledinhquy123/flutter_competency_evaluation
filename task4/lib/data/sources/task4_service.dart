import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:task4/core/constants/app_constants.dart';
import 'package:task4/data/models/input_model.dart';
import 'package:task4/domain/entities/input_entity.dart';
import 'package:task4/domain/entities/query_entity.dart';

abstract class Task4Service {
  Future<Either> getData();
  Either calculate(InputEntity input);
  Future<Either> sendData(List<Map<String, int>> data);
}

class Task4ServiceImpl implements Task4Service {
  final storage = GetStorage();

  @override
  Future<Either> getData() async {
    try {
      var response = await http.get(Uri.parse(AppConstants.inputUrl));

      if (response.statusCode == 200) {
        print(response.body);
        var returnedData = inputModelFromJson(response.body);
        storage.write('token', returnedData.token);
        return Right(returnedData.toEntity());
      } else {
        return const Left("Get data failed");
      }
    } catch (e) {
      return const Left("An error occurred");
    }
  }

  @override
  Either calculate(InputEntity input) {
    List<int> a = input.data;
    List<QueryEntity> querys = input.query;

    List<int> b = [];
    List<int> c = [];
    b.add(a[0]);
    c.add(a[0]);

    //! O(n)
    for (var i = 1; i < a.length; i++) {
      b.add(b[i - 1] + a[i]);
      if (i % 2 == 0) {
        c.add(c[i - 1] + a[i]);
      } else {
        c.add(c[i - 1] - a[i]);
      }
    }

    List<Map<String, int>> result = [];
    //! O(q)
    for (var j = 0; j < querys.length; j++) {
      var query = querys[j];
      int l = query.range.first;
      int r = query.range.last;
      if (query.type == '1') {
        if (l == 0) {
          result.add({
            "Query ${j + 1}": b[l],
          });
        } else {
          result.add({
            "Query ${j + 1}": b[r] - b[l - 1],
          });
        }
      } else if (query.type == '2') {
        if (l == 0) {
          result.add({
            "Query ${j + 1}": c[r],
          });
        } else {
          result.add({
            "Query ${j + 1}": c[r] - c[l - 1],
          });
        }
      }
    }

    if (result.isEmpty) {
      return const Left("Tính toán không thành công");
    }
    return Right(result);
  }

  @override
  Future<Either> sendData(List<Map<String, int>> data) async {
    try {
      var response = await http.post(Uri.parse(AppConstants.outUrl),
          headers: {
            "Authorization": "Bearer ${storage.read("token")}",
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        print(response.body);
        return const Right("Data was sent successfully");
      } else {
        return const Left("Sent data failed");
      }
    } catch (e) {
      return const Left("An error occurred");
    }
  }
}
