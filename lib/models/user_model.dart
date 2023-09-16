import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final int totalCategories;
  final int totalTasks;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.totalCategories,
    required this.totalTasks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'totalCategories': totalCategories,
      'totalTasks': totalTasks,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : 'uid',
      name: map['name'] as String,
      email: map['email'] ?? 'email',
      totalCategories: map['totalCategories'] as int,
      totalTasks: map['totalTasks'] as int,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      totalCategories: data['totalCategories'],
      totalTasks: data['totalTasks'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? totalCategories,
    int? totalTasks,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      totalCategories: totalCategories ?? this.totalCategories,
      totalTasks: totalTasks ?? this.totalTasks,
    );
  }
}
