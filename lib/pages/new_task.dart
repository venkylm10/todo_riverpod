import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_riverpod/constants/app_style.dart';
import 'package:todo_riverpod/provider/radio_provider.dart';
import 'package:todo_riverpod/widgets/radio_widget.dart';

import '../widgets/date_time_widget.dart';
import '../widgets/text_field_widget.dart';

class AddNewTaskModal extends ConsumerWidget {
  const AddNewTaskModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final radioCategory = ref.watch(radioProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "New Todo Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Gap(12),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text(
            "Title",
            style: AppStyles.heading1,
          ),
          const Gap(6),
          const TextFieldWidget(
            hintText: "Add Task name",
            maxLines: 1,
          ),
          const Gap(12),
          const Text(
            "Description",
            style: AppStyles.heading1,
          ),
          const Gap(6),
          const TextFieldWidget(
            hintText: "Add Task description",
            maxLines: 5,
          ),
          const Gap(12),
          const Text(
            "Category",
            style: AppStyles.heading1,
          ),
          Row(
            children: [
              const Expanded(
                child: RadioWidget(
                  title: "LRN",
                  categoryColor: Colors.green,
                ),
              ),
              const Expanded(
                child: RadioWidget(
                  title: "WRK",
                  categoryColor: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: RadioWidget(
                  title: "GEN",
                  categoryColor: Colors.amberAccent.shade700,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              DateTimeWidget(
                title: "Date",
                icon: Icon(CupertinoIcons.calendar),
                valueText: "dd/mm/yy",
              ),
              Gap(24),
              DateTimeWidget(
                title: "Time",
                icon: Icon(CupertinoIcons.time),
                valueText: "hh : mm",
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {},
                  child: const Text("Cancel"),
                ),
              ),
              const Gap(22),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {},
                  child: const Text("Create"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
