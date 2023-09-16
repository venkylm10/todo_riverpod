import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String? docId;
  final String title;
  final String description;
  final String category;
  final String date;
  final String time;
  TodoModel({
    this.docId,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
    };
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docId: doc.id,
      title: doc['title'],
      description: doc['description'],
      category: doc['category'],
      date: doc['date'],
      time: doc['time'],
    );
  }
}
