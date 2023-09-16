import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_riverpod/constants/app_style.dart';
import 'package:todo_riverpod/models/todo_models.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';
import 'package:todo_riverpod/provider/date_time_provider.dart';
import 'package:todo_riverpod/provider/radio_provider.dart';
import 'package:todo_riverpod/provider/todo_service_provider.dart';
import 'package:todo_riverpod/widgets/radio_widget.dart';
import '../widgets/date_time_widget.dart';
import '../widgets/text_field_widget.dart';

class AddNewTaskModal extends ConsumerStatefulWidget {
  const AddNewTaskModal({
    super.key,
  });

  @override
  ConsumerState<AddNewTaskModal> createState() => _AddNewTaskModalState();
}

class _AddNewTaskModalState extends ConsumerState<AddNewTaskModal> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  final category = ['Learning', 'Work', 'General'];
  final colors = [Colors.green, Colors.blueAccent, Colors.amberAccent];

  @override
  Widget build(BuildContext context) {
    final authServices = ref.watch(authServicesProvider);
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          TextFieldWidget(
            title: "Title",
            hintText: "Add Task name",
            maxLines: 1,
            controller: titleController,
          ),
          const Gap(12),
          TextFieldWidget(
            title: "Description",
            hintText: "Add Task description",
            maxLines: 5,
            controller: descriptionController,
          ),
          const Gap(12),
          const Text(
            "Category",
            style: AppStyles.heading1,
          ),
          Wrap(
            children: List.generate(
              category.length,
              (index) {
                return RadioWidget(
                  title: category[index],
                  categoryColor: colors[index],
                  valueInput: index + 1,
                );
              },
            ),
          ),
          const Gap(12),
          Row(
            children: [
              DateTimeWidget(
                title: "Date",
                icon: const Icon(CupertinoIcons.calendar),
                valueText: dateProv,
                onTap: () async {
                  final getDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (getDate != null) {
                    final format = DateFormat('dd/MM/yy');
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getDate));

                    print(format.format(getDate));
                  }
                },
              ),
              const Gap(24),
              DateTimeWidget(
                title: "Time",
                icon: const Icon(CupertinoIcons.time),
                valueText: timeProv,
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (getTime != null) {
                    ref.read(timeProvider.notifier).update(
                          (state) => getTime.format(context),
                        );
                  }
                },
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
                  onPressed: () => Navigator.pop(context),
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
                  onPressed: () {
                    final docRef = authServices.users
                        .doc(authServices.auth.currentUser!.uid)
                        .collection('tasks')
                        .doc();

                    final String docId = docRef.id;
                    ref.read(todoServiceProvider).addNewTask(
                          TodoModel(
                            id: docId,
                            title: titleController.text,
                            description: descriptionController.text,
                            category: category[ref.read(radioProvider)],
                            date: dateProv,
                            time: timeProv,
                            isCompleted: false,
                          ),
                        );
                    titleController.clear();
                    descriptionController.clear();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => 'dd/mm/yy');
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => 'hh : mm');
                    Navigator.pop(context);
                    ref.read(radioProvider.notifier).update(0);
                    print("todo added");
                  },
                  child: const Text("Create"),
                ),
              ),
            ],
          ),
          const Gap(24),
        ],
      ),
    );
  }
}
