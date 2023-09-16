import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_riverpod/constants/app_style.dart';
import 'package:todo_riverpod/models/todo_models.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';
import 'package:todo_riverpod/provider/color_provider.dart';
import 'package:todo_riverpod/provider/todo_service_provider.dart';
import 'package:todo_riverpod/services/auth_services.dart';

class CardTodoTile extends ConsumerWidget {
  final TodoModel todo;
  const CardTodoTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(colorProvider);
    final todoServices = ref.watch(todoServiceProvider);
    final authServices = ref.watch(authServicesProvider);
    return Container(
      height: 130,
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Slidable(
        direction: Axis.horizontal,
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                print(todo.id);
                todoServices.deleteATask(todo.id);
              },
              backgroundColor: Colors.white,
              foregroundColor: colors[todo.category],
              icon: Icons.delete_rounded,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(12),
              ),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              decoration: BoxDecoration(
                color: colors[todo.category],
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(12)),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        todo.title,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.heading1.copyWith(fontSize: 18),
                      ),
                      subtitle: Text(
                        todo.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          activeColor: colors[todo.category],
                          value: todo.isCompleted,
                          shape: const CircleBorder(),
                          onChanged: (value) {
                            final docRef = authServices.users
                                .doc(authServices.auth.currentUser!.uid)
                                .collection('tasks')
                                .doc(todo.id);

                            docRef.update({'isCompleted': !todo.isCompleted});
                          },
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        DateFormat('dd/MM/yy').format(DateTime.now()) ==
                                todo.date
                            ? Text("Today")
                            : Text(todo.date),
                        const Gap(12),
                        Text(todo.time),
                      ],
                    ),
                    const Gap(18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
