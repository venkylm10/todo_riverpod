import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';
import 'package:todo_riverpod/services/auth_services.dart';

import '../models/user_model.dart';

final userProvider = StreamProvider<UserModel>((ref) async* {
  final authServices = ref.watch(authServicesProvider);
  final getData = authServices.users
      .doc(authServices.auth.currentUser!.uid)
      .snapshots()
      .map(
        (snapshot) => UserModel.fromSnapshot(snapshot),
      );
  yield* getData;
});

// final todoStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
//   final authServices = ref.read(authServicesProvider);
//   final getData = authServices.userRoot.collection('tasks').snapshots().map(
//         (event) => event.docs
//             .map(
//               (snapshot) => TodoModel.fromSnapshot(snapshot),
//             )
//             .toList(),
//       );
//   yield* getData;
// });
