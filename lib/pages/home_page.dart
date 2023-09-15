import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'new_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          subtitle: const Text(
            "Venkatesh",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
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
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
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
              Gap(18),
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(12)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Learning Web Development"),
                              subtitle: Text("HTML CSS and JavaScript"),
                              trailing: Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  activeColor: Colors.blue.shade800,
                                  value: true,
                                  shape: CircleBorder(),
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey.shade200,
                            ),
                            Row(
                              children: [
                                Text("Today"),
                                Gap(12),
                                Text("9:45 PM - 11:00 PM"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
