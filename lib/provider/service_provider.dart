import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/services/todo_services.dart';

final serviceProvider = StateProvider<TodoServices>((ref) => TodoServices());
