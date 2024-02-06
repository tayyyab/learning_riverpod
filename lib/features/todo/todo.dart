import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@immutable
class Todo {
  const Todo({
    required this.id,
    required this.description,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
        Todo(id: _uuid.v1(), description: 'Create App'),
        Todo(id: _uuid.v1(), description: 'Add Ads'),
        Todo(id: _uuid.v1(), description: 'Have a walk'),
      ];

  void add(String description) {
    state = [...state, Todo(id: _uuid.v1(), description: description)];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void eidt({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(id: todo.id, description: description, completed: todo.completed)
        else
          todo
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
