import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final String valueText;
  const DateTimeWidget({
    super.key,
    required this.title,
    required this.valueText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.heading1,
          ),
          const Gap(6),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                icon,
                const Gap(12),
                Text(valueText),
              ],
            ),
          )
        ],
      ),
    );
  }
}
