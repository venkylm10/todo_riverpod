import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String time;
  final bool isCompleted;
  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      id: doc['id'],
      title: doc['title'],
      description: doc['description'],
      category: doc['category'],
      date: doc['date'],
      time: doc['time'],
      isCompleted: doc['isCompleted'],
    );
  }
}
