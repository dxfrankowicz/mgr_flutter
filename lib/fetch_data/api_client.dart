import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mgr_flutter/fetch_data/task_entry_model.dart';


class ApiClient{

  final String url = "https://jsonplaceholder.typicode.com/todos";

  Future<TaskEntryRsp> fetchData() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TaskEntryRsp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Niepoprawny URL, błąd pobierania danych");
    }
  }
}