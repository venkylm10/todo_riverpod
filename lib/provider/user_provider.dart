import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';


final userProvider = StreamProvider<DocumentSnapshot<Map<String, dynamic>>>((ref) async* {
  final authServices = ref.watch(authServicesProvider);
  final getData = authServices.users
      .doc(authServices.auth.currentUser!.uid)
      .snapshots();
  yield* getData;
});
