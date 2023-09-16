import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_riverpod/models/todo_models.dart';

import '../constants/firestore_constants.dart';

class TodoServices {
  final todoCollection = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  final users =
      FirebaseFirestore.instance.collection(FireStoreConstants.usersPath);
  // create
  void addNewTask(TodoModel todo) {
    try {
      final docRef =
          users.doc(auth.currentUser!.uid).collection('tasks').doc(todo.id);
      docRef.set(todo.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteATask(String taskId) {
    try {
      print(taskId);
      users.doc(auth.currentUser!.uid).collection('tasks').doc(taskId).delete();
      print("deletion complete");
    } catch (e) {
      print("failed deletion");
      print(e.toString());
    }
  }
}
