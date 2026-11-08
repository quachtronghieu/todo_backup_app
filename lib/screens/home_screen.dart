import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/json_service.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodo() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;

    setState(() {
      _todos.add(Todo(title: title));
    });

    _controller.clear();
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].done = !_todos[index].done;
    });
  }

  void _exportJson() {
    final jsonData = JsonService.exportTodos(_todos);
    print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Backup App'),
        actions: [
          IconButton(
            tooltip: 'Export JSON',
            icon: const Icon(Icons.save),
            onPressed: _exportJson,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Nhập công việc',
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                IconButton(
                  tooltip: 'Thêm Todo',
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: _todos.isEmpty
                ? const Center(child: Text('Chưa có công việc nào.'))
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];

                      return TodoItem(
                        todo: todo,
                        onTap: () => _toggleTodo(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}