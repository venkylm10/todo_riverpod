import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final String valueText;
  final VoidCallback onTap;
  const DateTimeWidget({
    super.key,
    required this.title,
    required this.valueText,
    required this.icon,
    required this.onTap,
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
          Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => onTap(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      icon,
                      const Gap(6),
                      Text(valueText),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
