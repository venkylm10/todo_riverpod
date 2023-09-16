import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_riverpod/constants/app_style.dart';
import 'package:todo_riverpod/provider/auth_service_provider.dart';
import 'package:todo_riverpod/provider/todo_service_provider.dart';
import 'package:todo_riverpod/provider/user_provider.dart';
import 'package:todo_riverpod/widgets/card_todo_tile.dart';

import 'new_task.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authServices = ref.read(authServicesProvider);
    final todoList = ref.watch(todoStreamProvider);
    final userModel = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset('assets/images/profile_pic.png'),
          ),
          title: const Text(
            "Hello,",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          subtitle: userModel.when(
            data: (userModel) {
              return Text(
                userModel.name,
                style: AppStyles.heading1,
              );
            },
            loading: () {
              return Text(
                "username",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              );
            },
            error: (error, stackTrace) {
              return Text(
                "username",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {
                    authServices.signOut();
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Tasks",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Friday, 15 Sep",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xffd5e8fa),
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      context: context,
                      builder: (context) {
                        return const AddNewTaskModal();
                      },
                    ),
                    child: const Text("+ New Task"),
                  )
                ],
              ),
              const Gap(18),
              todoList.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardTodoTile(todo: data[index]);
                    },
                  );
                },
                error: (error, stackTrack) {
                  return Text(error.toString());
                },
                loading: () {
                  return Center(
                    child: Text("loading"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
