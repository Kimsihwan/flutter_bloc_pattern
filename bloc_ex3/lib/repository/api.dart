import 'dart:convert';

import 'package:bloc_ex3/model/todo.dart';
import 'package:http/http.dart' as http;

class API {
  final http.Client _client = http.Client();

  static const String _url = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Todo>> getTodo() async {
    List<Todo> list = [];

    await _client
        .get(Uri.parse(_url))
        .then((res) => res.body)
        .then(json.decode)
        .then(
            (todos) => todos.forEach((todo) => list.add(Todo.fromJson(todo))));
    return list;
  }
}
