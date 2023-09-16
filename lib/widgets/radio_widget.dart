import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_riverpod/constants/app_style.dart';
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
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: categoryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              activeColor: categoryColor,
              value: valueInput,
              groupValue: radioCategory,
              onChanged: (value) {
                ref.read(radioProvider.notifier).update(value!);
                print("radio at value" + value.toString());
              },
            ),
            GestureDetector(
              onTap: () {
                ref.read(radioProvider.notifier).update(valueInput);
                print("radio at value" + valueInput.toString());
              },
              child: Text(
                title,
                style: AppStyles.heading1.copyWith(
                  color: categoryColor,
                ),
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
