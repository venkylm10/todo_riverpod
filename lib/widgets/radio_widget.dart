import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  final String title;
  final Color categoryColor;
  final int valueInput;
  const RadioWidget({
    super.key,
    required this.title,
    required this.categoryColor,
    required this.valueInput,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: categoryColor,
        ),
        child: RadioListTile(
          activeColor: categoryColor,
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
              offset: const Offset(-22, 0),
              child: Text(
                title,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.w700,
                ),
              )),
          value: valueInput,
          groupValue: radioCategory,
          onChanged: (value) {
            ref.read(radioProvider.notifier).update(value!);
          },
        ),
      ),
    );
  }
}
