import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardTodoTile extends StatelessWidget {
  const CardTodoTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      "Learning Web Development",
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: const Text(
                      "HTML CSS and JavaScript",
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        value: true,
                        shape: const CircleBorder(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade200,
                  ),
                  const Row(
                    children: [
                      Text("Today"),
                      Gap(12),
                      Text("9:45 PM - 11:00 PM"),
                    ],
                  ),
                  const Gap(18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
