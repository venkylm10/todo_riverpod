import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todo_riverpod/constants/firestore_constants.dart';
import 'package:todo_riverpod/main.dart';

import '../models/user_model.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;
  final users =
      FirebaseFirestore.instance.collection(FireStoreConstants.usersPath);
  void signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = auth.currentUser!.uid;
      users.doc(uid).set({
        'uid': uid,
        'name': name,
        'totalCategories': 3,
        'totalTasks': 2,
      });

      createDefualtData(context);
    } on FirebaseAuthException {}
    signInWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );
  }

  Future<UserModel> getUser() async {
    final userDoc = users.doc(auth.currentUser!.uid);
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data()!);
    } else {
      return UserModel(
        uid: 'uid',
        name: 'username',
        email: 'email',
        totalCategories: 0,
        totalTasks: 0,
      );
    }
  }

  void createDefualtData(BuildContext context) {
    final userRoot = FirebaseFirestore.instance
        .collection(FireStoreConstants.usersPath)
        .doc(auth.currentUser!.uid);

    userRoot.collection('categories').add({
      'title': "Learning",
      'color': 1,
    });
    userRoot.collection('categories').add({
      'title': "Work",
      'color': 2,
    });
    userRoot.collection('categories').add({
      'title': "General",
      'color': 3,
    });
    DocumentReference docRef1 = userRoot.collection('tasks').doc();
    DocumentReference docRef2 = userRoot.collection('tasks').doc();

    // Get the auto-generated ID and set it as the 'id' field in your document
    String docId1 = docRef1.id;
    String docId2 = docRef2.id;

    docRef1.set({
      'id': docId1,
      'title': "Add new task",
      'description': "Click on add new task button to add new task",
      'date': DateFormat('dd/MM/yy').format(DateTime.now()),
      'time': TimeOfDay.now().format(context),
      'category': "General",
      'isCompleted': false,
    });
    docRef2.set({
      'id': docId2,
      'title': "delete a task",
      'description': "Swipe left to delete a task",
      'date': DateFormat('dd/MM/yy').format(DateTime.now()),
      'time': TimeOfDay.now().format(context),
      'category': "General",
      'isCompleted': false,
    });
  }

  void signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {}
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print('google log in successfull');

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print('got user credentials');
      if (userCredential.additionalUserInfo!.isNewUser) {
        String uid = userCredential.user!.uid;
        users.doc(uid).set({
          'uid': uid,
          'name': googleUser!.displayName ?? "googleUser",
          'totalCategories': 3,
          'totalTasks': 2,
        });

        createDefualtData(context);
      }
    } catch (e) {}
  }

  void signOut() async {
    try {
      await auth.signOut();
      final googleSignIn = GoogleSignIn();
      googleSignIn.disconnect();
    } on FirebaseAuthException {}
  }
}
