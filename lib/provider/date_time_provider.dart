import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateProvider((ref) => 'dd/mm/yy c');

final timeProvider = StateProvider((ref) => 'hh : mm');
