import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_riverpod/models/todo_models.dart';

class TodoServices {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  // create
  void addNewTask(TodoModel todo) {
    try {
      todoCollection.add(todo.toMap());
    } catch (e) {
      print(e.toString());
    }
  }
}
