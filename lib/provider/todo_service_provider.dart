import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/models/todo_models.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';
import 'package:todo_riverpod/services/todo_services.dart';

final todoServiceProvider =
    StateProvider<TodoServices>((ref) => TodoServices());

final todoStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final authServices = ref.watch(authServicesProvider);
  final getData = authServices.users
      .doc(authServices.auth.currentUser!.uid)
      .collection('tasks')
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (snapshot) => TodoModel.fromSnapshot(snapshot),
            )
            .toList(),
      );
  yield* getData;
});
