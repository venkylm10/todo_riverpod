import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/services/auth_services.dart';

final authServicesProvider = StateProvider((ref) => AuthServices());
