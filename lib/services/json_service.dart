import 'dart:convert';

import '../models/todo.dart';

class JsonService {
  static String exportTodos(List<Todo> todos) {
    final list = todos.map((todo) => todo.toJson()).toList();
    return jsonEncode(list);
  }
}