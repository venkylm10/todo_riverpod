import 'package:flutter_riverpod/flutter_riverpod.dart';

final radioProvider =
    StateNotifierProvider<RadioCategory, int>((ref) => RadioCategory());

class RadioCategory extends StateNotifier<int> {
  RadioCategory() : super(0);

  void update(int value) {
    state = value;
  }
}
